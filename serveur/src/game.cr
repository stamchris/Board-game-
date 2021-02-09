class Cerbere::Player
	property name : String
	getter socket : HTTP::WebSocket

	def initialize(@name, @socket)
	end
end

class Cerbere::Game
	getter players : Array(Player)

	def initialize()
		@players = [] of Player
	end

	def <<(player : Player)
		@players << player
	end

	def send_all(msg : String)
		@players.each do |player|
			player.socket.send msg
		end
	end

	def send_all(response : Response)
		send_all response.to_json
	end
end
			
