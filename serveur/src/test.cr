require "./player.cr"
require "./deck.cr"
require "./game.cr"

class Cerbere::Test
    def self.run
        # Tableau d'utilisateurs fictifs provenant du lobby
        my_players = [
            Player.new(2),
            Player.new(48),
            Player.new(59),
        ] of Player

        # Creation d'une partie
        puts "[Test de creation d'une partie]-------------------------
             "

        myGame : Game = Game.new()
        myGame.start(0, my_players)

        puts "  La partie a #{myGame.number_players} joueurs"
        puts "  La partie est en difficulte #{myGame.difficulty}
             "

        # Affichage des cases
        puts "  Les cases du plateau :"
        myGame.board.nodes.each do |node|
            puts "[#{node.checkpoint_cerbere}, #{node.effect.evenement}]"
        end
        puts

        # Affichage des pioches
        puts "  Les cartes de la pioche Survie :"
        myGame.board.pioche_survie.dump()
        puts

        puts "  Les cartes de la pioche Trahison :"
        myGame.board.pioche_trahison.dump()
        puts

        puts "  Les joueurs sont :"
        a = 1
        myGame.board.players.each do |player|
            puts "PLAYER_ID : #{a}"
            puts "  Le joueur a #{player.hand.action.size} cartes Action"
            puts "  Le joueur a #{player.hand.bonus.size} cartes Survie"
            puts "  Le joueur est de type #{player.type}"
            puts "  Le joueur est a la case #{player.position}"
            puts
            a = a + 1
        end

        puts "  Les attributs du plateau sont :"
        puts "Barques : #{myGame.board.barques}"
        puts "La vitesse est #{myGame.board.vitesse_cerbere}"
        puts "La rage est #{myGame.board.rage_cerbere}"
        puts "La position de Cerbere est #{myGame.board.position_cerbere}"
        puts
    end
end

class Cerbere::TestDeck
    def self.afficher_les_cartes_de(joueur : Player)
        puts "Cartes de Joueur #{joueur.lobby_id}:"
        joueur.hand.bonus.each_index do |index|
            puts "\t#{index} : #{joueur.hand.bonus[index].name}"
        end
    end

    def self.run()
        puts "[Test de la classe Deck]-------------------------
        "

        survie : DeckSurvie = DeckSurvie.new
        trahison : DeckTrahison = DeckTrahison.new

        100.times do
            carteSurvie : CarteSurvie = survie.draw_card()
            puts "Carte Survie piochée: #{carteSurvie.name}"
            carteTrahison : CarteTrahison = trahison.draw_card()
            puts "Carte Trahison piochée: #{carteTrahison.name}"
            survie.dis_card(carteSurvie)
            trahison.dis_card(carteTrahison)
        end

        players = [
            Player.new(1),
            Player.new(2)
        ] of Player

        game : Game = Game.new()
        game.start(0,players)
        game.board.players[1].type = TypeJoueur::CERBERE

        i = 0
        while(i < 7)
            game.board.players[0].hand.bonus.push(game.board.pioche_survie.draw_card())
            game.board.players[1].hand.bonus.push(game.board.pioche_trahison.draw_card())
            i += 1
        end

        afficher_les_cartes_de(game.board.players[0])
        afficher_les_cartes_de(game.board.players[1])

        i = 0
        while(i < 7)
            game.board.defausser(game.board.players[0],0)
            game.board.defausser(game.board.players[1],0)
            afficher_les_cartes_de(game.board.players[0])
            afficher_les_cartes_de(game.board.players[1])
            i += 1
        end

        puts
    end
end

class Cerbere::TestRageVitesse
    def self.afficher_piste(board : Board) : Nil
        s : String = " "

        10.times do |i|
            if i < board.nombre_pions_jauge
                s = s + "[X]"
            elsif (i + 1) == board.rage_cerbere
                s = s + "[#{board.vitesse_cerbere}]"
            else
                s = s + "[ ]"
            end
        end

        puts s
    end

    def self.run() : Nil
        players5 = [
            Player.new(2),
            Player.new(48),
            Player.new(59),
            Player.new(420),
            Player.new(69)
        ] of Player

        puts "[Test des actions modifier rage et vitesse]-------------------------
        "

        game15 : Game = Game.new()
        game15.start(1, players5)

        puts "  Creation de partie avec 5 joueurs et difficulté 1 :"
        afficher_piste(game15.board)
        puts

        puts "  Un joueur fait augmenter la rage de 2 !"
        game15.board.action_changer_rage(2)
        afficher_piste(game15.board)
        puts

        puts "  Un joueur fait diminuer la rage de 1 !"
        game15.board.action_changer_rage(-1)
        afficher_piste(game15.board)
        puts

        puts "  Un joueur fait augmenter la vitesse de 3 !"
        game15.board.action_changer_vitesse(3)
        afficher_piste(game15.board)
        puts

        puts "  Un joueur fait augmenter la rage de 51914 !"
        game15.board.action_changer_rage(51914)
        afficher_piste(game15.board)
        puts

        puts "La chasse commence, un joueur passe dans le camp de cerbère !"
        # Simulation de capture de joueur
        # A ne pas faire manuellement, il faut des méthodes de réinititalisation
        # a appellées après une chasse
        game15.board.nombre_pions_jauge += 1
        game15.board.rage_cerbere = game15.board.nombre_pions_jauge + 1
        game15.board.vitesse_cerbere = 3 + game15.board.difficulty
        afficher_piste(game15.board)
        puts

        puts "  Un joueur fait diminuer la vitesse de 1 !"
        game15.board.action_changer_vitesse(-1)
        afficher_piste(game15.board)
        puts

        puts "  Un joueur fait augmenter la rage de 2 !"
        game15.board.action_changer_rage(2)
        afficher_piste(game15.board)
        puts

        puts "  Un joueur fait diminuer la rage de 57005 !"
        game15.board.action_changer_rage(-57005)
        afficher_piste(game15.board)
        puts
    end
end

class Cerbere::TestPiocheDefausse
    def self.afficher_les_cartes_de(joueur : Player)
        puts "Cartes de Joueur #{joueur.lobby_id}:"
        joueur.hand.bonus.each_index do |index|
            puts "\t#{index} : #{joueur.hand.bonus[index].name}"
        end
        puts
    end

    def self.run
        players5 = [
            Player.new(13),
            Player.new(21),
            Player.new(34),
            Player.new(55),
            Player.new(89)
        ] of Player

        puts "[Test des actions de pioche et défausse]-------------------------
        "
        my_game : Game = Game.new()
        my_game.start(0, players5)

        my_game.board.players[2].type = TypeJoueur::CERBERE
        my_game.board.players[3].type = TypeJoueur::CERBERE
        my_game.board.players[4].type = TypeJoueur::MORT

        puts "  Etat courant de la partie de 5 joueurs :"
        my_game.board.players.each do |player|
            puts "Joueur #{player.lobby_id} est #{player.type}."
            afficher_les_cartes_de(player)
        end

        puts "  Joueur #{my_game.board.players[0].lobby_id} pioche 5 cartes"
        puts "  Joueur #{my_game.board.players[1].lobby_id} pioche 3 cartes"
        puts "  Joueur #{my_game.board.players[2].lobby_id} pioche 2 cartes"
        puts "  Joueur #{my_game.board.players[3].lobby_id} pioche 1 cartes"
        puts
        my_game.board.action_piocher_moi(my_game.board.players[0], 5)
        my_game.board.action_piocher_moi(my_game.board.players[1], 3)
        my_game.board.action_piocher_moi(my_game.board.players[2], 2)
        my_game.board.action_piocher_moi(my_game.board.players[3], 1)

        puts "  Etat courant de la partie de 5 joueurs :"
        my_game.board.players.each do |player|
            afficher_les_cartes_de(player)
        end

        puts "  Joueur #{my_game.board.players[0].lobby_id} fait piocher 1 carte à 1 allié !"
        my_game.board.action_piocher_allie(my_game.board.players[0], [21])

        puts "  Joueur #{my_game.board.players[0].lobby_id} défausse 2 cartes !"
        my_game.board.action_defausser_moi(my_game.board.players[0], 2, [0, 1])
        puts

        puts "  Etat courant de la partie de 5 joueurs :"
        my_game.board.players.each do |player|
            afficher_les_cartes_de(player)
        end

        puts "  Le joueur #{my_game.board.players[3].lobby_id} fait défausser 1 carte à 2 aventuriers !"
        my_game.board.action_defausser_survie(my_game.board.players[3], 2, [13, 21])
        puts

        puts "  Etat courant de la partie de 5 joueurs :"
        my_game.board.players.each do |player|
            afficher_les_cartes_de(player)
        end

        puts "  Le joueur #{my_game.board.players[0].lobby_id} souhaite partager le coût d'une carte.
        Il demande 2 carte."
        cartes_partagees = my_game.board.action_defausser_partage(my_game.board.players[0], 2)
        puts

        puts " Le joueur a accepté de partager #{cartes_partagees} !"
        puts

        puts "  Etat courant de la partie de 5 joueurs :"
        my_game.board.players.each do |player|
            afficher_les_cartes_de(player)
        end
    end
end

class Cerbere::TestCartesAction
    def self.run
        players = [Player.new(1), Player.new(2)] of Player

        my_game : Game = Game.new()
        my_game.start(0, players)

        my_game.board.players[1].type = TypeJoueur::CERBERE
        my_game.board.players[1].hand.reset(TypeJoueur::CERBERE)

        puts "[Test de la récupération des cartes actions]-------------------------
        "

        my_game.board.players.each do |player|
            puts "PLAYER_ID : #{player.lobby_id}"
            puts "  Le joueur est de type #{player.type}"
            player.hand.action.each do |carte|
                puts carte
            end
            puts
        end

        puts "Les joueurs 1 et 2 utilise une carte action !"
        my_game.board.players[0].hand.action.pop
        my_game.board.players[1].hand.action.pop

        puts "Le joueur 2 récupère ces cartes !"
        my_game.board.action_recuperer_carte(my_game.board.players[1])
        puts

        my_game.board.players.each do |player|
            puts "PLAYER_ID : #{player.lobby_id}"
            puts "  Le joueur est de type #{player.type}"
            player.hand.action.each do |carte|
                puts carte
            end
            puts
        end

    end
end

class Cerbere::TestBarque
    def self.run()
        myplayers = [
            Player.new(1),
            Player.new(2)
        ] of Player

        myGame : Game = Game.new()
        myGame.start(0,myplayers)

        puts "Barques : #{myGame.board.barques}"

        myGame.board.faire_action(myGame.board.players[0],Effet.new(Evenement::BARQUE,0),[0,0])
        myGame.board.faire_action(myGame.board.players[1],Effet.new(Evenement::BARQUE,0),[1,0,1])

        puts "Barques : #{myGame.board.barques}"
    end
end

class Cerbere::TestCouardise
    def self.afficherPositions(players : Array(Player))
        players.each do |player|
            puts "Joueur #{player.lobby_id}: #{player.position}"
        end
    end

    def self.run()
        myplayers = [
            Player.new(1),
            Player.new(2),
            Player.new(3),
            Player.new(4),
            Player.new(5),
            Player.new(6),
            Player.new(7)
        ] of Player

        myGame : Game = Game.new()
        myGame.start(0,myplayers)

        myGame.board.players.each do |player|
            player.position = player.lobby_id
        end
        afficherPositions(myGame.board.players)

        myplayers.each_index do |i|
            puts "Joueur #{myGame.board.players[i].lobby_id} utilise Couardise"
            myGame.board.faire_action(myGame.board.players[i],Effet.new(Evenement::COUARDISE,0),[] of Int32)
            afficherPositions(myGame.board.players)
        end
    end
end

class Cerbere::TestPlateau
    def self.afficher_positions(joueurs : Array(Player))
        puts "Positions des joueurs :"
        joueurs.each do |joueur|
            puts "\t#{joueur.lobby_id} : #{joueur.position}"
        end
    end

    def self.run()
        players = [
            Player.new(1),
            Player.new(2),
            Player.new(3),
            Player.new(4)
        ] of Player

        game : Game = Game.new()
        game.start(0,players)

        game.board.players[0].position = 9
        game.board.players[1].position = 17
        game.board.players[2].position = 16
        game.board.players[3].position = 8
        game.board.position_cerbere = 7

        game.board.action_promontoire(game.board.players[0], [0])

        game.board.action_deplacer_moi(game.board.players[0], -3)
        afficher_positions(game.board.players)

        game.board.action_deplacer_moi(game.board.players[1], -2)
        afficher_positions(game.board.players)

        game.board.action_deplacer_moi(game.board.players[2], 3)
        afficher_positions(game.board.players)

        game.board.action_deplacer_moi(game.board.players[3], 3)
        afficher_positions(game.board.players)

        game.board.action_deplacer_moi(game.board.players[1], 2)
        afficher_positions(game.board.players)
    end
end

class Cerbere::TestSabotage
    def self.afficherEtat(players : Array(Player))
        players.each do |player|
            puts "Joueur #{player.lobby_id}: position: #{player.position} n_cards: #{player.hand.bonus.size()}"
        end
    end

    def self.run()
        myplayers = [
            Player.new(1),
            Player.new(2),
            Player.new(3),
            Player.new(4),
            Player.new(5),
            Player.new(6),
            Player.new(7)
        ] of Player

        myGame : Game = Game.new()
        myGame.start(0,myplayers)

        myGame.board.players.each do |player|
            player.position = 3
            (player.lobby_id-1).times do
                player.hand.bonus << myGame.board.pioche_survie.draw_card()
            end
        end

        puts "Etat initial:"
        afficherEtat(myGame.board.players)

        myGame.board.faire_action(myGame.board.players[0],Effet.new(Evenement::SABOTAGE,0),[] of Int32)

        puts "Etat final:"
        afficherEtat(myGame.board.players)
    end
end
class Cerbere::TestHunting
    def self.afficher_positions(joueurs : Array(Player))
        puts "Positions des joueurs :"
        joueurs.each do |joueur|
            puts "\t#{joueur.lobby_id} : #{joueur.position}"
        end
    end

    def self.run()
        players = [
            Player.new(1),
            Player.new(2),
            Player.new(3),
            Player.new(4)
        ] of Player

        game : Game = Game.new()
        game.start(0, players)

        game.board.players[0].position = 1
        game.board.players[1].position = 4
        game.board.players[2].position = 5
        game.board.players[3].position = 7
        game.board.position_cerbere = 0

        puts "[Test de la chasse de cerbere et de la capture des aventuriers]-------------------------"

        puts "Main et type avant chasse"

        game.board.players.each do |player|
            puts "PLAYER_ID : #{player.lobby_id}"
            puts "  Le joueur est de type #{player.type}"
            player.hand.action.each do |carte|
                puts carte
            end
            puts
        end

        game.board.players.each do |player|
            puts "PLAYER_ID : #{player.lobby_id}"
            puts "  Le joueur est de type #{player.type}"
            player.hand.bonus.each do |carte|
                puts carte
            end
            puts
        end

     
        stop = 0
        puts "Position de cerbere : #{game.board.position_cerbere}"
        puts "Rage : #{game.board.rage_cerbere} Vitesse : #{game.board.vitesse_cerbere}"
        game.board.action_changer_rage(10)
        afficher_positions(game.board.players)
        i = 0
        while stop == 0 
            puts "Rage : #{game.board.rage_cerbere} Vitesse : #{game.board.vitesse_cerbere}"
            puts "Position de cerbere : #{game.board.position_cerbere}"
            game.board.cerbere_hunting()
            afficher_positions(game.board.players)

            if (((i % 2) == 0) && (i > 1)) #on déclenche une chasse au moins 1 tour du 2
                game.board.action_changer_rage(10)
            end

            if ((i == 10) || ((7 - game.board.nombre_pions_jauge) == 0))
                stop = 1
            end

            i += 1
        end

        afficher_positions(game.board.players)

        puts "Main et type apres chasse"

        game.board.players.each do |player|
            puts "PLAYER_ID : #{player.lobby_id}"
            puts "  Le joueur est de type #{player.type}"
            player.hand.action.each do |carte|
                puts carte
            end
            puts
        end

        game.board.players.each do |player|
            puts "PLAYER_ID : #{player.lobby_id}"
            puts "  Le joueur est de type #{player.type}"
            player.hand.bonus.each do |carte|
                puts carte
            end
            puts
        end
    end
end

class Cerbere::TestCarteBonus
    def self.afficher_les_cartes_b_de(joueur : Player)
        puts "Cartes bonus du Joueur #{joueur.lobby_id}:"
        joueur.hand.bonus.each do |ca|
            i = 1
            puts "Nom carte : #{ca.name}"
            ca.choix.each do |choice|
                puts "Choix : #{i} : "
                puts "Cout  : #{choice.cout.evenement} , force : #{choice.cout.force} "
                j = 1
                choice.effets.each do |effet|
                    puts "Effet : #{j} : #{effet.evenement} , force : #{effet.force} "
                    j += 1
                end
                i += 1
            end  
        end
    end

    def self.run
        users = [User.new(1), User.new(2)] of User

        game : Game = Game.new(0, users)
        game.board.action_piocher_moi(game.board.players[0],2)

        afficher_les_cartes_b_de(game.board.players[0])

        game.board.defausser_tout(game.board.players[0])

        afficher_les_cartes_b_de(game.board.players[0])

    end
end


class Cerbere::TestPartie
    def self.afficherEtat(players : Array(Player))
        players.each do |player|
            puts "Joueur #{player.lobby_id}: position: #{player.position} n_cards: #{player.hand.bonus.size()}"
        end
    end

    def self.t_demander(qui : Player,quoi : String) : String
        # Demande une entrée supplémentaire à un joueur particulier
        # Pour le moment, on demande via la ligne de commande, plus tard, il
        # faudra contacter le client
        puts "Joueur "+qui.lobby_id.to_s()+": "+quoi
        res : String? = gets
        return res == Nil ? "" : res.to_s
    end

    def self.afficher_les_cartes_b_de(joueur : Player)
        puts "Cartes bonus du Joueur #{joueur.lobby_id}:"
        joueur.hand.bonus.each do |ca|
            i = 1
            puts "Nom carte : #{ca.name}"
            ca.choix.each do |choice|
                puts "Choix : #{i} : "
                puts "Cout  : #{choice.cout.evenement} , force : #{choice.cout.force} "
                j = 1
                choice.effets.each do |effet|
                    puts "Effet : #{j} : #{effet.evenement} , force : #{effet.force} "
                    j += 1
                end
                i += 1
            end  
        end
    end

    def self.afficher_les_cartes_a_de(joueur : Player)
        puts "Cartes Action du Joueur #{joueur.lobby_id}:"
        k = 1
        joueur.hand.action.each do |ca|
            i = 1
            puts 
            puts "Carte n°#{k}"
            ca.choix.each do |choice|
                puts 
                puts "Choix : #{i} :"
                puts "Cout  : #{choice.cout.evenement} , force : #{choice.cout.force} "
                j = 1
                choice.effets.each do |effet|
                    puts "Effet : #{j} : #{effet.evenement} , force : #{effet.force} "
                    j += 1
                end
                i += 1
            end
            k += 1  
        end
    end

    def self.check_effet_a(p : Player,effet : Effet, max : Int32) : Array(Int32) | Nil
        arr_int = [] of Int32
        case effet.evenement
        when Evenement::PIOCHER_ALLIE
            #action_piocher_allie(moi, args)
            arr_int << t_demander(p,"Designer allie entre 1 et #{max}").to_i32
        when Evenement::DEFAUSSER_MOI
            #action_defausser_moi(moi, effet.force, args)
            arr_int << t_demander(p,"Quelle carte choississez vous entre 1 et #{p.hand.bonus.size}").to_i32
        when Evenement::DEPLACER_AUTRE
            #action_move_other_player(moi, effet.force, args)
            arr_int << t_demander(p,"Choisissez un allié à déplacer entre 1 et #{max}").to_i32 
        when Evenement::BARQUE
            #action_barque(moi,args)
            arr_int << t_demander(p, "Choisissez 0 pour reveler barque, 1 pour echanger").to_i32
            if(arr_int[0] == 1)
                arr_int << (t_demander(p, "Choisissez un chiffre entre 1 et 3").to_i32 - 1)
                arr_int << (t_demander(p, "Choisissez un chiffre entre 1 et 3").to_i32 - 1)
            elsif(arr_int[0] == 0)
                arr_int << (t_demander(p, "Choisissez une barque entre 1 et 3").to_i32 - 1)
            end
        end

        return arr_int
    end


    def self.jouer_carte_bonus(ca : CarteBonus,p : Player) : Int32
        #Enoncer les choix possibles de la carte
        i = 1
        ca.choix.each do |choice|
            puts "Choix : #{i} :"
            puts "Cout  : #{choice.cout.evenement} , force : #{choice.cout.force} "
            j = 1
            choice.effets.each do |effet|
                puts "Effet : #{j} : #{effet.evenement} , force : #{effet.force} "
                j += 1
            end
            i += 1
        end

        choice = t_demander(p, "Choisissez votre choix : entre 1 et #{i-1}").to_i32
    
        if (choice <= 0 || choice > i)
            jouer_carte_bonus(ca,p)
        end

        return choice
    end

    def self.jouer_carte_action(ca : CarteAction,p : Player) : Int32
        #Enoncer les choix possibles de la carte
        i = 1
        ca.choix.each do |choice|
            puts "Choix : #{i} :"
            puts "Cout  : #{choice.cout.evenement} , force : #{choice.cout.force} "
            j = 1
            choice.effets.each do |effet|
                puts "Effet : #{j} : #{effet.evenement} , force : #{effet.force} "
                j += 1
            end
            i += 1
        end

        choice = t_demander(p, "Choisissez votre choix : entre 1 et #{i-1}").to_i32
        if (choice <= 0 || choice > i)
            jouer_carte_action(ca,p)
        end

        ca.actif = false
        return choice
    end

    def self.index_choice_action(index : Int32, max : Int32, p : Player) : Int32
        s_ize = max - 1
        if (index >= 0 && index <= (s_ize))
            puts "index : #{index}"
            return jouer_carte_action(p.hand.action[index],p)  
        else
            puts "Choix impossible"
            puts "Try Again please"
            index_choice_action(index,max,p)
        end
    end

    def self.index_choice_bonus(index : Int32, max : Int32, p : Player) : Int32
        s_ize = max - 1
        if (index >= 0 && index <= (s_ize))
            return jouer_carte_bonus(p.hand.bonus[index-1],p)  
        else
            puts "Choix impossible"
            puts "Try Again please"
            index_choice_bonus(index,max,p)
        end
    end
    
    def self.run()
        users = [
            User.new(1),
            User.new(2),
            User.new(3),
            User.new(4),
        ] of User

        

        game = Game.new(0,users)

        puts "[ Simulation d'une partie ------------------ ]"

        game.board.players[0].position = 1 #1
        game.board.players[1].position = 1 #2
        game.board.players[2].position = 1 #3
        game.board.players[3].position = 1 #4
        game.board.position_cerbere = 0

        puts "position joueur 1 : #{game.board.players[0].position}"
        puts "position joueur 2 : #{game.board.players[1].position}"
        puts "position joueur 3 : #{game.board.players[2].position}"
        puts "position joueur 4 : #{game.board.players[3].position}"

        j = 0
        i = 0
        n = 10
        while i < n
            if(game.board.players[j].type != TypeJoueur::MORT)
                puts "PLAYER_ID : #{game.board.players[j].lobby_id}"
                puts "  Le joueur est de type #{game.board.players[j].type}"
            
                afficher_les_cartes_a_de(game.board.players[j])
                afficher_les_cartes_b_de(game.board.players[j])

                s_ize = game.board.players[j].hand.action.size
                index = (game.board.demander(game.board.players[j],"Choisir une carte action entre [1,#{s_ize}] ?").to_i - 1)
                choice = index_choice_action(index,s_ize,game.board.players[j]) - 1
                obj_choix = game.board.players[j].hand.action[index].choix[choice]

                arr_int = check_effet_a(game.board.players[j],obj_choix.cout,game.board.players.size)

                if(arr_int.size > 0)
                    game.board.faire_action(game.board.players[j],obj_choix.cout,arr_int)
                else
                    game.board.faire_action(game.board.players[j],obj_choix.cout,[] of Int32)
                end

                obj_choix.effets.each do |effect| 
                
                    arr_int = check_effet_a(game.board.players[j],effect,game.board.players.size)
                    if(arr_int.size > 0)
                        game.board.faire_action(game.board.players[j],effect,arr_int)
                    else
                        game.board.faire_action(game.board.players[j],effect,[] of Int32)
                    end
                    
                end

                size_b_p = game.board.players[j].hand.bonus.size
                if(size_b_p > 0)
                    o_n = game.board.demander(game.board.players[j],"Voulez vous jouer une carte bonus O/N ?")
                    puts "#{o_n}"

                    if (o_n == "O")
                        afficher_les_cartes_b_de(game.board.players[j])
                        index_b = (game.board.demander(game.board.players[j],"Choisir une carte bonus entre [1,#{size_b_p}] ?").to_i - 1)
                        choice_b = index_choice_bonus(index_b,s_ize,game.board.players[j]) - 1
                        arr_int_b = check_effet_a(game.board.players[j],obj_choix.cout,game.board.players.size)
                        obj_choix_b = game.board.players[j].hand.bonus[index_b].choix[choice_b]

                        if(arr_int_b.size > 0)
                            game.board.faire_action(game.board.players[j],obj_choix_b.cout,arr_int_b)
                        else
                            game.board.faire_action(game.board.players[j],obj_choix_b.cout,[] of Int32)
                        end

                        obj_choix_b.effets.each do |effect| 
                            arr_int_b = check_effet_a(game.board.players[j],effect,game.board.players.size)
                            if(arr_int_b.size > 0)
                                game.board.faire_action(game.board.players[j],effect,[arr_int_b[0]])
                            else
                                game.board.faire_action(game.board.players[j],effect,[] of Int32)
                            end 
                        end


                        puts "position joueur 1 : #{game.board.players[0].position}"
                        puts "position joueur 2 : #{game.board.players[1].position}"
                        puts "position joueur 3 : #{game.board.players[2].position}"
                        puts "position joueur 4 : #{game.board.players[3].position}"


                        afficher_les_cartes_b_de(game.board.players[0])
                        afficher_les_cartes_b_de(game.board.players[1])
                        afficher_les_cartes_b_de(game.board.players[2])
                        afficher_les_cartes_b_de(game.board.players[3])
                    end
                end
                game.board.cerbere_hunting()#hunting possible à chaque fin de tour ?
            end 
            if(j == 3)
                j = 0
            end
            j += 1
            i += 1
        end
    end

end


class Cerbere::TestPlayCard
    def self.help()
        puts "CerbTerm version 0.0.0.1\n" +
                "\thelp: Montre cette aide\n" +
                "\tboard: Affiche l'état du plateau\n" +
                "\thand [type [carte [choix]]]: Montre les cartes dans votre main\n" +
                "\tplay <type> <carte> <choix>: Jouer une carte\n" +
                "\tend: Terminer votre tour\n" +
                "\n" +
                "type est soit action soit bonus, carte et choix sont des entiers\n"
    end

    def self.board(game : Game)
	puts "Cerbere: Vitesse: #{game.board.vitesse_cerbere} Rage: #{game.board.rage_cerbere} Position: #{game.board.position_cerbere}"
        game.board.players.each do |player|
            if(player.type == TypeJoueur::MORT)
                puts "Joueur#{player.lobby_id} est mort."
            else
                action : String = ""
                player.hand.action.each do |active|
                    if(active)
                        action += 'O'
                    else
                        action += 'X'
                    end
                end
                player_type : String
                bonus_type : String
                if(player.type == TypeJoueur::AVENTURIER)
                    player_type = "Aventurier"
                    bonus_type = "Survie"
                else
                    player_type = "Cerbere"
                    bonus_type = "Trahison"
                end
                puts "Joueur#{player.lobby_id} (#{player_type}): " +
                        "Position: #{player.position}, " +
                        "Nb cartes #{bonus_type}: #{player.hand.bonus.size()}, " +
                        "Cartes Action: #{action}"
            end
        end
    end

    def self.show_effect(tab : Int, effect : Effet)
        puts ("\t"*tab)+"#{effect.evenement}, #{effect.force}"
    end

    def self.show_choice(tab : Int, game : Game, player : Player, choice : Choix,
                         active : Bool)
        puts ("\t"*tab)+"Coût (#{active && game.board.can_pay_cost(player,choice.cout) ? "utilisable" : "inutilisable"}):"
        show_effect(tab+1, choice.cout)
        puts ("\t"*tab)+"Effets:"
        choice.effets.each do |effect|
            show_effect(tab+1, effect)
        end
    end

    def self.show_action_card(tab : Int, game : Game, player : Player,
                              index_card : Int32)
        puts ("\t"*tab)+"Choix: "
        Hand.actions_of(player.type)[index_card].choix.each do |choice|
            show_choice(tab+1, game, player, choice, player.hand.action[index_card])
        end
    end

    def self.show_bonus_card(tab : Int, game : Game, player : Player, card : CarteBonus)
        puts ("\t"*tab)+"Choix de #{card.name}:"
        card.choix.each do |choice|
            show_choice(tab+1, game, player, choice, true)
        end
    end

    def self.show_all_action(game : Game, player : Player, action : Bool)
        puts "Vos cartes Action#{action ? " (Vous avez déjà utilisé une carte Action pendant ce tour)" : ""}:"
        player.hand.action.each_index do |i|
            puts "#{i}:"
            show_action_card(1, game, player, i)
        end
    end

    def self.show_all_bonus(game : Game, player : Player)
        puts "Vos cartes #{player.type == TypeJoueur::AVENTURIER ? "Survie" : "Trahison"}: "
        if(player.hand.bonus.empty?)
            puts "\t(Vous n'en n'avez pas)"
        else
            player.hand.bonus.each do |bonus_card|
                show_bonus_card(1, game, player, bonus_card)
            end
        end
    end

    def self.hand(game : Game, player : Player, args : Array(String), action : Bool)
        arg? : Int32?
        arg : Int32 = 0
        if(args.size() == 1) # Pas d'arguments: On montre tout
            show_all_action(game, player, action)
            show_all_bonus(game, player)
        else
            if(args[1] == "action")
                if(args.size() == 2) # Un seul argument: On montre un seul type
                    show_all_action(game, player, action)
                else
                    arg? = args[2].to_i?()
                    if(arg?.nil?() || (arg = arg?.not_nil!()) < 0 || arg >= 4)
                        puts "Argument n°2 \"#{args[2]}\" pour la commande hand est invalide"
                        return
                    end
		    index_card : Int32 = arg
                    if(args.size() == 3) # Deux arguments: On montre une carte
                        show_action_card(0, game, player, index_card)
                    else
			action_card : CarteAction = Hand.actions_of(player.type)[arg]
                        arg? = args[3].to_i?()
                        if(arg?.nil?() || (arg = arg?.not_nil!()) < 0 || arg >= action_card.choix.size())
                            puts "Argument n°3 \"#{args[3]}\" pour la commande hand est invalide"
                            return
                        end
                        choice : Choix = action_card.choix[arg]
                        show_choice(0, game, player, choice, player.hand.action[index_card])
                    end
                end
            elsif(args[1] == "bonus")
                if(args.size() == 2) # Un seul argument: On montre un seul type
                    show_all_bonus(game, player)
                else
                    arg? = args[2].to_i?()
                    if(arg?.nil?() || (arg = arg?.not_nil!()) < 0 || arg >= player.hand.bonus.size())
                        puts "Argument n°2 \"#{args[2]}\" pour la commande hand est invalide"
                        return
                    end
                    bonus_card = player.hand.bonus[arg]
                    if(args.size() == 3) # Deux arguments: On montre une carte
                        show_bonus_card(0, game, player, bonus_card)
                    else
                        arg? = args[3].to_i?()
                        if(arg?.nil?() || (arg = arg?.not_nil!()) < 0 || arg >= bonus_card.choix.size())
                            puts "Argument n°3 \"#{args[3]}\" pour la commande hand est invalide"
                            return
                        end
                        choice = bonus_card.choix[arg]
                        show_choice(0, game, player, choice, true)
                    end
                end
            else
                puts "Argument n°1 \"#{args[1]}\" pour la commande hand est invalide."
            end
        end
    end

    def self.get_args_from_gets()
        input? : String? = gets
        input : String = input?.nil?() ? "" : input?.to_s()
        args : Array(String) = input.split(' ')
        return args
    end

    def self.get_args_for_effect(game : Game, player : Player, effect : Effet, strict : Bool) : Array(Int32)
        loop do
            print "Arguments pour "
            show_effect(0, effect)
            effect_strargs : Array(String) = get_args_from_gets()
            effect_args : Array(Int32) = [] of Int32
            effect_strargs.each do |strarg|
                nilarg : Int32? = strarg.to_i?()
                effect_args.push(nilarg.nil?() ? -1 : nilarg.to_i())
            end
            if(game.board.check_args_are_valid(player, effect, effect_args, strict))
                return effect_args
            else
                puts "Arguments invalides"
            end
        end
    end

    def self.play(game : Game, player : Player, args : Array(String), action : Bool) : Bool
        if(args.size() != 4)
            puts "Nombre d'arguments incorrect"
            return action
        end

        card_args : Array(Array(Int32))

        action_card : Bool
        if(args[1] == "action")
            if(action)
                puts "Vous avez déjà joué une carte Action durant ce tour."
                return action
            end
            action_card = true
        elsif(args[1] == "bonus")
            action_card = false
        else
            puts "Argument n°1 \"#{args[1]}\" pour la commande play est invalide."
            return action
        end

        arg? : Int32? = args[2].to_i?()
        arg : Int32 = 0
        if(arg?.nil?() || (arg = arg?.not_nil!()) < 0 || (action_card && arg >= 4) ||
           (!action_card && arg >= player.hand.bonus.size()))
            puts "Argument n°2 \"#{args[2]}\" pour la commande play est invalide."
            return action
        end
        index_card : Int32 = arg

        card : Carte
        if(action_card)
            card = Hand.actions_of(player.type)[index_card]
            if(!player.hand.action[index_card])
                puts "La carte Action #{index_card} que vous essayez de jouer est inactive."
                return action
            end
        else
            card = player.hand.bonus[index_card]
        end

        arg? = args[3].to_i?()
        if(arg?.nil?() || (arg = arg?.not_nil!()) < 0 || arg >= card.choix.size())
            puts "Argument n°3 \"#{args[3]}\" pour la commande play est invalide."
            return action
        end
        n_choice : Int32 = arg

        choice : Choix = card.choix[n_choice]
        if(!game.board.can_pay_cost(player,choice.cout))
            puts "Vous ne pouvez pas payer le coût de cette carte."
            return action
        end

        effect_args : Array(Array(Int32)) = [] of Array(Int32)
        if(game.board.check_args_are_valid(player, choice.cout, [] of Int32, true))
            effect_args.push([] of Int32)
        else
            effect_args.push(get_args_for_effect(game, player, choice.cout, true))
        end
        choice.effets.each do |effet|
            if(game.board.check_args_are_valid(player, effet, [] of Int32, true))
                effect_args.push([] of Int32)
            else
                effect_args.push(get_args_for_effect(game, player, effet, false))
            end
        end
        game.board.play_card(player, action_card, index_card, n_choice, effect_args)

        return action || action_card
    end

    def self.run()
        players = [
            Player.new(1),
            Player.new(2),
            Player.new(3),
            Player.new(4),
            Player.new(5),
            Player.new(6),
            Player.new(7)
        ] of Player
        game : Game = Game.new()
        game.start(0, players)
        help()
        10.times do
            game.board.players.each do |player|
                if(player.type == TypeJoueur::MORT)
                    next
                else
                    type : String
                    if(player.type == TypeJoueur::AVENTURIER)
                        type = "Aventurier"
                    else
                        type = "Cerbere"
                    end
                    prompt : String = "Joueur#{player.lobby_id}(#{type})$ "
                    action : Bool = false
                    loop do
                        print prompt
                        cmd? : String? = gets
                        cmd : String = cmd?.nil?() ? "" : cmd?.to_s()
                        args : Array(String) = cmd.split(' ')
                        if(args[0] == "help")
                            help()
                        elsif(args[0] == "board")
                            board(game)
                        elsif(args[0] == "hand")
                            hand(game,player, args, action)
                        elsif(args[0] == "play")
                            action = play(game, player, args, action)
                        elsif(args[0] == "end")
                            if(action)
                                break
                            else
                                puts "Vous devez jouer une carte Action !"
                            end
                        elsif(args[0] == "quit" || args[0] == "exit")
                            return
                        else
                            puts "\"#{args[0]}\": commande inconnue. Tapez help."
                        end
                    end
                end
            end
        end
    end
end

#Cerbere::Test.run
#Cerbere::TestDeck.run
#Cerbere::TestBarque.run
#Cerbere::TestCouardise.run
#Cerbere::TestSabotage.run
#Cerbere::TestPlateau.run
#Cerbere::TestRageVitesse.run
#Cerbere::TestCartesAction.run
#Cerbere::TestCartesBonus.run
#Cerbere::TestPiocheDefausse.run
#Cerbere::TestHunting.run
#Cerbere::TestPartie.run
#Cerbere::TestPlayCard.run
