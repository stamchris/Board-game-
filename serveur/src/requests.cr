require "./game.cr"

class Cerbere::Request
	include JSON::Serializable

	use_json_discriminator "type", {
		login: Login,
		ready: Ready,
		change_colour: ChangeColour,
		play_action: PlayAction,
		change_position: ChangePosition
	}
	
	def handle(game : Game, player : Player)
	end

	class Login < Request
		property type = "login"
		property name : String

		def handle(game : Game, player : Player)
			player.name = @name
			game << player

			game.send_all Response::NewPlayer.new player

			player.send(Response::Welcome.new game.players)
		end
	end

	class Ready < Request
		property type = "ready"

		def handle(game : Game, player : Player)
			player.ready = !player.ready
			if game.check_players()
				id = 0
				game.players.each do |player|
					player.lobby_id = id
					id += 1
				end
				game.send_all(Response::Starter.new(game.players, game.difficulty))
				game.start(0, game.players)
			end
		end
	end

	class ChangeColour < Request
		property type = "changeColour"
		property colour : Cerbere::Colour

		def handle(game : Game, player : Player)
			pp game.players.to_json
			if game.check_colour(@colour)
				player.colour = @colour
				game.send_all(Response::UpdatePlayer.new(player))
			#Fixme : envoyer une resynchronisation sinon
			end
		end
	end

	class ChangePosition < Request
		property type = "changePosition"
		property change : Int32
		property login : String

		def handle(game : Game, player : Player)
			game.players.each do |player|
				if (player.name == @login)
					player.position += change
					game.send_all(Response::UpdatePosition.new(player))
				end
			end
		end
	end

	class PlayAction < Request
		property type = "playAction"
		property effet : Int32
		property carte : String

		def play_action(game : Game, player : Player, card : Int32, choice : Int32)
			player.hand.action[card] = false
			card = Hand.actions_of(player.type)[card]
			choice = card.choix[choice]
			args : Array(Int32) = [] of Int32
			game.board.faire_action(player, choice.cout, args)
			choice.effets.each_index do |i|
				game.board.faire_action(player, choice.effets[i], args)
			end
		end

		def handle(game : Game, player : Player)
			case @carte
			when "1"
				if @effet == 0
					play_action(game, player, 0, 0)
				end
			when "2"
				if @effet == 0
					play_action(game, player, 1, 0)
				end
			when "3"
				if @effet == 0
					play_action(game, player, 2, 0)
				end
			else
			end
			game.send_all(Response::UpdateBoard.new(game.players, game.board.position_cerbere, game.board.vitesse_cerbere, game.board.rage_cerbere, game.board.pont))
		end
	end
end

class Cerbere::Response
	include JSON::Serializable

	class NewPlayer < Response
		property type = "newPlayer"
		property player : Player

		def initialize(@player)
		end
	end

	class Welcome < Response
		property type = "welcome"
		property players : Array(Player)
		
		def initialize(@players)
		end
	end

	class Starter < Response
		property type = "starter"
		property players : Array(Player)
		property difficulty : Int32
		
		def initialize(@players, @difficulty)
		end
	end

	class UpdatePlayer < Response
		property type = "updatePlayer"
		property player : Player

		def initialize(@player)
		end
	end

	class UpdatePosition < Response
		property type = "updatePosition"
		property player : Player

		def initialize(@player)
		end
	end

	class UpdateBoard < Response
		property type = "updateBoard"
		property players : Array(Player)
		property cerberepos : Int32
		property vitesse : Int32
		property rage : Int32
		property pont : Int32 

		def initialize(@players, @cerberepos, @vitesse, @rage, @pont)
		end
	end
end
