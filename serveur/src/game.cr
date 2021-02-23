require "./player.cr"

class Cerbere::Game
	getter players : Array(Player)
	getter active = false

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
end
