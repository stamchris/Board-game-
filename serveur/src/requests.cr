require "./game.cr"

class Cerbere::Request
	include JSON::Serializable

	use_json_discriminator "type", {
		login: Login,
		ready: Ready,
		change_colour: ChangeColour,
		play_action: PlayAction,
		play_bonus: PlayBonus,
		change_position: ChangePosition,
		bridge_confirm: BridgeConfirm,
		portal_confirm: PortalConfirm,
		skip_turn: SkipTurn,
		changeColour: ChangeColour,
		chatMessage: ChatMessage
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
			#FIXME : envoyer une resynchronisation sinon
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
					elsif player.type == TypeJoueur::AVENTURIER && @effet == 1
						new_args = [] of Int32
						args.each do |arg|
							new_args << arg.to_i32
						end
						game.play_action(player, 0, 1, new_args)
						game.action_played = true
					elsif player.type == TypeJoueur::CERBERE && @effet == 1
						game.play_action(player, 0, 1, new_args)
						game.action_played = true
					end
				when "2"
					if @effet == 0
						game.play_action(player, 1, 0, new_args)
						game.action_played = true
					elsif player.type == TypeJoueur::AVENTURIER && @effet == 1
						new_args.insert(0, -1)
						game.play_action(player, 1, 1, new_args)
						game.action_played = true
					elsif player.type == TypeJoueur::CERBERE && @effet == 1
						game.play_action(player, 1, 1, new_args)
						game.action_played = true
					end
				when "3"
					if @effet == 0
						game.play_action(player, 2, 0, new_args)
						game.action_played = true
					elsif player.type == TypeJoueur::AVENTURIER && @effet == 1
						game.play_action(player, 2, 1, new_args)
						game.action_played = true
					elsif player.type == TypeJoueur::CERBERE && @effet == 1
						new_args.insert(0, 0)
						game.play_action(player, 2, 1, new_args)
						game.action_played = true
					end
				when "4"
					if player.type == TypeJoueur::AVENTURIER && @effet == 0
						new_args.insert(0, -1)
						game.play_action(player, 3, 0, new_args)
						game.action_played = true
					elsif player.type == TypeJoueur::CERBERE && @effet == 0
						game.play_action(player, 3, 0, new_args)
						game.action_played = true
					elsif player.type == TypeJoueur::CERBERE && @effet == 1
						game.play_action(player, 3, 1, new_args)
						game.action_played = true
					end
				else
				end

				if game.action_played == true 
					player.send(Response::ActionPlayed.new())
					game.send_all(Response::UpdateBoard.new(game.players, game.board.position_cerbere, game.board.vitesse_cerbere, game.board.rage_cerbere, game.board.pont, game.active_player))
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

				if game.action_played && (game.bonus_played || player.hand.bonus_size == 0)
					game.new_turn()
				end
			end
		end
	end

	class PlayBonus < Request
		property type = "playBonus"
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
				when "Arro"
					if @effet == 0
						new_args.insert(0, -1)
						game.play_bonus(player, "Arro", 0, new_args)
						game.bonus_played = true
					end
				when "Ego"
					if @effet == 0
						game.play_bonus(player, "Ego", 0, new_args)
						game.bonus_played = true
					end
				when "Fata"
					if @effet == 0
						game.play_bonus(player, "Fata", 0, new_args)
						game.bonus_played = true
					elsif @effet == 1
						game.play_bonus(player, "Fata", 1, new_args)
						game.bonus_played = true
					end
				when "Fav"
					if @effet == 0
						new_args.insert(0, -1)
						game.play_bonus(player, "Fav", 0, new_args)
						game.bonus_played = true
					end
				when "Oppo"
					if @effet == 0
						new_args.insert(0, -1)
						game.play_bonus(player, "Oppo", 0, new_args)
						game.bonus_played = true
					end
				when "Sac"
					if @effet == 0
						new_args.insert(0, -1)
						game.play_bonus(player, "Sac", 0, new_args)
						game.bonus_played = true
					end
				else
				end

				if game.bonus_played == true 
					player.send(Response::BonusPlayed.new())
					game.send_all(Response::UpdateBoard.new(game.players, game.board.position_cerbere, game.board.vitesse_cerbere, game.board.rage_cerbere, game.board.pont, game.active_player))
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

				if game.action_played && game.bonus_played
					game.new_turn()
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

	class SkipTurn < Request
		property type = "skipTurn"

		def handle(game : Game, player : Player)
			game.new_turn()
		end
	end

	class ChatMessage < Request
		property type = "chatMessage"
		#FIXME : timer les messages
		# property timestamp : Int32
		property message : String

		def handle(game : Game, player : Player)
			game.send_all(Response::Chat.new(player,message))
		end
	end
end

class Cerbere::Response
	include JSON::Serializable

	class Chat < Response
		property type = "chatResponse"
		property player : Player
		property message : String

		def initialize(@player, @message)
		end
	end

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

	class ActionPlayed < Response
		property type = "actionPlayed"
		
		def initialize()
		end
	end

	class BonusPlayed < Response
		property type = "bonusPlayed"
		
		def initialize()
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

	class ChangeType < Response
		property type = "changeType"
		property new_type : TypeJoueur

		def initialize(@new_type)
		end
	end
end
