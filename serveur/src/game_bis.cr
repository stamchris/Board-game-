require "json"
require "http"

class Cerbere::Player
	include JSON::Serializable

	property ready = false
	property name : String
	@[JSON::Field(ignore: true)]
	getter socket : HTTP::WebSocket

	def send(response : Response)
		@socket.send(response.to_json)
	end

	def initialize(@name, @socket)
	end
end

class Cerbere::Game
	getter players : Array(Player)
	getter active = false

	def initialize()
		@players = [] of Player
	end

	def <<(player : Player)
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
end