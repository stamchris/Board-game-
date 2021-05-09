require "json"
require "kemal"

require "./requests.cr"
require "./game.cr"
require	"mysql"


connection_string = ""

if(ARGV.size() >= 1)
	connection_string = ARGV[0]
else
	cerbere_bdd : String? = ENV["CERBERE_BDD"]?
	if(!cerbere_bdd.nil?())
		connection_string = cerbere_bdd.not_nil!()
	end
end

if(connection_string != "")
	puts "Base de données détectée !"
else
	puts "Base de données introuvable !"
end


game = Cerbere::Game.new(connection_string)


ws "/" do |socket|

	player = Cerbere::Player.new "", socket

	socket.on_message do |message|
		request = Cerbere::Request.from_json message
		pp! request

		request.handle(game, player)
	end

	socket.on_close do |_|
		puts("Déconnexion de : #{socket}")
		request = Cerbere::Request::WarnDisconnect.new()
		request.handle(game,player)
	end

end

Kemal.run

