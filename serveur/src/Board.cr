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

    #DEPLACER_MOI # Le joueur se déplace

    def action_mouv_player(player : Player,force : Int32)
        size_board = nodes.size
        tmp =  player.position + force
        pos_max = 0

        if (player.typeJoueur != 1) #lever d'erreur
            raise "Pas un aventurier"
        end
       
        if ((force > 0) && (tmp < size_board) && (player.typeJoueur == 1)) 
            pos_max = tmp
            i = player.position 
            while ((i < pos_max) && (i != @positionCerbere))
                i +=  1
            end
               
            player.position = i
    

        elsif ((force < 0)  && (player.typeJoueur == 1))
            pox_max = tmp
            i = player.position 
            while ((i > 1) && (i != @positionCerbere))
                i -= 1
            end

            if (i > 1)
                #case cerbere
                #Appel de la futur méthode capture voir lignes 172-176
                player.typeJoueur = 2
                player.position = 0 
            
            else
                player.position = i
            end
        end
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
        while i > 0 && !nodes[i].checkpointCerbere
            i -= 1
        end

        @positionCerbere = i

    end

    def action_mouv_cerbere(force : Int32)
        size_board = nodes.size 
        tmp = @positionCerbere + force
        pos_max = 0

        if ((force > 0) && (tmp < size_board))
            pos_max = tmp
        elsif ((force < 0) && (tmp >= 0))
            pox_max = tmp
        else
            raise "Sortie du plateau !!"
        end
        #Si on a avance de 1 et qu'on a des joueurs sur la case alors on lance la fonction
        #capture ('new cerbere = aventurier sur case')
       
        capturable = index_capture(@players,@positionCerbere,pos_max)
        
        if(capturable != -1)
            i = 0 
            @players.each do |p|
                if (p.position == capturable) #on va capturer les joueurs 
                    #Créer une méthode capture qui fait les effets suivants : 
                        #Checker si c'est l'un des 2 aventuriers alors ils sont éliminer
                        #Savoir où on le capture pour savoir si il pioche une ou 2 ou 0
                        #Defausser carte action, piocher les carte action coté cerbere
                        #changer la position a 0 du joueur et changer son type
                    p.typeJoueur = 2 #cerbere
                    p.position = 0 #on met les joueurs a 0 
                end
                i += 1
            end
            pos_cerb = @positionCerbere + capturable
            lastcheckpoint(pos_cerb)
        else 
            @positionCerbere = tmp
        end
    end


    #DEPLACER_AUTRE # Le joueur déplace d'autres survivants
	

    def action_mouv_other_player(mouv_player : Player, mouving_players : Array(Player),
                            forces : Array(Int32))
        #Le premier Player du tableau mouving_players , 
        #correspond à la première force du tableau forces
        not_touch_id = mouv_player.lobbyId
        i = 0
        mouving_players.each do |plyr|
            if (plyr.typeJoueur == 1) && (plyr.lobbyId != not_touch_id)
                action_mouv_player(mouving_players[i],forces[i]) #remplacer par deplacer_moi
            end
            i += 1
        end
        
    end


    #DEPLACER_SURVIVANTS # Tous les survivants se déplacent

    def action_mouv_all_survivors(force : Int32)
        @players.each do |plyr|
            if (plyr.typeJoueur == 1)
                action_mouv_player(plyr,force) #remplacer par deplacer_moi
            end
        end
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
