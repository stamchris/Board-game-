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
            puts "#{node.previousNodes} <- [#{node.checkpointCerbere}, #{node.effect.evenement}] -> #{node.nextNodes}"
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

class TestBarque
    def self.run()
        myUsers = [
            User.new(1),
            User.new(2)
        ] of User
        myGame : Game = Game.new(0,myUsers)

        myGame.cerbereBoard.faire_action(myGame.cerbereBoard.players[0],Effet.new(Evenement::BARQUE,0),[0])
        myGame.cerbereBoard.faire_action(myGame.cerbereBoard.players[1],Effet.new(Evenement::BARQUE,0),[0,0,1])

        puts "Barques : #{myGame.cerbereBoard.barques}"
    end
end

class TestCouardise
    def self.afficherPositions(players : Array(Player))
        players.each do |player|
            puts "Joueur #{player.lobbyId}: #{player.position}"
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

        myGame.cerbereBoard.players.each do |player|
            player.position = player.lobbyId
        end
        afficherPositions(myGame.cerbereBoard.players)

        i = 0
        while(i < myUsers.size())
            puts "Joueur #{myGame.cerbereBoard.players[i].lobbyId} utilise Couardise"
            myGame.cerbereBoard.faire_action(myGame.cerbereBoard.players[i],Effet.new(Evenement::COUARDISE,0),[] of Int32)
            afficherPositions(myGame.cerbereBoard.players)
            i += 1
        end
    end
end

class TestSabotage
    def self.afficherEtat(players : Array(Player))
        players.each do |player|
            puts "Joueur #{player.lobbyId}: position: #{player.position} n_cards: #{player.myHand.myCartesBonus.size()}"
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

        myGame.cerbereBoard.players.each do |player|
            player.position = 3
            i = 0
            while(i < player.lobbyId-1)
                player.myHand.myCartesBonus << myGame.cerbereBoard.piocheSurvie.cards.pop()
                i += 1
            end
        end

        puts "Etat initial:"
        afficherEtat(myGame.cerbereBoard.players)

        myGame.cerbereBoard.faire_action(myGame.cerbereBoard.players[0],Effet.new(Evenement::SABOTAGE,0),[] of Int32)

        puts "Etat final:"
        afficherEtat(myGame.cerbereBoard.players)
    end
end

Test.run
TestDeck.run
TestBarque.run
TestCouardise.run
#TestSabotage.run # Test interactif
