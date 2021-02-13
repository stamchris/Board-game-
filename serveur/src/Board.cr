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

    def action_barque(moi : Player,args : Array(Int32)) : Int32
        if(args.size() == 0)
            return 1
        end
        choix : Int32 = args[0]
        if(choix == 0)
            infos_barques : String = "#{barques[0]},#{barques[1]},#{barques[2]}"
            envoyer(moi,infos_barques)
        elsif(choix == 1)
            if(args.size() < 3)
                return 1
            end
            tmp : Int32 = barques[args[1]]
            barques[args[1]] = barques[args[2]]
            barques[args[2]] = tmp
        end
        return 0
    end

    def action_couardise(moi : Player) : Int32
        nbJoueursDevant : Int32 = 0
        players.each do |player|
            if(player.position > moi.position)
                nbJoueursDevant += 1
            end
        end
        moi.position += Math.min(nbJoueursDevant,3)
        return 0
    end

    def action_sabotage() : Int32
        players.each do |player|
            if(player.typeJoueur == 1) # Aventurier
                if(player.myHand.myCartesBonus.size() == 0)
                    player.position -= 2
                else
                    str_demander_choix : String = "Defausser une carte (0) ou reculer (1) ?"
                    choix : Int32 = demander(player,str_demander_choix).to_i32()
                    while(([choix] & [0,1]).size() == 0)
                        choix = demander(player,str_demander_choix).to_i32()
                    end
                    if(choix == 0)
                        carte : Int32 = 0
                        if(player.myHand.myCartesBonus.size() == 1)
                            carte = 0
                        else
                            str_demander_carte : String = "Quelle carte défausser ? [0,#{player.myHand.myCartesBonus.size()-1}]"
                            carte = demander(player,str_demander_carte).to_i32()
                            while(carte < 0 || carte >= player.myHand.myCartesBonus.size())
                                carte = demander(player,str_demander_carte).to_i32()
                            end
                        end
                        player.myHand.myCartesBonus.delete_at(carte)
                    elsif(choix == 1)
                        player.position -= 2
                    end
                end
            end
        end
        return 0
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
