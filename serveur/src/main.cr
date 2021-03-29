require "json"
require "kemal"

require "./requests.cr"
require "./game.cr"
require	"mysql"


game = Cerbere::Game.new

DB.open("mysql://root@localhost/cerbere-bdd")	do	|db|
puts	typeof(db)#DB::Database
puts	"connection	ok"
db.close
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
