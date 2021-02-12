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
            piocheTrahison.disCard(carte.as(CarteTrahison))
        else # Aventurier ou Eliminé (était Aventurier)
            piocheSurvie.disCard(carte.as(CarteSurvie))
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

    def envoyer(qui : Player,quoi : String)
        # Envoie une information qui n'est destiné qu'à un joueur particulier
        # Pour le moment, on parle via la ligne de commande, plus tard, il
        # faudra contacter le client
        puts "Joueur "+qui.lobbyId.to_s()+": "+quoi
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
        end
    end
end
