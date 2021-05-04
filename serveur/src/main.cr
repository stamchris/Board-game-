require "json"
require "kemal"

require "./requests.cr"
require "./game.cr"
require	"mysql"


game = Cerbere::Game.new

if(ARGV.size() >= 1)
	game.connection_string = ARGV[0]
else
	cerbere_bdd : String? = ENV["CERBERE_BDD"]?
	if(!cerbere_bdd.nil?())
		game.connection_string = cerbere_bdd.not_nil!()
	end
end

if(game.connection_string != "")
	puts "Base de données détectée !"
else
	puts "Base de données introuvable !"
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

