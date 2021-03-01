require "./Hand.cr"

require "json"
require "kemal"

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

enum TypeJoueur
    AVENTURIER # Joueur dans le camp Aventurier
    CERBERE # Joueur dans le camp Cerbère
    MORT # Joueur éliminé
end

class Cerbere::Player
	include JSON::Serializable

	property ready = false
	property name : String = ""
	@[JSON::Field(ignore: true)]
	getter socket : HTTP::WebSocket | Nil
	
	#property hand : Hand = Hand.new
	property typeJoueur : PlayerType = PlayerType::Adventurer
	property position : Int32 = 1
	property colour : Colour = Colour::Cyan

	property lobby_id : Int32 = 0
	@[JSON::Field(ignore: true)]
	property hand : Hand = Hand.new# Classe temporaire representant les utilisateurs provenant du lobby
	property type : TypeJoueur = TypeJoueur::AVENTURIER

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
