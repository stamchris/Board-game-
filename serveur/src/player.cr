require "./hand.cr"

require "json"
require "kemal"

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

enum TypeJoueur
    AVENTURIER # Joueur dans le camp Aventurier
    CERBERE # Joueur dans le camp Cerbère
    MORT # Joueur éliminé
end

class Cerbere::Player
	include JSON::Serializable

	property ready = false
	property name : String = ""
	property colour : Colour = Colour::Cyan
	@[JSON::Field(ignore: true)]
	getter socket : HTTP::WebSocket | Nil
	
	property type : TypeJoueur = TypeJoueur::AVENTURIER
	property position : Int32 = 1

	property lobby_id : Int32 = 0
	property hand : Hand = Hand.new

	def send(response : Response)
		unless (@socket.nil?)
			@socket.not_nil!.send(response.to_json)
		end
	end

	def initialize(@name, @socket)
	end

	def initialize(@lobby_id)
	end
end
