require "./Node.cr"
require "./Player.cr"
require "./BOARD_0.cr"

class Board
    getter nodes : Array(Node)
    property barques : Array(Int32) = [1, 2, 3].shuffle
    property rageCerbere : Int32
    property vitesseCerbere : Int32
    property positionCerbere : Int32 = 0
    property players : Array(Player) = [] of Player
    property piocheSurvie : DeckSurvie = DeckSurvie.new
    property piocheTrahison : DeckTrahison  = DeckTrahison.new

    def initialize(difficulty : Int32, users : Array(User))

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

        # Creation d'un Player pour chaque User
        users.each do |user|
            @players << Player.new(user.userId)
        end

        # Initialisation des variables de jeu
        @rageCerbere = 8 - users.size
        @vitesseCerbere = 3 + difficulty # A redefinir
    end

    def defausser(joueur : Player,num_carte : Int32)
        if(num_carte < 0 || num_carte >= joueur.myHand.myCartesBonus.size())
            raise "Le joueur #{joueur.lobbyId} ne peut pas défausser la carte #{num_carte} !"
        end
        carte : CarteBonus = joueur.myHand.myCartesBonus.delete_at(num_carte)
        if(joueur.typeJoueur == 2) # Cerbère
            piocheTrahison.dis_card(carte.as(CarteTrahison))
        else # Aventurier ou Eliminé (était Aventurier)
            piocheSurvie.dis_card(carte.as(CarteSurvie))
        end
    end

    def demander(qui : Player,quoi : String) : String
        # Demande une entrée supplémentaire à un joueur particulier
        # Pour le moment, on demande via la ligne de commande, plus tard, il
        # faudra contacter le client
        puts "Joueur "+qui.lobbyId.to_s()+": "+quoi
        res : String? = gets
        return res == Nil ? "" : res.to_s
    end

    def deplacer_moi(player : Player, force : Int32)
        nb_moves = force.abs

        while (nb_moves > 0)
          # Si l'effet de la case n'a pas changé la position du joueur et qu'il n'essaye pas d'avancer ou reculer hors du plateau
          if !faire_action(player, nodes[player.position].effect, [nb_moves, force]) && (player.position > 1 && force < 0 || player.position < nodes.size - 1 && force > 0)
            player.position = force > 0 ? player.position + 1 : player.position - 1
          end

          if (player.position <= positionCerbere)
            # appel à une fonction capture pour changer le rôle du joueur et renvoyer Cerbère au dernier checkpoint
            puts "Le joueur #{player.lobbyId} s'est fait attrapé par Cerbère !"
            return
          end

          nb_moves -= 1
        end

        faire_action(player, nodes[player.position].effect, [nb_moves, force]) # appliquer l'effet de la case d'arrivée
    end

    def envoyer(qui : Player,quoi : String)
        # Envoie une information qui n'est destiné qu'à un joueur particulier
        # Pour le moment, on parle via la ligne de commande, plus tard, il
        # faudra contacter le client
        puts "Joueur "+qui.lobbyId.to_s()+": "+quoi
    end

    def reveler_barque(player : Player)
        @barques.pop(2)
        nodes[player.position].effect.evenement = Evenement::RIEN # L'action ne peut être effectuée qu'une fois, on réinitialise donc l'effet
        puts "La barque à #{barques[0]} place(s) a été révélée !"
    end

    def verifier_barque()
      nb_assis = 0
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

    def pont(player : Player, force : Int32) : Bool
      emprunte = true # permet d'indiquer si on a emprunté le pont à la fonction deplacer_moi
      res = demander(player, "Prendre le pont ? O/N")
      # Si un joueur prend le pont de cordes, il s'écroule et n'est plus utilisable
      if(res == "O")
        nodes[player.position].effect.evenement = Evenement::RIEN
        player.position = force == 1 ? player.position - 4 : player.position + 4 #On se sert de la force pour déterminer de quel côté du pont on se trouve
        nodes[player.position].effect.evenement = Evenement::RIEN
      else
        puts "Refus"
        emprunte = false
      end

      return emprunte
    end

    def portail(player : Player, force : Int32) : Bool
      stele = force == 1 ? (player.position - 1) : (player.position + 2) # Position de la stèle qui active le portail
      actif = false
      emprunte = true # permet d'indiquer si on a emprunté le portail à la fonction deplacer_moi

      players.each do |player|
        if(player.position == stele) # Si un joueur se trouve sur la stèle, le portail est actif
          actif = true
          break
        end
      end

      if(actif)
        res = demander(player, "Prendre le portail ? O/N")
        if(res != "O")
          puts "Refus"
          emprunte = false
        elsif(force == 1) # On se sert de la force pour déterminer de quel portail il s'agit
          player.position -= 3
        else
          player.position += 3
        end
      else
        puts "Portail non disponible !"
        emprunte = false
      end

      return emprunte
    end


    def faire_action(moi : Player,effet : Effet,args : Array(Int32))
        case effet.evenement
        when Evenement::RIEN
            # ...
        when Evenement::RECUPERER_CARTE
            # ...
        when Evenement::PIOCHER_MOI
            # ...
        when Evenement::PIOCHER_ALLIE
            # ...
        when Evenement::DEFAUSSER_MOI
            # ...
        when Evenement::DEFAUSSER_SURVIE
            # ...
        when Evenement::DEFAUSSER_PARTAGE
            # ...
        when Evenement::CHANGER_VITESSE
            # ...
        when Evenement::CHANGER_COLERE
            # ...
        when Evenement::DEPLACER_MOI
            # ...
        when Evenement::DEPLACER_AUTRE
            # ...
        when Evenement::DEPLACER_SURVIVANTS
            # ...
        when Evenement::DEPLACER_CERBERE
            # ...
        when Evenement::BARQUE
            # ...
        when Evenement::COUARDISE
            # ...
        when Evenement::SABOTAGE
            # ...
        when Evenement::PORTAIL
            if (args[0] != 0) && (effet.force == 0 && args[1] > 0 || effet.force == 1 && args[1] < 0)
              return portail(moi, effet.force)
            end
        when Evenement::REVELER_BARQUE
            reveler_barque(moi)
        when Evenement::VERIFIER_BARQUE
            verifier_barque
        when Evenement::PONT
            if (args[0] != 0) && (effet.force == 0 && args[1] > 0 || effet.force == 1 && args[1] < 0)
              return pont(moi, effet.force)
            end
        end
        return false
    end
end
