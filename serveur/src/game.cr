require "./player.cr"
require "./board.cr"

class Cerbere::Game
	getter players : Array(Player)
	getter active = false
	property board : Board = Board.new(0, [] of Player)
	property difficulty : Int32 = 3
	property number_players : Int32 = 3
	property active_player : Int32 = 0
	property nb_turns : Int32 = 1
	property action_played : Bool = false
	property bonus_played : Bool = false
	property finished : Bool = false
	
	def initialize()
		@players = [] of Player
	end
	
	def <<(player : Player)
		i = Colour::Cyan
		until check_colour(i)
			i = i+1
		end
		player.colour=i
		@players << player
	end
	
	def send_all(response : Response)
		@players.each do |player|
			player.send response
		end
	end
	
	def check_players()
		if @players.size==@number_players
			if @players.all? &.ready == true
				@active = true
			end
		end
		@active
	end
	
	def check_colour(colour : Cerbere::Colour)
		@players.all? { |player| player.colour != colour}
	end
	
	def play_action(player : Player, num_card : Int32, effect : Int32, args : Array(Int32))
		player.hand.action[num_card] = false
		card = Hand.actions_of(player.type)[num_card]
		choice = card.choix[effect]
		board.faire_action(player, choice.cout, args)
		if ((choice.cout.evenement == Evenement::DEPLACER_AUTRE) || (choice.cout.evenement == Evenement::DEFAUSSER_MOI))
			args.shift()
		end
		choice.effets.each_index do |i|
			if args.size == 0 && (choice.effets[i].evenement == Evenement::DEPLACER_AUTRE || choice.effets[i].evenement == Evenement::PIOCHER_ALLIE)
				break
			end
			board.faire_action(player, choice.effets[i], args)
			if args.size != 0
				args.shift()
			end
		end
	end
	
	def play_bonus(player : Player, card : String, effect : Int32, args : Array(Int32))
		player.hand.bonus.each do |bonus_card|
			if bonus_card.name == card
				choice = bonus_card.choix[effect]
				board.faire_action(player, choice.cout, args)
				if (choice.cout.evenement == Evenement::DEFAUSSER_MOI)
					args.shift(choice.cout.force)
				end
				choice.effets.each_index do |i|
					if args.size == 0 && (choice.effets[i].evenement == Evenement::DEPLACER_AUTRE || choice.effets[i].evenement == Evenement::PIOCHER_ALLIE)
						break
					end
					board.faire_action(player, choice.effets[i], args)
					if args.size != 0
						args.shift()
					end
				end
				break
			end
		end
		
		index_card = 0
		player.hand.bonus.each do |bonus_card|
			if bonus_card.name == card
				board.defausser(player, index_card)
				player.send(Response::DiscardBonus.new(bonus_card.name))
				break
			end
			index_card += 1
		end
	end
	
	def new_turn()
		if (!@action_played)
			play_action(players[active_player], 0, 0, [] of Int32)
		end
		
		board.pont_queue.each do |plyr|
			id_pont = board.nodes[plyr[0].position].effect.force
			plyr[0].position += id_pont == 1 ? -1 : 1 
			plyr[1][0] -= 1
			new_force = id_pont == 1 ? plyr[1][0] * (-1) : plyr[1][0]
			board.action_deplacer_moi(plyr[0], new_force)
		end
		board.pont_queue.clear()
		
		board.portal_queue.each do |plyr|
			id_portal = board.nodes[plyr[0].position].effect.force
			plyr[0].position += id_portal == 1 ? -1 : 1 
			plyr[1][0] -= 1
			new_force = id_portal == 1 ? plyr[1][0] * (-1) : plyr[1][0]
			board.action_deplacer_moi(plyr[0], new_force)
		end
		board.portal_queue.clear()
		
		loop do
			@active_player += 1
			@active_player %= players.size
			break if players[active_player].type != TypeJoueur::MORT
		end
		@nb_turns += 1
		@action_played = false
		@bonus_played = false
		board.cerbere_hunting()
		
		send_all(Response::UpdateBoard.new(players, board.position_cerbere, board.vitesse_cerbere, board.rage_cerbere, board.pont, active_player))
		spawn do 
			save = @nb_turns
			sleep(60)
			if !@finished && save == @nb_turns
				new_turn()
			end
		end
		#a chaque fin de tour il faut checker la fin de la partie
		finish(@players)
	end
	
	def start(@difficulty, @players)
		@number_players = players.size
		@board = Board.new(@difficulty, @players)
		send_all(Response::UpdateBoard.new(players, board.position_cerbere, board.vitesse_cerbere, board.rage_cerbere, board.pont, active_player))
		spawn do 
			save = @nb_turns
			sleep(30)
			if !@finished && save == @nb_turns
				new_turn()
			end
		end
	end
	
	def finish(@players)
		nb_loosers = 0
		nb_winners = 0
		nb_rest_in_game = 0
		@players.each do |p|
			if(p.type != TypeJoueur::AVENTURIER)
				nb_loosers += 1
			elsif(p.position == @board.nodes.size()-1)
				nb_winners += 1
			else 
				nb_rest_in_game += 1
			end
		end
		
		if(nb_loosers==@players.size())
			@players.each do |p|
				if(p.type == TypeJoueur::MORT)
					p.send(Response::EliminatePlayer.new([p]))
				elsif(p.type == TypeJoueur::CERBERE)
					p.send(Response::SurvivorWin.new([p]))
				else 
					p.send(Response::AdventurerLose.new([p]))
					
				end
			end
			return 
		end
		
		if(@board.barques.size() == 1) #reveal barque
			if(@board.action_verif_barque())
				if(nb_rest_in_game > 0)
					@players.each do |p|
						if(p.type == TypeJoueur::MORT)
							p.send(Response::EliminatePlayer.new([p]))
						elsif(p.type == TypeJoueur::CERBERE)
							p.send(Response::SurvivorLose.new([p]))
						else 
							if(p.position == @board.nodes.size() - 1)
								p.send(Response::AdventurerWin.new([p]))
							else
								p.send(Response::AdventurerLose.new([p]))
							end
						end
					end
				else 
					@players.each do |p|
						if(p.type == TypeJoueur::MORT)
							p.send(Response::EliminatePlayer.new([p]))
						elsif(p.type == TypeJoueur::CERBERE)
							p.send(Response::SurvivorLose.new([p]))
						else 
							p.send(Response::AdventurerWin.new([p]))
						end
					end
				end
			else 
				if(@board.barques[0] > nb_rest_in_game)
					@players.each do |p|
						if(p.type == TypeJoueur::MORT)
							p.send(Response::EliminatePlayer.new([p]))
						elsif(p.type == TypeJoueur::CERBERE)
							p.send(Response::SurvivorWin.new([p]))
						else 
							p.send(Response::AdventurerLose.new([p]))
						end
					end
				end
			end
		end
	end
end
