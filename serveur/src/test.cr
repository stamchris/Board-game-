require "./player.cr"
require "./deck.cr"
require "./game.cr"

class Test
    def self.run
        # Tableau d'utilisateurs fictifs provenant du lobby
        my_users = [
            User.new(2),
            User.new(48),
            User.new(59),
        ] of User

        # Creation d'une partie
        puts "[Test de creation d'une partie]-------------------------
             "

        myGame : Game = Game.new(0, my_users)

        puts "  La partie a #{myGame.number_players} joueurs"
        puts "  La partie est en difficulte #{myGame.difficulty}
             "

        # Affichage des cases
        puts "  Les cases du plateau :"
        myGame.board.nodes.each do |node|
            puts "#{node.previous_nodes} <- [#{node.checkpoint_cerbere}, #{node.effect.evenement}] -> #{node.next_nodes}"
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

class TestDeck
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

        i : Int32 = 0
        while(i < 100)
            carteSurvie : CarteSurvie = survie.draw_card()
            puts "Carte Survie piochée: #{carteSurvie.name}"
            carteTrahison : CarteTrahison = trahison.draw_card()
            puts "Carte Trahison piochée: #{carteTrahison.name}"
            survie.dis_card(carteSurvie)
            trahison.dis_card(carteTrahison)
            i += 1
        end

        users = [
            User.new(1),
            User.new(2)
        ] of User

        game : Game = Game.new(0,users)
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

class TestRageVitesse
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
        users5 = [
            User.new(2),
            User.new(48),
            User.new(59),
            User.new(420),
            User.new(69)
        ] of User

        puts "[Test des actions modifier rage et vitesse]-------------------------
        "

        game15 : Game = Game.new(1, users5)

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

class TestPiocheDefausse
    def self.afficher_les_cartes_de(joueur : Player)
        puts "Cartes de Joueur #{joueur.lobby_id}:"
        joueur.hand.bonus.each_index do |index|
            puts "\t#{index} : #{joueur.hand.bonus[index].name}"
        end
        puts
    end

    def self.run 
        users5 = [
            User.new(13),
            User.new(21),
            User.new(34),
            User.new(55),
            User.new(89)
        ] of User

        puts "[Test des actions de pioche et défausse]-------------------------
        "
        my_game : Game = Game.new(0, users5)

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
        my_game.board.action_piocher_allie(my_game.board.players[0], 1, [21])

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

Test.run
TestDeck.run
TestRageVitesse.run
TestPiocheDefausse.run