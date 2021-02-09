require "json"
require "kemal"

require "./requests.cr"
require "./game.cr"

game = Cerbere::Game.new

ws "/" do |socket|

	player = Cerbere::Player.new "", socket

	socket.on_message do |message|
		request = Cerbere::Request.from_json message
		pp! request

		request.handle(game, player)
	end
end

Kemal.run
