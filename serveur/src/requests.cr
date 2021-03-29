require "./game.cr"

class Cerbere::Request
	include JSON::Serializable

	use_json_discriminator "type", {
		login: Login,
		ready: Ready,
		change_colour: ChangeColour,
		game_config: GameConfig
	}
	
	def handle(game : Game, player : Player)
	end

	class Login < Request
		property type = "login"
		property name : String

		def handle(game : Game, player : Player)
			player.name = @name
			
			if game.players.size == 0
				player.owner = true
			end

			game << player
			game.send_all Response::NewPlayer.new player

			player.send(Response::Welcome.new game.players, game.players.size-1)
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
			#Fixme : envoyer une resynchronisation sinon
			end
		end
	end

	class GameConfig < Request
		property type = "gameConfig"
		property difficulty : Int32
		property maxPlayers : Int32
		#FIXME : property board
		
		def handle(game : Game, player : Player)
			if player.owner
				game.difficulty=@difficulty
				game.number_players=@maxPlayers
				game.send_all(Response::GameConfigUpdated.new())
				#FIXME : send boards too
			else
				#FIXME : raise error
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
		property rank : Int32

		def initialize(@players,@rank)
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

	class GameConfigUpdated < Response
		property type = "gameConfigUpdated"
		
		def initialize()
		end
	end
end
