require "./player.cr"
require "./deck.cr"
require "./Game.cr"

class Cerbere::Test
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

class Cerbere::TestPiocheDefausse
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
        users = [User.new(1), User.new(2)] of User

        my_game : Game = Game.new(0, users)
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
        myUsers = [
            User.new(1),
            User.new(2)
        ] of User
        myGame : Game = Game.new(0,myUsers)

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
        myUsers = [
            User.new(1),
            User.new(2),
            User.new(3),
            User.new(4),
            User.new(5),
            User.new(6),
            User.new(7)
        ] of User
        myGame : Game = Game.new(0,myUsers)

        myGame.board.players.each do |player|
            player.position = player.lobby_id
        end
        afficherPositions(myGame.board.players)

        myUsers.each_index do |i|
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
        users = [
            User.new(1),
            User.new(2),
            User.new(3),
            User.new(4)
        ] of User

        game : Game = Game.new(0,users)
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
        myUsers = [
            User.new(1),
            User.new(2),
            User.new(3),
            User.new(4),
            User.new(5),
            User.new(6),
            User.new(7)
        ] of User
        myGame : Game = Game.new(0,myUsers)

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

Cerbere::Test.run
Cerbere::TestDeck.run
Cerbere::TestBarque.run
Cerbere::TestCouardise.run
Cerbere::TestSabotage.run
Cerbere::TestPlateau.run
Cerbere::TestRageVitesse.run
Cerbere::TestCartesAction.run
Cerbere::TestPiocheDefausse.run
