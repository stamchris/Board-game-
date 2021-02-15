require "./node.cr"
require "./player.cr"
require "./board_0.cr"

class Board
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
            @players << Player.new(user.user_id)
        end

       # Initialisation des variables de jeu
       @rage_cerbere = 8 - users.size
       @vitesse_cerbere = 3 + difficulty
       @nombre_pions_jauge = 7 - users.size
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

    def envoyer(qui : Player,quoi : String)
        # Envoie une information qui n'est destiné qu'à un joueur particulier
        # Pour le moment, on parle via la ligne de commande, plus tard, il
        # faudra contacter le client
        puts "Joueur "+qui.lobby_id.to_s()+": "+quoi
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
        joueur.hand.reset()
    end

    def action_changer_rage(valeur : Int32) : Nil
        @rage_cerbere += valeur

        if @rage_cerbere > 10
            @rage_cerbere = 10
        elsif @rage_cerbere < (1 + @nombre_pions_jauge)
            @rage_cerbere = 1 + @nombre_pions_jauge
        end
    end

    def action_changer_vitesse(valeur : Int32) : Nil
        @vitesse_cerbere += valeur

        if @vitesse_cerbere > 8
            @vitesse_cerbere = 8
        elsif @vitesse_cerbere < 3
            @vitesse_cerbere = 3
        end
    end

    def faire_action(moi : Player, effet : Effet, args : Array(Int32))
        case effet.evenement
        when Evenement::RIEN
            # RIEN
        when Evenement::RECUPERER_CARTE
            action_recuperer_carte(moi)
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
            action_changer_vitesse(effet.force)
        when Evenement::CHANGER_RAGE
            action_changer_rage(effet.force)
        when Evenement::DEPLACER_MOI
            # ...
        when Evenement::DEPLACER_AUTRE
            # ...
        when Evenement::DEPLACER_AVENTURIERS
            # ...
        when Evenement::DEPLACER_CERBERE
            # ...
        when Evenement::BARQUE
            # ...
        when Evenement::COUARDISE
            # ...
        when Evenement::SABOTAGE
            # ...
        when Evenement::ACTIVER_PORTAIL
            # ...
        when Evenement::REVELER_BARQUE
            # ...
        when Evenement::VERIFIER_BARQUE
            # ...
        when Evenement::ENTREE_PONT
            # ...
        when Evenement::SORTIE_PONT
            # ...
        else
            raise "L'effet #{effet.evenement} est invalide !"
        end
    end
end