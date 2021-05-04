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
	property connection_string : String = ""

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
	
	def convert(player : Player, effect : Effet, args : Array(String)) : Array(Int32)
		new_args : Array(Int32) = [] of Int32
		n : Int32
		if(effect.evenement == Evenement::PIOCHER_ALLIE ||
		   effect.evenement == Evenement::DEFAUSSER_SURVIE ||
		   effect.evenement == Evenement::DEPLACER_AUTRE)
			# Les arguments sont des joueurs
			args.each do |arg|
				players.each do |plyr|
					if arg == plyr.colour.to_s
						new_args << plyr.lobby_id
						break
					end
				end
			end
		elsif(effect.evenement == Evenement::DEFAUSSER_MOI)
			# Les arguments sont des cartes
			args.each do |arg|
				player.hand.bonus.each_index do |i|
					if (player.hand.bonus[i].name == arg)
						new_args << i
						break
					end
				end
			end
		elsif(effect.evenement == Evenement::BARQUE)
			# Les arguments sont des index de barques
			args.each do |arg|
				new_args << arg.to_i32()
			end
		end
		# Les autres évènements soit n'ont pas d'arguments, soit
		# n'existent pas en tant qu'effet de cartes
		return new_args
	end
	
	def convert(player : Player, choice : Choix, args : Array(Array(String))) : Array(Array(Int32))
		res : Array(Array(Int32)) = [] of Array(Int32)
		res << convert(player, choice.cout, args[0])
		choice.effets.each_index do |i|
			res << convert(player, choice.effets[i], args[i+1])
		end
		return res
	end

	def new_turn_if_all_set(player : Player, skip : Bool = false)
		if((skip || (action_played && (bonus_played || player.hand.bonus_size == 0))) &&
				board.pont_queue.empty?() && board.portal_queue.empty?() &&
				board.awaiting_players.empty?())
			new_turn()
		end
	end

	def new_turn()
		if(@finished == true)
			return 
		end

		if (!@action_played)
			board.play_card(players[active_player], true, 0, 0, [[0],[0],[0]])
			@action_played = true
		end

		# Les aventuriers sabotés ont le droit à 30 secondes
		# supplémentaires pour faire leurs choix
		if(!board.awaiting_players.empty?())
			spawn do
				save = @nb_turns
				sleep(30)
				if(!@finished && save == @nb_turns)
					board.awaiting_players.each do |player|
						if(board.wait_origin == 0)
							card_index : Int32 = Random.rand(0..player.hand.bonus.size())
							card_name : String = player.hand.bonus[card_index].name
							board.defausser(player, card_index)
							player.send(Response::DiscardBonus.new(card_name))
						elsif(board.wait_origin == 1)
							board.action_deplacer_moi(player, -2)
						end
					end
					board.awaiting_players.clear()
					new_turn()
				end
			end
			return
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

		board.cerbere_hunting()
		
		loop do
			@active_player += 1
			@active_player %= players.size
			break if players[active_player].type != TypeJoueur::MORT
		end
		@nb_turns += 1
		@action_played = false
		@bonus_played = false
		

		send_all(Response::UpdateBoard.new(players, board.position_cerbere, board.vitesse_cerbere, board.rage_cerbere, board.pont, active_player))
		send_all(Response::NextTurn.new())
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
		status_s_c = [] of Int32 #s pour status survivants c pour pour cerbere
		status_s_c << 0
		players.each do |p|
			if(p.type != TypeJoueur::AVENTURIER)
				nb_loosers += 1
			elsif(p.position == @board.nodes.size()-1)
				nb_winners += 1
			else 
				nb_rest_in_game += 1
			end
			status_s_c << 0

		end
		
		if(nb_loosers==@players.size())
			status_s_c[0] = 1
			i = 0
			@players.each do |p|
				status_s_c[i+1] = 1
				i += 1
			end
			@players.each do |p|
				p.send(Response::StatusPlayer.new(players,status_s_c,p))
			end
			@finished = true
			return 
		end
		
		if(@board.barques.size() == 1) #reveal barque
			if(@board.action_verif_barque()) #checker quels aventuriers ont perdus et lesquels ont gagné
				status_s_c[0] = 0
				i = 0
				@players.each do |p|
					if(p.position != @board.nodes.size - 1)
						if(p.type == TypeJoueur::CERBERE)
							status_s_c[i+1] = 0
						else 	
							status_s_c[i+1] = 1
						end
					else
						status_s_c[i+1] = 0
					end
					i += 1
				end
				@players.each do |p|
					p.send(Response::StatusPlayer.new(players,status_s_c,p))
				end
				@finished = true
				return 
			else 
				if((board.barques[0]-(nb_winners)) > nb_rest_in_game)
					status_s_c[0] = 1
					i = 0
					@players.each do |p|
						status_s_c[i+1] = 1
						i += 1
					end
					@players.each do |p|
						p.send(Response::StatusPlayer.new(players,status_s_c,p))
					end
					@finished = true
					return 
				end
			end
		end
	end
end