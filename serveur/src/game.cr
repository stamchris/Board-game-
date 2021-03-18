require "./player.cr"
require "./board.cr"

class Cerbere::Game
	getter players : Array(Player)
	getter active = false
	property board : Board = Board.new(0, [] of Player)
    getter difficulty : Int32 = 0
    getter number_players : Int32 = 0
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
		if @players.size>=3
			if @players.all? &.ready == true
				@active = true
			end
		end
		@active
	end

	def check_colour(colour : Cerbere::Colour)
		@players.all? { |player| player.colour != colour}
	end

	def play_action(player : Player, card : Int32, choice : Int32)
		player.hand.action[card] = false
		card = Hand.actions_of(player.type)[card]
		choice = card.choix[choice]
		args : Array(Int32) = [] of Int32
		board.faire_action(player, choice.cout, args)
		choice.effets.each_index do |i|
			board.faire_action(player, choice.effets[i], args)
		end
	end

	def new_turn()
		if (!@action_played)
			play_action(players[active_player], 0, 0)
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

		@active_player += 1
		@active_player %= players.size
		@nb_turns += 1
		@action_played = false
		@bonus_played = false
		send_all(Response::UpdateBoard.new(players, board.position_cerbere, board.vitesse_cerbere, board.rage_cerbere, board.pont, active_player))
		spawn do 
			save = @nb_turns
			sleep(30)
			if !@finished && save == @nb_turns
				new_turn()
			end
		end
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
end
