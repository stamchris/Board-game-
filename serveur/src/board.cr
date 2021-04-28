require "./player.cr"
require "./node.cr"
require "./board_0.cr"
require "./deck.cr"
require "./utils.cr"

class Cerbere::Board
	getter nodes : Array(Node)
	property difficulty : Int32
	property barques : Array(Int32) = [1, 2, 3].shuffle
	property rage_cerbere : Int32
	property vitesse_cerbere : Int32
	property position_cerbere : Int32 = 0
	property players : Array(Player) = [] of Player
	property pont : Int32 = 1
	property nombre_pions_jauge : Int32
	property pioche_survie : DeckSurvie = DeckSurvie.new
	property pioche_trahison : DeckTrahison = DeckTrahison.new
	property pont_queue : Array(Tuple(Player, Array(Int32))) = [] of Tuple(Player, Array(Int32))
	property portal_queue : Array(Tuple(Player, Array(Int32))) = [] of Tuple(Player, Array(Int32))
	property awaiting_players : Array(Player) = [] of Player # Les joueurs dont on attend une réponse (sabotage/defaussage forcé)
	property wait_origin : Int32 = 0 # 0 pour le défaussage forcé, 1 pour le sabotage

	def initialize(difficulty : Int32, @players)
		# Choix du plateau
		# Seulement difficulte 0 disponible pour l'instant
		case difficulty
		when 0
			@nodes = BOARD_0
		when 1
			@nodes = BOARD_0
		when 2
			@nodes = BOARD_0
		else
			@nodes = BOARD_0
		end

		# Initialisation des variables de jeu
		@rage_cerbere = 8 - @players.size
		@vitesse_cerbere = 3 + difficulty
		@nombre_pions_jauge = 7 - @players.size
		@difficulty = difficulty
	end

	def demander(qui : Player,quoi : String) : String
		# Demande une entrée supplémentaire à un joueur particulier
		# Pour le moment, on demande via la ligne de commande, plus tard, il
		# faudra contacter le client
		puts "Joueur "+qui.lobby_id.to_s()+": "+quoi
		res : String? = gets
		return res == Nil ? "" : res.to_s
	end

	def action_deplacer_moi(moi : Player, force : Int32)
		nb_moves = force.abs # Nombre de déplacements restants à effectuer

		while (nb_moves > 0)
			# Si l'effet de la case n'a pas changé la position du joueur et qu'il n'essaye pas d'avancer ou reculer hors du plateau
			has_moved = faire_action(moi, nodes[moi.position].effect, [nb_moves, force])
			if has_moved
				return
			end
			if !has_moved && (moi.position > 1 || moi.position < nodes.size - 1)
				moi.position += force > 0 ? 1 : -1 # Déplacement vers la gauche ou la droite
			end

			if (moi.position <= position_cerbere)
				# appel à une fonction capture pour changer le rôle du joueur et renvoyer Cerbère au dernier checkpoint
				catch_survivor(moi)
				#puts "Le joueur #{moi.lobby_id} s'est fait attrapé par Cerbère !"
				return
			end

			nb_moves -= 1
		end

		faire_action(moi, nodes[moi.position].effect, [nb_moves, force]) # appliquer l'effet de la case d'arrivée
	end

	def envoyer(qui : Player, quoi : String)
		# Envoie une information qui n'est destiné qu'à un joueur particulier
		# Pour le moment, on parle via la ligne de commande, plus tard, il
		# faudra contacter le client
		puts "Joueur "+qui.lobby_id.to_s()+": "+quoi
	end

	def broadcast(quoi : String)
		players.each do |joueur|
		envoyer(joueur,quoi)
		end
	end

	def action_barque(moi : Player,args : Array(Int32))
		if(barques.size() == 3) # Les barques n'ont pas encore été révélées
			if(args.size() == 0)
				raise "Argument choix manquant pour BARQUE"
			end
			choix : Int32 = args[0]
			srvr = @players[0].dup()
			srvr.name = "Server"
			srvr.colour = nil
			if(choix == 0) # Consulter une barque
				if(args.size() < 2 || args[1] < 0 || args[1] > 2)
					raise "Argument barque manquant ou invalide pour BARQUE consulter"
				end
				info_barque : String = "Capacité de la barque #{args[1] + 1}: #{barques[args[1]]}"
				envoyer(moi,info_barque)
				moi.send(Response::Chat.new(srvr, "", info_barque))
			elsif(choix == 1) # Echanger deux barques
				if(args.size() < 3 || args[1] < 0 || args[1] > 2 || args[2] < 0 || args[2] > 2 || args[1] == args[2])
					raise "Arguments barques manquants ou invalides pour BARQUE échanger"
				end
				barques.swap(args[1],args[2])
				broadcast("Les barques #{args[1]} et #{args[2]} ont été échangées.")
				players.each do |plyr|
					plyr.send(Response::Chat.new(srvr, "", "Les barques #{args[1] + 1} et #{args[2] + 1} ont été échangées."))
					plyr.send(Response::SwapBarque.new("#{args[1]+1}#{args[2]+1}"))
				end
			end
		end
	end

	def action_reveler_barque(moi : Player)
		if(@barques.size == 3)
			@barques.pop(2)
			srvr = @players[0].dup()
			srvr.name = "Server"
			srvr.colour = nil
			puts "La barque à #{barques[0]} place(s) a été révélée !"
			players.each do |plyr|
				plyr.send(Response::Chat.new(srvr, "","La barque à #{barques[0]} place(s) a été révélée"))
				plyr.send(Response::RevealBarque.new("#{barques[0]}"))
			end
		end
	end

	def action_verif_barque()
		nb_assis = 0 # Nombre de personnes assises dans la barque
		barque = nodes.size - 1 # Position de la barque (dernière case)

		@players.each do |player|
			if(player.position == barque) # On compte le nombre de joueurs sur la dernière case représentant la barque
				nb_assis += 1
			end
		end

		if(nb_assis == barques[0]) # Barque pleine
			puts "Fin de partie, la barque s'en va !"
			return true
		else
			puts "Il manque #{barques[0] - nb_assis} personne(s) pour partir !"
			return false
		end
	end

	def action_pont(moi : Player, id_pont : Int32, args : Array(Int32)) : Bool
		nb_moves = args[0] # Nombre de déplacement restants pour le joueur
		force = args[1]
		# Si on a fini de se déplacer
		if (nb_moves == 0) || (id_pont == 0 && force < 0 || id_pont == 1 && force > 0)
			return false
		end
		emprunte = true # permet d'indiquer si on a emprunté le pont à la fonction deplacer_moi
		
		pont_queue << {moi, args}

		return emprunte
	end

	def action_funiculaire(moi : Player, id_funi : Int32, args : Array(Int32)) : Bool
		nb_moves = args[0] # Nombre de déplacement restants pour le joueur
		force = args[1]
		# S'il ne s'agit pas du premier déplacement
		if (nb_moves != force.abs) || (id_funi == 0 && force < 0 || id_funi == 1 && force > 0)
			return false
		end
		emprunte = true # permet d'indiquer si on a emprunté le funiculaire à la fonction deplacer_moi
		res = demander(moi, "Prendre le funiculaire ? O/N")

		if(res == "O")
			moi.position += id_funi == 1 ? -3 : 3 #On se sert de la force pour déterminer de quel côté du funiculaire on se trouve
		else
			puts "Refus"
			emprunte = false
		end

		return emprunte
	end

	def action_portail(moi : Player, id_portail : Int32, args : Array(Int32)) : Bool
		nb_moves = args[0] # Nombre de déplacement restants pour le joueur
		force = args[1]
		# Si on a fini de se déplacer
		if (nb_moves == 0) || (id_portail == 0 && force < 0 || id_portail == 1 && force > 0)
			return false
		end

		stele = id_portail == 1 ? (moi.position - 1) : (moi.position + 2) # Position de la stèle qui active le portail
		actif = false
		emprunte = true # permet d'indiquer si on a emprunté le portail à la fonction deplacer_moi

		players.each do |player|
			if(player.position == stele) # Si un joueur se trouve sur la stèle, le portail est actif
				actif = true
				break
			end
		end

		if(actif)
			portal_queue << {moi, args}
		else
			puts "Portail non disponible !"
			emprunte = false
		end

		return emprunte
	end

	def action_promontoire(moi : Player, args : Array(Int32))
		nb_moves = args[0] # Nombre de déplacement restants pour le joueur
		# Si on ne s'arrête pas sur la case
		if nb_moves != 0
			return 1
		end
		requete = [] of Int32
		res = demander(moi, "Voir une barque (0) ou échanger 2 barques (1) ?").to_i32
		if !res.in?(0,1)
			raise "Mauvaise réponse promontoire !"
		end
		requete << res
		if requete[0] == 0
			res = demander(moi, "Quelle barque voulez-vous voir ?").to_i32
			if !res.in?(0, 1, 2)
				raise "Cette barque n'existe pas !"
			end
			requete << res
		else
			res = demander(moi, "Donnez une barque à échanger :").to_i32
			if !res.in?(0, 1, 2)
				raise "Cette barque n'existe pas !"
			end
			requete << res
			res = demander(moi, "Donnez l'autre barque à échanger :").to_i32
			if !res.in?(0, 1, 2) || res == requete[1]
				raise "Cette barque n'existe pas ou vous avez donné la même barque que la première !"
			end
			requete << res
		end
		puts requete
	end

	def action_pilotis(moi : Player, args : Array(Int32))
		nb_moves = args[0] # Nombre de déplacement restants pour le joueur
		force = args[1]
		# Si on commence le déplacement
		if nb_moves == force.abs
			return 1
		end
		players.each do |player|
			if player.position == moi.position && player != moi
				moi.position += args[1] > 0 ? -1 : 1
				break
			end
		end
	end

	def action_couardise(moi : Player)
		nbJoueursDevant : Int32 = 0
		players.each do |player|
			if(player.position > moi.position)
				nbJoueursDevant += 1
			end
		end
		deplacement : Int32 = Math.min(nbJoueursDevant,3)
		action_deplacer_moi(moi, deplacement)
	end

	def action_sabotage()
		@wait_origin = 1
		players.each do |player|
			if(player.type == TypeJoueur::AVENTURIER)
				if(player.hand.bonus.size() == 0)
					action_deplacer_moi(player, -2)
				else
					awaiting_players << player
					player.send(Response::AskSabotage.new(1))
				end
			end
		end
	end

	#DEPLACER_CERBERE # Cerbère se déplace sur le plateau


	def index_capture(finalpos : Int32)

		final = finalpos
		first_pos = @position_cerbere

		i = 0
		min = nodes.size - 1
		capture = 0
		@players.each do |p|
			if ((final >= p.position) && (first_pos < p.position))
				if (p.position < min )
					min = p.position
					capture = 1
				end
			end

			i += 1
		end

		if (capture == 0)
			min = -1
		end

		return min  # on retourne la position la plus petite possible
	end

	def lastcheckpoint(pos_cerb : Int32)
		i = pos_cerb - 1
		while i > 0 && !nodes[i].checkpoint_cerbere
			i -= 1
		end
		@position_cerbere = i
	end

	def catch_survivor(pl : Player)
		if(pl.type == TypeJoueur::MORT)
			return
		end

		defausser_tout(pl)
		dernier_plateau = nodes.size - 1
		while nodes[dernier_plateau].effect.evenement != Evenement::REVELER_BARQUE
			dernier_plateau -= 1
		end
		nb_aventuriers = 7 - @nombre_pions_jauge

		if nb_aventuriers <= 2 || pl.position >= dernier_plateau
			pl.type = TypeJoueur::MORT
			pl.send(Response::ChangeType.new(pl.type))
		else
			pl.type = TypeJoueur::CERBERE
			pl.send(Response::ChangeType.new(pl.type))
			action_recuperer_carte(pl)

			if pl.position <= 2
				action_piocher_moi(pl,2)
			elsif pl.position <= 6
				action_piocher_moi(pl,1)
			end
		end
		pl.position = 0
		puts "Le joueur #{pl.lobby_id} s'est fait attrapé par Cerbère !"

		action_changer_vitesse(-@vitesse_cerbere)
		@nombre_pions_jauge += 1
		action_changer_rage(-@rage_cerbere)
	end


	def action_move_cerbere(force : Int32)
		size_board = nodes.size
		tmp = @position_cerbere + force
		pos_max = -1

		if ((force > 0) && (tmp < size_board))
			pos_max = tmp
		elsif ((force < 0) && (tmp >= 0))
			pos_max = tmp
		else 
			pos_max = size_board - 2
		end

		capturable = index_capture(pos_max)

		if(capturable != -1)
			@players.each do |p|
				if (p.position == capturable) #on va capturer les joueurs
				catch_survivor(p)
				end
			end
			lastcheckpoint(capturable)
		else
			@position_cerbere = tmp
		end

		return capturable
	end

	def cerbere_hunting()
		if (@rage_cerbere == 10)
			puts "Cerbere part en chasse"
			catch = action_move_cerbere(@vitesse_cerbere)
			if(catch == -1)
				action_changer_vitesse(1)
				action_changer_rage(-@rage_cerbere)
			end
		else
			puts "Cerbere ne part pas en chasse ce tour"
		end
	end

	def action_move_other_player(moi : Player, force : Int32, args : Array(Int32))
		if(args.size() == 0)
			# Aucun aventurier n'est donné en argument, personne ne
			# se déplace.
			return
		end
		player_id = args[0] # id du joueur à déplacer
		my_id = moi.lobby_id

		if my_id == player_id
			raise "Le joueur à déplacer #{player_id} ne peut pas être le joueur actif #{my_id} !"
		end

		players.each do |player|
			if (player.lobby_id == player_id)
				if (player.type == TypeJoueur::AVENTURIER)
					action_deplacer_moi(player, force)
					break
				else
					raise "Le joueur #{player_id} n'est pas un aventurier et ne peut pas être déplacé !"
				end
			end
		end
	end

	def action_move_all_survivors(force : Int32)
		@players.each do |player|
			if (player.type == TypeJoueur::AVENTURIER)
				action_deplacer_moi(player, force)
			end
		end
	end

	def defausser(joueur : Player,num_carte : Int32)
		if(num_carte < 0 || num_carte >= joueur.hand.bonus.size())
			raise "Le joueur #{joueur.lobby_id} ne peut pas défausser la carte #{num_carte} !"
		end

		carte : CarteBonus = joueur.hand.bonus.delete_at(num_carte)
		joueur.hand.bonus_size += -1

		if(joueur.type == TypeJoueur::CERBERE)
			pioche_trahison.dis_card(carte.as(CarteTrahison))
		else
			pioche_survie.dis_card(carte.as(CarteSurvie))
		end
	end

	def action_recuperer_carte(joueur : Player) : Nil
		if joueur.type != TypeJoueur::MORT
			joueur.hand.reset(joueur.type)
		#else
		#	raise "Vous êtes mort !"
		end
	end

	def action_piocher_moi(joueur : Player, nombre : Int32, args : Array(Int32) = [] of Int32) : Nil
		# Si l'on passe par la case piocher mais que l'on ne s'arrête pas, on ne
		# pioche pas de cartes
		if((args.size() > 0) && (args[0] != 0) && (args[0] != -1))
			return
		end
		nombre.times do
			if joueur.type == TypeJoueur::AVENTURIER
				joueur.hand.bonus << pioche_survie.draw_card()
				joueur.hand.bonus_size += 1
				joueur.send(Response::NewBonus.new(joueur.hand.bonus[-1].name))
			elsif joueur.type == TypeJoueur::CERBERE
				joueur.hand.bonus << pioche_trahison.draw_card()
				joueur.hand.bonus_size += 1
				joueur.send(Response::NewBonus.new(joueur.hand.bonus[-1].name))
			else
				raise "Vous êtes mort !"
			end
		end
	end

	def action_piocher_allie(joueur : Player, args : Array(Int32)) : Nil
		args.each do |id|
			if id == joueur.lobby_id
				raise "Vous ne pouvez pas vous choisir vous même !"
			end

			if args.size != args.uniq.size
				raise "Vous ne pouvez pas choisir deux fois le même joueur !"
			end

			@players.each do |player|
				if player.lobby_id == id
					if player.type != joueur.type
						raise "Ce joueur n'est pas votre allié !"
					end
					action_piocher_moi(player, 1)
				end
			end
		end
	end

	def action_defausser_moi(joueur : Player, nombre : Int32, args : Array(Int32)) : Nil
		if(nombre < 0 || nombre > joueur.hand.bonus.size())
			raise "Le joueur #{joueur.lobby_id} ne peut pas défausser #{nombre} carte(s) !"
		end
		puts args
		new_args = [] of Int32
		
		nombre.times do |i|
			new_args << args[i]
		end
		puts new_args
		puts joueur.hand.bonus
		# Supprimer les cartes dans l'ordre décroissant des indices :
		# Pour éviter de se casser les couilles avec des décalages
		new_args = new_args.sort { |a, b| b <=> a }
		new_args.each do |carte_index|
			joueur.send(Response::DiscardBonus.new(joueur.hand.bonus[carte_index].name))
			defausser(joueur, carte_index)
		end
	end

	def defausser_tout(p : Player)
		index_def = p.hand.bonus.size - 1
		while index_def >= 0
			defausser(p,index_def)
			index_def -= 1
		end
	end

	def action_defausser_survie(joueur : Player, nombre : Int32, args : Array(Int32)) : Nil
		if args.size != args.uniq.size
			raise "Vous ne pouvez pas choisir deux fois le même joueur !"
		end
		@wait_origin = 0
		args.each do |id|
			if id == joueur.lobby_id
				raise "Vous ne pouvez pas vous choisir vous même !"
			end

			@players.each do |player|
				if player.lobby_id == id
					if player.type != TypeJoueur::AVENTURIER
						raise "Ce joueur n'est pas un aventurier !"
					end
					if(player.hand.bonus.size() > 0)
						awaiting_players << player
						player.send(Response::AskSabotage.new(0))
					end
				end
			end
		end
	end

	def action_defausser_partage(joueur : Player, nombre : Int32) : Int32
		id_allie = demander(joueur, "A qui demander un partage (Id du joueur) ?").to_i

		if id_allie == joueur.lobby_id
			raise "Vous ne pouvez pas vous choisir vous même !"
		end

		nb_cartes = 0

		@players.each do |player|
			if player.lobby_id == id_allie
				if player.type != joueur.type
					raise "Ce joueur n'est pas votre allié !"
				end

				# Demande du partage
				envoyer(player, "Le joueur #{joueur.lobby_id} demande un partage de #{nombre} cartes.")
				nb_cartes = demander(player, "Combien voulez-vous en partager ? [0, #{nombre}]").to_i

				# Si partage accepté
				if nb_cartes > 0
					nb_cartes.times do
						index = demander(player, "Quelle carte défausser ?").to_i
						action_defausser_moi(player, 1, [index])
					end
				end
			end
		end

		return nb_cartes
	end

	def action_changer_vitesse(valeur : Int32) : Nil
		@vitesse_cerbere += valeur

		if @vitesse_cerbere > 8
			@vitesse_cerbere = 8
		elsif @vitesse_cerbere < 3 #difficulty ici a la place de 3
			@vitesse_cerbere = 3 #difficulty ici a la place de 3
		end
	end

	def action_changer_rage(valeur : Int32) : Nil
		@rage_cerbere += valeur

		if @rage_cerbere > 10
			@rage_cerbere = 10
		elsif @rage_cerbere < (1 + @nombre_pions_jauge)
			@rage_cerbere = 1 + @nombre_pions_jauge
		end
	end

	def can_pay_cost(who : Player, effect : Effet) : Bool
		case effect.evenement
		when Evenement::RIEN
			return true
		when Evenement::DEFAUSSER_MOI
			return who.hand.bonus.size() >= effect.force
		when Evenement::DEFAUSSER_PARTAGE
			nb_cards_allies_total : Int32 = 0
			players.each do |player|
				if(player.type == who.type)
				nb_cards_allies_total += player.hand.bonus.size()
				end
			end
			return nb_cards_allies_total >= effect.force
		when Evenement::CHANGER_VITESSE
			new_speed : Int32 = @vitesse_cerbere + effect.force
			return new_speed >= 3 && new_speed <= 8
		when Evenement::CHANGER_RAGE
			new_rage : Int32 = @rage_cerbere + effect.force
			return new_rage >= 1 + @nombre_pions_jauge && new_rage <= 10
		when Evenement::DEPLACER_MOI
			new_position : Int32 = who.position + effect.force
			return new_position >= 1 && new_position <= nodes.size()
		when Evenement::DEPLACER_AUTRE
			# Ca devrait théoriquement être toujours vrai car ce coût n'affecte
			# que les Cerbères, et s'il n'y aurait plus aucun survivant, la
			# partie devrait être finie, mais ça ne coûte rien de vérifier !
			nb_other_survivors : Int32 = 0
			players.each do |player|
				if(player.type == TypeJoueur::AVENTURIER && player.lobby_id != who.lobby_id)
				nb_other_survivors += 1
				end
			end
			return nb_other_survivors > 0
		else
			raise "Cet événement ne peut pas être un coût !"
		end
	end

	def check_args_are_valid(who : Player, effect : Effet, args : Array(Int),
				strict : Bool = false) : Bool
		case effect.evenement
		when Evenement::PIOCHER_ALLIE
			check : Bool = args.size() <= effect.force &&
				(!strict || args.size() == effect.force) &&
				args.size() == args.uniq().size()
			i : Int32 = 0
			while(i < args.size() && check)
				if(args[i] == who.lobby_id)
					check &= false
				else
					players.each do |player|
						if(player.lobby_id == args[i])
							if(player.type != who.type)
								check &= false
								break
							end
						end
					end
				end
				i += 1
			end
			return check
		when Evenement::DEFAUSSER_MOI
			check = args.size() == effect.force
			args.each do |arg|
				if(arg < 0 || arg >= who.hand.bonus.size())
					check = false
					break
				end
			end
			return check
		when Evenement::DEFAUSSER_SURVIE
			check = args.size() <= effect.force &&
				(!strict || args.size() == effect.force) &&
				args.size() == args.uniq().size()
			i = 0
			while(i < args.size() && check)
				if(args[i] == who.lobby_id)
					check &= false
					break
				end
				players.each do |player|
					if(player.lobby_id == args[i])
						if(player.type != TypeJoueur::AVENTURIER)
							check &= false
						end
						break
					end
				end
				i += 1
			end
			return check
		when Evenement::DEPLACER_AUTRE
			if(args.size() == 0)
				return !strict
			elsif(args.size() == 1)
				if(args[0] == who.lobby_id)
					return false
				end
				players.each do |player|
					if(player.lobby_id == args[0])
						return player.type == TypeJoueur::AVENTURIER
						break
					end
				end
				return false
			else
				return false
			end
		when Evenement::BARQUE
			if(args.size() == 0)
				return false
			else
				if(args[0] == 0) # Consulter
					return args.size() == 2 && args[0] >= 0 && args[0] <= 2
				elsif(args[0] == 1) # Echanger
					return args.size() == 3 && args[0] >= 0 && args[0] <= 2 && args[1] >= 0 && args[1] <= 2
				else
					return false
				end
			end
		else 	# Tous les autres événements, soit ne prennent pas d'arguments,
			# soit sont gérés seulement par le plateau
			return true
		end
	end

	def play_card(who : Player, action : Bool, index_card : Int, choice : Int, args : Array(Array(Int)))
		assert(!(index_card < 0 || ((!action && index_card >= who.hand.bonus.size()) || (action && index_card >= 4))))
		card : Carte
		if(action)
			card = Hand.actions_of(who.type)[index_card]
			assert(who.hand.action[index_card])
		else
			card = who.hand.bonus[index_card]
		end
		assert(!(choice < 0 || choice >= card.choix.size()))
		choice = card.choix[choice]
		assert(!(args.size() < choice.effets.size() + 1))
		assert(can_pay_cost(who,choice.cout))
		assert(check_args_are_valid(who, choice.cout, args[0], true))
		choice.effets.each_index do |i|
			assert(check_args_are_valid(who, choice.effets[i], args[i+1]))
		end
		# Si on arrive ici, c'est que tous les arguments sont OK.
		if(action)
			who.hand.action[index_card] = false
		end
		faire_action(who, choice.cout, args[0])
		choice.effets.each_index do |i|
			faire_action(who, choice.effets[i], args[i+1])
		end
		# On défausse la carte bonus après que ses effets soient
		# appliqués et on calcule sa nouvelle position, pour éviter les
		# problèmes de décalage des index
		if(!action)
			new_card_index : Int32? = who.hand.bonus.index(card)
			if(new_card_index == nil)
				raise "La carte jouée n'est plus dans la main du joueur !"
			end
			defausser(who, new_card_index.not_nil!())
		end
	end

	def faire_action(moi : Player, effet : Effet, args : Array(Int32) = [] of Int32)
		case effet.evenement
		when Evenement::RIEN
			return false
		when Evenement::RECUPERER_CARTE
			action_recuperer_carte(moi)
		when Evenement::PIOCHER_MOI
			action_piocher_moi(moi, effet.force, args)
		when Evenement::PIOCHER_ALLIE
			action_piocher_allie(moi, args)
		when Evenement::DEFAUSSER_MOI
			action_defausser_moi(moi, effet.force, args)
		when Evenement::DEFAUSSER_SURVIE
			action_defausser_survie(moi, effet.force, args)
		when Evenement::DEFAUSSER_PARTAGE
			action_defausser_partage(moi, effet.force)
		when Evenement::CHANGER_VITESSE
			action_changer_vitesse(effet.force)
		when Evenement::CHANGER_RAGE
			action_changer_rage(effet.force)
		when Evenement::DEPLACER_MOI
			action_deplacer_moi(moi, effet.force)
		when Evenement::DEPLACER_AUTRE
			action_move_other_player(moi, effet.force, args)
		when Evenement::DEPLACER_AVENTURIERS
			action_move_all_survivors(effet.force)
		when Evenement::DEPLACER_CERBERE
			action_move_cerbere(effet.force)
		when Evenement::BARQUE
			action_barque(moi,args)
		when Evenement::COUARDISE
			action_couardise(moi)
		when Evenement::SABOTAGE
			action_sabotage()
		when Evenement::PROMONTOIRE
			action_promontoire(moi, args)
		when Evenement::FUNICULAIRE
			return action_funiculaire(moi, effet.force, args)
		when Evenement::PILOTIS
			action_pilotis(moi, args)
		when Evenement::PORTAIL
			return action_portail(moi, effet.force, args)
		when Evenement::REVELER_BARQUE
			action_reveler_barque(moi)
		when Evenement::VERIFIER_BARQUE
			action_verif_barque()
		when Evenement::PONT
			return action_pont(moi, effet.force, args)
		else
			raise "L'effet #{effet.evenement} est invalide !"
		end
	end
end
