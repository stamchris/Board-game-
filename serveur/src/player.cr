require "./hand.cr"

require "json"
require "kemal"
require "db"
require "mysql"

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
	property colour : Colour | Nil = Cerbere::Colour::Cyan
	@[JSON::Field(ignore: true)]
	getter socket : HTTP::WebSocket | Nil
	
	property type : TypeJoueur = TypeJoueur::AVENTURIER
	property position : Int32 = 1

	property lobby_id : Int32 = -1
	property hand : Hand = Hand.new
	property owner = false
	property password = ""

	def send(response : Response)
		unless (@socket.nil?)
			begin
				@socket.not_nil!.send(response.to_json)
			rescue
				@socket = nil
			end
		end
	end

	def initialize(@name, @socket)
	end

	def initialize(@lobby_id)
	end

	def authentification(game)
		db = game.db
		if !(db.nil?)
			result = db.query_one? "SELECT * FROM tab_joueur WHERE tab_joueur.login_joueur = ?", @name, as: {login: String , password: String}

			game.players.each do |player|
				if(player.name == @name)
					send(Response::AlreadyIngame.new)
					return 
				end
			end

			if result.nil?
				db.exec "INSERT INTO tab_joueur (login_joueur,password_joueur) VALUES(?,?)", @name,@password
				result = {login:@name,password:@password}
			end

			if result[:password] == @password
				
				if game.players.size == 0
					@owner = true
				end

				@password = "RS TEAM"
				game << self
				game.send_all Response::NewPlayer.new self

				send(Response::Welcome.new game.players, game.players.size-1)
			else
				send(Response::BadLogin.new)
			end
		else
			if game.players.size == 0
				@owner = true
			end

			@password = "RS TEAM"

			game << self
			game.send_all Response::NewPlayer.new self
		
			send(Response::Welcome.new game.players, game.players.size-1)
		end

	end
end
