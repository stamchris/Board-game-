require "./game.cr"

class Cerbere::Request
	include JSON::Serializable

	use_json_discriminator "type", {
		login: Login,
		ready: Ready,
		change_colour: ChangeColour,
		game_config: GameConfig,
		play_action: PlayAction,
		play_bonus: PlayBonus,
		change_position: ChangePosition,
		bridge_confirm: BridgeConfirm,
		portal_confirm: PortalConfirm,
		skip_turn: SkipTurn,
		changeColour: ChangeColour,
		chatMessage: ChatMessage,
		answerSabotage: AnswerSabotage,
		password: Password
	}

	def handle(game : Game, player : Player)
	end

	class Login < Request
		property type = "login"
		property name : String

		def handle(game : Game, player : Player)
			player.name = @name
			
			if player.password != ""
				player.authentification(game)
			end
		end
	end

	class Password < Request
		property type = "password"
		property password : String

		def handle(game : Game, player : Player)
			sha256 = OpenSSL::Digest.new("sha256")
			player.password = sha256.update(@password).final.hexstring

			if player.name != ""
				player.authentification(game)
			end
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

	class GameConfig < Request
		property type = "gameConfig"
		property difficulty : Int32
		property maxPlayers : Int32
		#FIXME : property board
		
		def handle(game : Game, player : Player)
			if player.owner
				game.difficulty=@difficulty
				game.number_players=@maxPlayers
				game.send_all(Response::GameConfigUpdated.new(player))
				#FIXME : send boards too
			else
				#FIXME : raise error
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
		property args : Array(Array(String))

		def handle(game : Game, player : Player)
			if(player.colour != game.players[game.active_player].colour)
				player.send(Response::CantDoThat.new("Ce n'est pas à votre tour de jouer !"))
				return
			end

			index_card : Int32 = carte.to_i32() - 1
			if(index_card < 0 || index_card >= 4)
				player.send(Response::CantDoThat.new("La carte #{carte} n'existe pas !"))
				return
			end

			card : CarteAction = Hand.actions_of(player.type)[index_card]

			if(effet >= card.choix.size())
				player.send(Response::CantDoThat.new("Cette carte n'a pas d'effet #{effet} !"))
				return
			end

			choice : Choix = card.choix[effet]

			if(!game.board.can_pay_cost(player, choice.cout))
				player.send(Response::CantDoThat.new("Vous ne pouvez pas payer le coût de la carte #{carte} !"))
				return
			end

			new_args : Array(Array(Int32)) = game.convert(player, choice, args)
			print("args = #{args}")
			print("new_args = #{new_args}")

			if(!game.board.check_args_are_valid(player, choice.cout, new_args[0], true))
				player.send(Response::CantDoThat.new("Arguments invalides pour #{choice.cout}: #{new_args[0]}"))
				return
			end
			choice.effets.each_index do |i|
				if(!game.board.check_args_are_valid(player, choice.effets[i], new_args[i+1]))
					player.send(Response::CantDoThat.new("Arguments invalides pour #{choice.effets[i]}: #{new_args[i+1]}"))
					return
				end
			end

			game.board.play_card(player, true, index_card, effet, new_args)
			game.action_played = true

			game.send_all(Response::CardPlayed.new("action", carte, effet, player))
			game.send_all(Response::UpdateBoard.new(game.players, game.board.position_cerbere, game.board.vitesse_cerbere, game.board.rage_cerbere, game.board.pont, game.active_player))


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

			game.new_turn_if_all_set(player)
		end
	end

	class PlayBonus < Request
		property type = "playBonus"
		property effet : Int32
		property carte : String
		property args : Array(Array(String))

		def handle(game : Game, player : Player)
			if(player.colour != game.players[game.active_player].colour)
				player.send(Response::CantDoThat.new("Ce n'est pas à votre tour de jouer !"))
				return
			end

			card? : CarteBonus? = nil
			index_card : Int32 = player.hand.bonus.size()
			player.hand.bonus.each_index do |i|
				bonus_card : CarteBonus = player.hand.bonus[i]
				if(bonus_card.name == carte)
					card? = bonus_card
					index_card = i
					break
				end
			end

			if(index_card == player.hand.bonus.size())
				player.send(Response::CantDoThat.new("Vous ne possédez pas la carte #{carte} !"))
				return
			end

			card : CarteBonus = card?.not_nil!()

			if(effet >= card.choix.size())
				player.send(Response::CantDoThat.new("Cette carte n'a pas d'effet #{effet} !"))
				return
			end

			choice : Choix = card.choix[effet]

			if(!game.board.can_pay_cost(player, choice.cout))
				player.send(Response::CantDoThat.new("Vous ne pouvez pas payer le coût de la carte #{carte} !"))
				return
			end

			new_args : Array(Array(Int32)) = game.convert(player, choice, args)
			print("new_args = #{new_args}")

			if(!game.board.check_args_are_valid(player, choice.cout, new_args[0], true))
				player.send(Response::CantDoThat.new("Arguments invalides pour #{choice.cout}: #{new_args[0]}"))
				return
			end
			choice.effets.each_index do |i|
				if(!game.board.check_args_are_valid(player, choice.effets[i], new_args[i+1]))
					player.send(Response::CantDoThat.new("Arguments invalides pour #{choice.effets[i]}: #{new_args[i+1]}"))
					return
				end
			end

			game.board.play_card(player, false, index_card, effet, new_args)
			game.bonus_played = true

			player.send(Response::DiscardBonus.new(carte))
			game.send_all(Response::CardPlayed.new("bonus", carte, effet, player))
			game.send_all(Response::UpdateBoard.new(game.players, game.board.position_cerbere, game.board.vitesse_cerbere, game.board.rage_cerbere, game.board.pont, game.active_player))

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

			game.new_turn_if_all_set(player)
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
			
			game.new_turn_if_all_set(player)
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
			
			game.new_turn_if_all_set(player)
		end
	end

	class SkipTurn < Request
		property type = "skipTurn"

		def handle(game : Game, player : Player)
			game.new_turn_if_all_set(player, true)
		end
	end

	class ChatMessage < Request
		property type = "chatMessage"
		property timestamp : String
		property message : String

		def handle(game : Game, player : Player)
			game.send_all(Response::Chat.new(player,timestamp,message))
		end
	end

	class AnswerSabotage < Request
		property type = "answerSabotage"
		property effect : Int32 # 0 pour défaussage forcé, 1 pour sabotage
		property args : Array(String)

		def handle(game : Game, player : Player)
			puts("AnswerSabotage", !game.board.awaiting_players.includes?(player), effect != game.board.wait_origin)
			if(!game.board.awaiting_players.includes?(player) || effect != game.board.wait_origin)
				player.send(Response::CantDoThat.new("C'est trop tard pour répondre !"))
				return
			end
			if(effect == 0 || args[0] == "1") # Défaussage forcé ou le joueur saboté a choisi de défausser
				card_name : String = args[effect]
				index_card? : Int32? = nil
				player.hand.bonus.each_index do |i|
					if (player.hand.bonus[i].name == card_name)
						index_card? = i
						break
					end
				end
				if(index_card? == nil)
					player.send(Response::CantDoThat.new("Vous ne possédez pas la carte #{card_name} !"))
					player.send(Response::AskSabotage.new(effect))
					return
				end
				index_card : Int32 = index_card?.not_nil!()
				game.board.defausser(player, index_card)
				player.send(Response::DiscardBonus.new(card_name))
			elsif(args[0] == "0") # Le joueur saboté a choisi de reculer
				game.board.action_deplacer_moi(player, -2)
			else
				player.send(Response::CantDoThat.new("Action invalide: #{args[0]} !"))
				player.send(Response::AskSabotage.new(effect))
				return
			end
			game.board.awaiting_players.delete(player)
			game.send_all(Response::UpdateBoard.new(game.players, game.board.position_cerbere, game.board.vitesse_cerbere, game.board.rage_cerbere, game.board.pont, game.active_player))

			# C'est le joueur qui a joué la carte Sabotage qui est
			# en train de jouer, pas celui qui a répondu au Sabotage
			currentPlayer : Player = game.players[game.active_player]

			players_queue : Array(Player) = [] of Player

			if game.board.pont_queue.size != 0
				game.board.pont_queue.each do |plyr|
					players_queue << plyr[0]
				end
				currentPlayer.send(Response::UseBridge.new(players_queue))
			end

			if game.board.portal_queue.size != 0
				players_queue.clear()
				game.board.portal_queue.each do |plyr|
					players_queue << plyr[0]
				end
				currentPlayer.send(Response::UsePortal.new(players_queue))
			end

			game.new_turn_if_all_set(currentPlayer)
		end
	end
end

class Cerbere::Response
	include JSON::Serializable

	class BadLogin < Response
		property type = "badLogin"

		def initialize()
		end
	end

	class Chat < Response
		property type = "chatResponse"
		property player : Player
		property timestamp : String
		property message : String

		def initialize(@player, @timestamp, @message)
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
		property rank : Int32

		def initialize(@players,@rank)
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

	class GameConfigUpdated < Response
		property type = "gameConfigUpdated"
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

	class DiscardBonus < Response
		property type = "discardBonus"
		property cardname : String

		def initialize(@cardname)
		end
	end

	class SwapBarque < Response
		property type = "swapBarque"
		property barques : String

		def initialize(@barques)
		end
	end

	class RevealBarque < Response 
		property type = "revealBarque"
		property barque : String

		def initialize(@barque)
		end
	end

	class CardPlayed < Response
		property type = "cardPlayed"
		property cardType : String
		property cardName : String
		property cardEffect : Int32
		property player : Player
		
		def initialize(@cardType, @cardName, @cardEffect, @player)
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

	class StatusPlayer < Response
		property type = "statusplayers"
		property players : Array(Player)
		property status : Array(Int32)
		property player : Player

		def initialize(@players,@status,@player)
		end
	end

	class CantDoThat < Response
		property type = "cantDoThat"
		property msg : String

		def initialize(@msg)
		end
	end

	class AskSabotage < Response
		property type = "askSabotage"
		property effect : Int32 # 0 pour défaussage forcé, 1 pour sabotage

		def initialize(@effect)
		end
	end

	class NextTurn < Response
		property type = "nextTurn"

		def initialize()
		end
	end
end
