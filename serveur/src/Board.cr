require "./Node.cr"
require "./player.cr"
require "./board_0.cr"
require "./deck.cr"


class Cerbere::Board
    getter nodes : Array(Node)
    property difficulty : Int32
    property barques : Array(Int32) = [1, 2, 3].shuffle
    property rage_cerbere : Int32
    property vitesse_cerbere : Int32
    property position_cerbere : Int32 = 0
    property players : Array(Player) = [] of Player
    property nombre_pions_jauge : Int32
    property pioche_survie : DeckSurvie = DeckSurvie.new
    property pioche_trahison : DeckTrahison = DeckTrahison.new

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
          if !has_moved && (moi.position > 1 || moi.position < nodes.size - 1)
            moi.position += force > 0 ? 1 : -1 # Déplacement vers la gauche ou la droite
          end

          if (moi.position <= position_cerbere)
            # appel à une fonction capture pour changer le rôle du joueur et renvoyer Cerbère au dernier checkpoint
            puts "Le joueur #{moi.lobby_id} s'est fait attrapé par Cerbère !"
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
            if(choix == 0) # Consulter une barque
                if(args.size() < 2 || args[1] < 0 || args[1] > 2)
                    raise "Argument barque manquant ou invalide pour BARQUE consulter"
                end
                info_barque : String = "Capacité de la barque #{args[1]}: #{barques[args[1]]}"
                envoyer(moi,info_barque)
            elsif(choix == 1) # Echanger deux barques
                if(args.size() < 3 || args[1] < 0 || args[1] > 2 || args[2] < 0 || args[2] > 2 || args[1] == args[2])
                    raise "Arguments barques manquants ou invalides pour BARQUE échanger"
                end
                barques.swap(args[1],args[2])
                broadcast("Les barques #{args[1]} et #{args[2]} ont été échangées.")
            end
        end
    end

    def action_reveler_barque(moi : Player)
        if(@barques.size == 3)
          @barques.pop(2)
        end
        puts "La barque à #{barques[0]} place(s) a été révélée !"
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
      else
        puts "Il manque #{barques[0] - nb_assis} personne(s) pour partir !"
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
      res = demander(moi, "Prendre le pont ? O/N")
      # Si un joueur prend le pont de cordes, il s'écroule et n'est plus utilisable
      if(res == "O")
        nodes[moi.position].effect.evenement = Evenement::RIEN
        moi.position += id_pont == 1 ? -4 : 4 #On se sert de la force pour déterminer de quel côté du pont on se trouve
        nodes[moi.position].effect.evenement = Evenement::RIEN
      else
        puts "Refus"
        emprunte = false
      end

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
        res = demander(moi, "Prendre le portail ? O/N")
        if(res != "O")
          puts "Refus"
          emprunte = false
        elsif(id_portail == 1)
          moi.position -= 3
        else
          moi.position += 3
        end
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
        action_deplacer_moi(moi, -2)
        broadcast("Le joueur #{moi.lobby_id} a avancé de #{deplacement} cases.")
    end

    def action_sabotage() : Int32
        compte_rendu : Array({Int32,Int32}) = [] of {Int32,Int32}
        players.each do |player|
            if(player.type = TypeJoueur::AVENTURIER)
                if(player.hand.bonus.size() == 0)
                    action_deplacer_moi(player, -2)
                    compte_rendu.push({player.lobby_id,0})
                else
                    choix : Int32 = 0
                    loop do
                        choix = demander(player,"Defausser une carte (0) ou reculer (1) ?").to_i32()
                        break if(choix.in?(0,1))
                    end
                    if(choix == 0) # Défausser une carte
                        carte : Int32 = 0
                        if(player.hand.bonus.size() == 1)
                            carte = 0
                        else
                            loop do
                                carte = demander(player,"Quelle carte défausser ? [0,#{player.hand.bonus.size()-1}]").to_i32()
                                break if(choix >= 0 && choix < player.hand.bonus.size())
                            end
                        end
                        defausser(player,carte)
                        compte_rendu.push({player.lobby_id,1})
                    elsif(choix == 1) # Reculer
                        action_deplacer_moi(player, -2)
                        compte_rendu.push({player.lobby_id,0})
                    end
                end
            end
        end
        resultat : String = ""
        compte_rendu.each do |ligne|
            if(ligne[1] == 0)
                resultat += "Le joueur #{ligne[0]} a reculé. "
            elsif(ligne[1] == 1)
                resultat += "Le joueur #{ligne[0]} a défaussé une carte. "
            end
        end
        broadcast(resultat)
        return 0
    end

    #DEPLACER_CERBERE # Cerbère se déplace sur le plateau


    def index_capture(tab_players : Array(Player),pos_cer : Int32, finalpos : Int32)

        final = finalpos
        first_pos = pos_cer

        i = 0
        min = nodes.size - 1
        capture = 0
        tab_players.each do |p|
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
        i = pos_cerb
        while i > 0 && !nodes[i].checkpoint_cerbere
            i -= 1
        end

        @position_cerbere = i

    end

    def action_move_cerbere(force : Int32)
        size_board = nodes.size
        tmp = @position_cerbere + force
        pos_max = 0

        if ((force > 0) && (tmp < size_board))
            pos_max = tmp
        elsif ((force < 0) && (tmp >= 0))
            pos_max = tmp
        else
            raise "Sortie du plateau !!"
        end
        #Si on a avance de 1 et qu'on a des joueurs sur la case alors on lance la fonction
        #capture ('new cerbere = aventurier sur case')

        capturable = index_capture(@players,@position_cerbere,pos_max)

        if(capturable != -1)
            i = 0
            @players.each do |p|
                if (p.position == capturable) #on va capturer les joueurs
                    #Créer une méthode capture qui fait les effets suivants :
                        #Checker si c'est l'un des 2 aventuriers alors ils sont éliminer
                        #Savoir où on le capture pour savoir si il pioche une ou 2 ou 0
                        #Defausser carte action, piocher les carte action coté cerbere
                        #changer la position a 0 du joueur et changer son type
                    p.type = TypeJoueur::CERBERE #cerbere
                    p.position = 0 #on met les joueurs a 0
                end
                i += 1
            end
            pos_cerb = @position_cerbere + capturable
            lastcheckpoint(pos_cerb)
        else
            @position_cerbere = tmp
        end
    end


    #DEPLACER_AUTRE # Le joueur déplace d'autres survivants

    def action_move_other_player(moi : Player, force : Int32, args : Array(Int32))
        player_id = args[0] # id du joueur à déplacer
        my_id = moi.lobby_id

        if my_id == player_id
          raise "Le joueur à déplacer ne peut pas être le joueur actif !"
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

    #DEPLACER_SURVIVANTS # Tous les survivants se déplacent

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

        if(joueur.type == TypeJoueur::CERBERE)
            pioche_trahison.dis_card(carte.as(CarteTrahison))
        else
            pioche_survie.dis_card(carte.as(CarteSurvie))
        end
    end

    def action_recuperer_carte(joueur : Player) : Nil
        if joueur.type != TypeJoueur::MORT
            joueur.hand.reset(joueur.type)
        else
            raise "Vous êtes mort !"
        end
    end

    def action_piocher_moi(joueur : Player, nombre : Int32) : Nil
        nombre.times do
            if joueur.type == TypeJoueur::AVENTURIER
                joueur.hand.bonus << pioche_survie.draw_card()
            elsif joueur.type == TypeJoueur::CERBERE
                joueur.hand.bonus << pioche_trahison.draw_card()
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
        # Supprimer les cartes dans l'ordre croissant des indices :
        # Les cartes après la carte supprimée voir leur indice baisser de 1
        decalage = 0
        args.sort.each do |carte_index|
            defausser(joueur, carte_index - decalage)
            decalage += 1
        end
    end

    def action_defausser_survie(joueur : Player, nombre : Int32, args : Array(Int32)) : Nil
        args.each do |id|
            if id == joueur.lobby_id
                raise "Vous ne pouvez pas vous choisir vous même !"
            end

            if args.size != args.uniq.size
                raise "Vous ne pouvez pas choisir deux fois le même joueur !"
            end

            @players.each do |player|
                if player.lobby_id == id
                    if player.type != TypeJoueur::AVENTURIER
                        raise "Ce joueur n'est pas un aventurier !"
                    end
                    index = demander(player, "Quelle carte défausser ?").to_i
                    action_defausser_moi(player, 1, [index])
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
        elsif @vitesse_cerbere < 3
            @vitesse_cerbere = 3
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

    def faire_action(moi : Player, effet : Effet, args : Array(Int32) = [] of Int32)
        case effet.evenement
        when Evenement::RIEN
            return false
        when Evenement::RECUPERER_CARTE
            action_recuperer_carte(moi)
        when Evenement::PIOCHER_MOI
            action_piocher_moi(moi, effet.force)
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
