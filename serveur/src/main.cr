require "json"
require "kemal"

require "./requests.cr"
require "./game.cr"
require	"mysql"


game = Cerbere::Game.new

connection_string : String = ""
if(ARGV.size() >= 1)
	connection_string = ARGV[0]
else
	cerbere_bdd : String? = ENV["CERBERE_BDD"]?
	if(!cerbere_bdd.nil?())
		connection_string = cerbere_bdd.not_nil!()
	end
end

if(connection_string != "")
	DB.open(connection_string) do |db|
		puts typeof(db) #DB::Database
		puts "connection ok"
		db.close
	end
else
	puts "Avertissement: Pas d'arguments et variable d'environnement CERBERE_BDD vide. BDD désactivée."
end

ws "/" do |socket|

	player = Cerbere::Player.new "", socket

	socket.on_message do |message|
		request = Cerbere::Request.from_json message
		pp! request

		request.handle(game, player)
	end
end

Kemal.run
