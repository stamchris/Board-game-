require "./Player.cr"
require "./Deck.cr"
require "./Game.cr"

class Test
    def self.run
    # Tableau d'utilisateurs fictifs provenant du lobby
    myUsers = [
        User.new(2),
        User.new(48),
        User.new(59),
        User.new(227),
        User.new(35),
        User.new(1000),
        User.new(4785)
    ] of User

        # Creation d'une partie
        puts "[Test de creation d'une partie]
             "

        myGame : Game = Game.new(0, myUsers)

        puts "  La partie a #{myGame.numberOfPlayers} joueurs"
        puts "  La partie est en difficulte #{myGame.difficulty}
             "

        # Affichage des cases
        puts "  Les cases du plateau :"
        myGame.cerbereBoard.nodes.each do |node|
            puts "[#{node.checkpointCerbere}, #{node.effect.evenement}]"
        end
        puts

        # Affichage des pioches
        puts "  Les cartes de la pioche Survie :"
        myGame.cerbereBoard.piocheSurvie.dump()
        puts

        puts "  Les cartes de la pioche Trahison :"
        myGame.cerbereBoard.piocheTrahison.dump()
        puts

        puts "  Les joueurs sont :"
        a = 1
        myGame.cerbereBoard.players.each do |player|
            puts "PLAYER_ID : #{a}"
            puts "  Le joueur a #{player.myHand.myCartesAction.size} cartes Action"
            puts "  Le joueur a #{player.myHand.myCartesBonus.size} cartes Survie"
            puts "  Le joueur est de type #{player.typeJoueur}"
            puts "  Le joueur est a la case #{player.position}"
            puts
            a = a + 1
        end

        puts "  Les attributs du plateau sont :"
        puts "Barques : #{myGame.cerbereBoard.barques}"
        puts "La vitesse est #{myGame.cerbereBoard.vitesseCerbere}"
        puts "La rage est #{myGame.cerbereBoard.rageCerbere}"
        puts "La position de Cerbere est #{myGame.cerbereBoard.positionCerbere}"
    end
end

class TestDeck
    def self.afficher_les_cartes_de(joueur : Player)
        puts "Cartes de Joueur #{joueur.lobbyId}:"
        joueur.myHand.myCartesBonus.each_index do |index|
            puts "\t#{index} : #{joueur.myHand.myCartesBonus[index].name}"
        end
    end

    def self.run()
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
        game.cerbereBoard.players[1].typeJoueur = 2

        i = 0
        while(i < 7)
            game.cerbereBoard.players[0].myHand.myCartesBonus.push(game.cerbereBoard.piocheSurvie.draw_card())
            game.cerbereBoard.players[1].myHand.myCartesBonus.push(game.cerbereBoard.piocheTrahison.draw_card())
            i += 1
        end

        afficher_les_cartes_de(game.cerbereBoard.players[0])
        afficher_les_cartes_de(game.cerbereBoard.players[1])

        i = 0
        while(i < 7)
            game.cerbereBoard.defausser(game.cerbereBoard.players[0],0)
            game.cerbereBoard.defausser(game.cerbereBoard.players[1],0)
            afficher_les_cartes_de(game.cerbereBoard.players[0])
            afficher_les_cartes_de(game.cerbereBoard.players[1])
            i += 1
        end
    end
end

class TestPlateau
    def self.afficher_positions(joueurs : Array(Player))
        puts "Positions des joueurs :"
        joueurs.each do |joueur|
            puts "\t#{joueur.lobbyId} : #{joueur.position}"
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
        game.cerbereBoard.players[0].position = 11
        game.cerbereBoard.players[1].position = 18
        game.cerbereBoard.players[2].position = 17
        game.cerbereBoard.players[3].position = 9
        game.cerbereBoard.positionCerbere = 8

        game.cerbereBoard.deplacer_moi(game.cerbereBoard.players[0], -3)
        afficher_positions(game.cerbereBoard.players)

        game.cerbereBoard.deplacer_moi(game.cerbereBoard.players[1], -2)
        afficher_positions(game.cerbereBoard.players)

        game.cerbereBoard.deplacer_moi(game.cerbereBoard.players[2], 3)
        afficher_positions(game.cerbereBoard.players)

        game.cerbereBoard.deplacer_moi(game.cerbereBoard.players[3], 3)
        afficher_positions(game.cerbereBoard.players)

        game.cerbereBoard.deplacer_moi(game.cerbereBoard.players[1], 2)
        afficher_positions(game.cerbereBoard.players)
    end
end

Test.run
TestDeck.run
TestPlateau.run
