require "./game.cr"

class Cerbere::Request
	include JSON::Serializable

	use_json_discriminator "type", {
		login: Login,
		ready: Ready,
		change_colour: ChangeColour,
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
		property player : Player
		property difficulty : Int32
		
		def initialize(@player, @difficulty)
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
end
