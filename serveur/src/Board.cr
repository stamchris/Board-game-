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

    def envoyer(qui : Player,quoi : String)
        # Envoie une information qui n'est destiné qu'à un joueur particulier
        # Pour le moment, on parle via la ligne de commande, plus tard, il
        # faudra contacter le client
        puts "Joueur "+qui.lobbyId.to_s()+": "+quoi
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

    def action_couardise(moi : Player)
        nbJoueursDevant : Int32 = 0
        players.each do |player|
            if(player.position > moi.position)
                nbJoueursDevant += 1
            end
        end
        deplacement : Int32 = Math.min(nbJoueursDevant,3)
        faire_action(moi,Effet.new(Evenement::DEPLACER_MOI,deplacement))
        broadcast("Le joueur #{moi.lobbyId} a avancé de #{deplacement} cases.")
    end

    def action_sabotage() : Int32
        compte_rendu : Array({Int32,Int32}) = [] of {Int32,Int32}
        players.each do |player|
            if(player.typeJoueur == 1) # Aventurier
                if(player.myHand.myCartesBonus.size() == 0)
                    faire_action(player,Effet.new(Evenement::DEPLACER_MOI,-2))
                    compte_rendu.push({player.lobbyId,0})
                else
                    choix : Int32 = 0
                    loop do
                        choix = demander(player,"Defausser une carte (0) ou reculer (1) ?").to_i32()
                        break if(choix.in?(0,1))
                    end
                    if(choix == 0) # Défausser une carte
                        carte : Int32 = 0
                        if(player.myHand.myCartesBonus.size() == 1)
                            carte = 0
                        else
                            loop do
                                carte = demander(player,"Quelle carte défausser ? [0,#{player.myHand.myCartesBonus.size()-1}]").to_i32()
                                break if(choix >= 0 && choix < player.myHand.myCartesBonus.size())
                            end
                        end
                        defausser(player,carte)
                        compte_rendu.push({player.lobbyId,1})
                    elsif(choix == 1) # Reculer
                        faire_action(player,Effet.new(Evenement::DEPLACER_MOI,-2))
                        compte_rendu.push({player.lobbyId,0})
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

    def faire_action(moi : Player,effet : Effet,args : Array(Int32) = [] of Int32)
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
            action_barque(moi,args)
        when Evenement::COUARDISE
            action_couardise(moi)
        when Evenement::SABOTAGE
            action_sabotage()
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
