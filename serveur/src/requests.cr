require "./game.cr"

class Cerbere::Request
	include JSON::Serializable

	use_json_discriminator "type", {
		login: Login,
		ready: Ready,
		changeColour: ChangeColour,
		chatMessage: ChatMessage
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
				game.send_all(Response::Starter.new)
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
			#FIXME : envoyer une resynchronisation sinon
			end
		end
	end

	class ChatMessage < Request
		property type = "chatMessage"
		#FIXME : timer les messages
		# property timestamp : Int32
		property message : String

		def handle(game : Game, player : Player)
			game.send_all(Response::Chat.new(player,message))
		end
	end
	


end

class Cerbere::Response
	include JSON::Serializable

	class Chat < Response
		property type = "chatResponse"
		property player : Player
		property message : String

		def initialize(@player, @message)
		end
	end

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

		def initialize()
		end
	end

	class UpdatePlayer < Response
		property type = "updatePlayer"
		property player : Player

		def initialize(@player)
		end
	end
end
