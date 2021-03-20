require "./game.cr"

class Cerbere::Request
	include JSON::Serializable

	use_json_discriminator "type", {
		login: Login,
		ready: Ready,
		change_colour: ChangeColour,
		play_action: PlayAction,
		change_position: ChangePosition,
		bridge_confirm: BridgeConfirm,
		portal_confirm: PortalConfirm
	}
	
	def handle(game : Game, player : Player)
	end

	class Login < Request
		property type = "login"
		property name : String

		def handle(game : Game, player : Player)
			player.name = @name
			game << player

			game.send_all Response::NewPlayer.new player

			player.send(Response::Welcome.new game.players)
		end
	end

	class Ready < Request
		property type = "ready"

		def handle(game : Game, player : Player)
			player.ready = !player.ready
			if game.check_players()
				id = 0
				game.players.each do |player|
					player.lobby_id = id
					id += 1
				end
				game.send_all(Response::Starter.new(game.players, game.difficulty))
				game.start(0, game.players)
			end
		end
	end

	class ChangeColour < Request
		property type = "changeColour"
		property colour : Cerbere::Colour

		def handle(game : Game, player : Player)
			pp game.players.to_json
			if game.check_colour(@colour)
				player.colour = @colour
				game.send_all(Response::UpdatePlayer.new(player))
			#Fixme : envoyer une resynchronisation sinon
			end
		end
	end

	class ChangePosition < Request
		property type = "changePosition"
		property change : Int32
		property login : String

		def handle(game : Game, player : Player)
			game.players.each do |player|
				if (player.name == @login)
					player.position += change
					game.send_all(Response::UpdatePosition.new(player))
				end
			end
		end
	end

	class PlayAction < Request
		property type = "playAction"
		property effet : Int32
		property carte : String
		property args : Array(String)

		def handle(game : Game, player : Player)
			new_args = [] of Int32
			args.each do |arg|
				game.players.each do |plyr|
					if arg == plyr.colour.to_s
						new_args << plyr.lobby_id
						break
					end
				end
			end
			if (player.colour == game.players[game.active_player].colour)
				case @carte
				when "1"
					if @effet == 0
						game.play_action(player, 0, 0, new_args)
						game.action_played = true
						game.new_turn()
					end
				when "2"
					if @effet == 0
						game.play_action(player, 1, 0, new_args)
						game.action_played = true
						game.new_turn()
					elsif @effet == 1
						new_args.insert(0, -1)
						game.play_action(player, 1, 1, new_args)
						game.action_played = true
						if (game.board.pont_queue.size == 0 && game.board.portal_queue.size == 0)
							game.new_turn()
						end
					end
				when "3"
					if @effet == 0
						game.play_action(player, 2, 0, new_args)
						game.action_played = true
						if (game.board.pont_queue.size == 0 && game.board.portal_queue.size == 0)
							game.new_turn()
						end
					elsif @effet == 1
						game.play_action(player, 2, 1, new_args)
						game.action_played = true
						if (game.board.pont_queue.size == 0 && game.board.portal_queue.size == 0)
							game.new_turn()
						end
					end
				when "4"
					if @effet == 0
						new_args.insert(0, -1)
						game.play_action(player, 3, 0, new_args)
						game.action_played = true
						if (game.board.pont_queue.size == 0 && game.board.portal_queue.size == 0)
							game.new_turn()
						end
					end
				else
				end

				players_queue : Array(Player) = [] of Player
				if game.board.pont_queue.size != 0
					game.board.pont_queue.each do |plyr|
						players_queue << plyr[0]
					end
					player.send(Response::UseBridge.new(players_queue))
				end
				if game.board.portal_queue.size != 0
					players_queue.clear()
					game.board.portal_queue.each do |plyr|
						players_queue << plyr[0]
					end
					player.send(Response::UsePortal.new(players_queue))
				end
			end
		end
	end

	class BridgeConfirm < Request
		property type = "bridgeConfirm"
		property survivor : Player
		property used : Bool

		def handle(game : Game, player : Player)
			game.board.pont_queue.each do |plyr|
				id_pont = game.board.nodes[plyr[0].position].effect.force
				if used == true && survivor.colour == plyr[0].colour
					game.board.nodes[plyr[0].position].effect.evenement = Evenement::RIEN
					plyr[0].position += id_pont == 1 ? -4 : 4 #On se sert de la force pour déterminer de quel côté du pont on se trouve
					game.board.nodes[plyr[0].position].effect.evenement = Evenement::RIEN
					game.board.pont = 0
				else
					plyr[0].position += id_pont == 1 ? -1 : 1 
				end
				plyr[1][0] -= 1
				new_force = id_pont == 1 ? plyr[1][0] * (-1) : plyr[1][0]
				game.board.action_deplacer_moi(plyr[0], new_force)
			end
			game.board.pont_queue.clear()
			game.send_all(Response::UpdateBoard.new(game.players, game.board.position_cerbere, game.board.vitesse_cerbere, game.board.rage_cerbere, game.board.pont, game.active_player))
			game.new_turn()
		end
	end

	class PortalConfirm < Request
		property type = "portalConfirm"
		property survivors : Array(Player)
		property used : Bool

		def handle(game : Game, player : Player)
			game.board.portal_queue.each do |plyr|
				id_portal = game.board.nodes[plyr[0].position].effect.force
				saved_player = nil
				survivors.each do |survivor|
					if survivor.colour == plyr[0].colour
						saved_player = survivor
					end
				end
				if used == true && !saved_player.nil?
					plyr[0].position += id_portal == 1 ? -3 : 3 #On se sert de la force pour déterminer de quel côté du portail on se trouve
				else
					plyr[0].position += id_portal == 1 ? -1 : 1 
				end
				plyr[1][0] -= 1
				new_force = id_portal == 1 ? plyr[1][0] * (-1) : plyr[1][0]
				game.board.action_deplacer_moi(plyr[0], new_force)
			end
			game.board.portal_queue.clear()
			game.send_all(Response::UpdateBoard.new(game.players, game.board.position_cerbere, game.board.vitesse_cerbere, game.board.rage_cerbere, game.board.pont, game.active_player))
			game.new_turn()
		end
	end
end

class Cerbere::Response
	include JSON::Serializable

	class NewPlayer < Response
		property type = "newPlayer"
		property player : Player

		def initialize(@player)
		end
	end

	class Welcome < Response
		property type = "welcome"
		property players : Array(Player)
		
		def initialize(@players)
		end
	end

	class Starter < Response
		property type = "starter"
		property players : Array(Player)
		property difficulty : Int32
		
		def initialize(@players, @difficulty)
		end
	end

	class UpdatePlayer < Response
		property type = "updatePlayer"
		property player : Player

		def initialize(@player)
		end
	end

	class UpdatePosition < Response
		property type = "updatePosition"
		property player : Player

		def initialize(@player)
		end
	end

	class UpdateBoard < Response
		property type = "updateBoard"
		property players : Array(Player)
		property cerberepos : Int32
		property vitesse : Int32
		property rage : Int32
		property pont : Int32 
		property active_player : Int32

		def initialize(@players, @cerberepos, @vitesse, @rage, @pont, @active_player)
		end
	end

	class NewBonus < Response
		property type = "newBonus"
		property cardname : String

		def initialize(@cardname)
		end
	end

	class UseBridge < Response
		property type = "useBridge"
		property pontQueue : Array(Player)
		
		def initialize(@pontQueue)
		end
	end

	class UsePortal < Response
		property type = "usePortal"
		property portalQueue : Array(Player)

		def initialize(@portalQueue)
		end
	end
end
