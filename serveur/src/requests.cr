require "./game.cr"

class Cerbere::Request
	include JSON::Serializable

	use_json_discriminator "type", {
		login: Login,
		ready: Ready
	}
	
	def handle(game : Game, player : Player)
	end

	class Login < Request
		property type = "login"
		property name : String

		def handle(game : Game, player : Player)
			player.name = @name
			game << player

			game.send_all Response::NewPlayer.new @name

			player.send(Response::Welcome.new game.players)
		end
	end

	class Ready < Request
		property type = "ready"

		def handle(game : Game, player : Player)
			player.ready = true
			if game.check_players()
				game.send_all(Response::Starter.new)
			end
		end
	end
end

class Cerbere::Response
	include JSON::Serializable

	class NewPlayer < Response
		property type = "newPlayer"
		property name : String

		def initialize(@name)
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

		def initialize()
		end
	end
end
