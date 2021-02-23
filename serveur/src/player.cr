require "./Hand.cr"

enum Cerbere::PlayerType
	Eliminated
	Adventurer
	CerberePlayer
end

enum Cerbere::Colour
	def to_json(o)
		o.scalar self.to_s
	end
	Cyan
	Orange 
	Green
	Pink
	Blue
	White
	Red
end

class Cerbere::Player
	include JSON::Serializable

	property ready = false
	property name : String
	@[JSON::Field(ignore: true)]
	getter socket : HTTP::WebSocket
	
	#property hand : Hand = Hand.new
	property typeJoueur : PlayerType = PlayerType::Adventurer
	property position : Int32 = 1
	property colour : Colour = Colour::Cyan

	def send(response : Response)
		@socket.send(response.to_json)
	end

	def initialize(@name, @socket)
	end
end

