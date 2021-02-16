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


        " Bouger joueur simplement "
        puts "La position du joueur 1  : #{myGame.cerbereBoard.players[0].position}"
        myGame.cerbereBoard.action_mouv_player(myGame.cerbereBoard.players[0],1)
        myGame.cerbereBoard.action_mouv_player(myGame.cerbereBoard.players[2],2)
        puts "La position du joueur  1 apres mouv : #{myGame.cerbereBoard.players[0].position}"


        " Bouger cerbere simplement"
        puts "La position de Cerbere est #{myGame.cerbereBoard.positionCerbere}"
        puts "La position du joueur 1 est #{myGame.cerbereBoard.players[0].position} 
                et son statut : #{myGame.cerbereBoard.players[0].typeJoueur} "
        puts "La position du joueur 2 est #{myGame.cerbereBoard.players[1].position} 
                et son statut : #{myGame.cerbereBoard.players[1].typeJoueur} "

        myGame.cerbereBoard.action_mouv_cerbere(1)
        puts "Mouvement de Cerbere de une position vers l'avant"
        puts "La position de Cerbere est #{myGame.cerbereBoard.positionCerbere}"
        puts "La position du joueur 1 est #{myGame.cerbereBoard.players[0].position} 
                et son statut : #{myGame.cerbereBoard.players[0].typeJoueur} "
        puts "La position du joueur 2 est #{myGame.cerbereBoard.players[1].position} 
                et son statut : #{myGame.cerbereBoard.players[1].typeJoueur} "
        #capture effectué

        "Bouger tout les survivants "

        puts "La position du joueur 2 est #{myGame.cerbereBoard.players[1].position}"  # cerbere
        puts "La position du joueur 4 est #{myGame.cerbereBoard.players[3].position}"  # cerbere

        myGame.cerbereBoard.action_mouv_all_survivors(2)
        puts "La position du joueur 1 est #{myGame.cerbereBoard.players[0].position}"  #survivant
        puts "La position du joueur 3 est #{myGame.cerbereBoard.players[2].position}"  #survivant
        # il n'y a que 2 survivant



        "Un joueur fait bouger un autre joueur ou plusieurs"
        myGame.cerbereBoard.action_mouv_other_player(
            myGame.cerbereBoard.players[0],[myGame.cerbereBoard.players[2]],[2]
        )

        puts "La position du joueur 3 est #{myGame.cerbereBoard.players[2].position}"  #survivant

            



        

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
        game.cerbereBoard.players[1].typeJoueur = 2

        7.times do
            game.cerbereBoard.players[0].myHand.myCartesBonus.push(game.cerbereBoard.piocheSurvie.draw_card())
            game.cerbereBoard.players[1].myHand.myCartesBonus.push(game.cerbereBoard.piocheTrahison.draw_card())
        end

        afficher_les_cartes_de(game.cerbereBoard.players[0])
        afficher_les_cartes_de(game.cerbereBoard.players[1])

        7.times do
            game.cerbereBoard.defausser(game.cerbereBoard.players[0],0)
            game.cerbereBoard.defausser(game.cerbereBoard.players[1],0)
            afficher_les_cartes_de(game.cerbereBoard.players[0])
            afficher_les_cartes_de(game.cerbereBoard.players[1])
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

        puts "Barques : #{myGame.cerbereBoard.barques}"

        myGame.cerbereBoard.faire_action(myGame.cerbereBoard.players[0],Effet.new(Evenement::BARQUE,0),[0,0])
        myGame.cerbereBoard.faire_action(myGame.cerbereBoard.players[1],Effet.new(Evenement::BARQUE,0),[1,0,1])

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

        myUsers.each_index do |i|
            puts "Joueur #{myGame.cerbereBoard.players[i].lobbyId} utilise Couardise"
            myGame.cerbereBoard.faire_action(myGame.cerbereBoard.players[i],Effet.new(Evenement::COUARDISE,0),[] of Int32)
            afficherPositions(myGame.cerbereBoard.players)
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
        game.cerbereBoard.players[0].position = 9
        game.cerbereBoard.players[1].position = 17
        game.cerbereBoard.players[2].position = 16
        game.cerbereBoard.players[3].position = 8
        game.cerbereBoard.positionCerbere = 7

        game.cerbereBoard.action_promontoire(game.cerbereBoard.players[0], [0])

        game.cerbereBoard.action_deplacer_moi(game.cerbereBoard.players[0], -3)
        afficher_positions(game.cerbereBoard.players)

        game.cerbereBoard.action_deplacer_moi(game.cerbereBoard.players[1], -2)
        afficher_positions(game.cerbereBoard.players)

        game.cerbereBoard.action_deplacer_moi(game.cerbereBoard.players[2], 3)
        afficher_positions(game.cerbereBoard.players)

        game.cerbereBoard.action_deplacer_moi(game.cerbereBoard.players[3], 3)
        afficher_positions(game.cerbereBoard.players)

        game.cerbereBoard.action_deplacer_moi(game.cerbereBoard.players[1], 2)
        afficher_positions(game.cerbereBoard.players)
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
            (player.lobbyId-1).times do
                player.myHand.myCartesBonus << myGame.cerbereBoard.piocheSurvie.draw_card()
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
TestPlateau.run
