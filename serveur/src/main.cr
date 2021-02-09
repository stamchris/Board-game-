require "./Carte.cr"

require "json"
require "kemal"

class Player
	getter name : String

	def initialize(@name)
	end
end

class Payload::Login
	include JSON::Serializable

	property login : String
end

players = [] of Player

ws "/" do |socket|
	login = false

	socket.on_message do |message_as_s|
		msg = JSON.parse(message_as_s).as_h?
		pp! msg

		if msg.nil?
			next
		end

		if msg["type"] == "login"
			payload = Payload::Login.from_json(msg["payload"].as_s)
			players << Player.new(payload.login)

			socket.send "Ok"
		end
	end
end

Kemal.run
