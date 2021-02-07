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
        a = 1
        myGame.cerbereBoard.piocheSurvie.cards.each do |card|
            puts "#{a} : #{card.name}"
            a = a + 1
        end
        puts

        puts "  Les cartes de la pioche Trahison :"
        a = 1
        myGame.cerbereBoard.piocheTrahison.cards.each do |card|
            puts "#{a} : #{card.name}"
            a = a + 1
        end
        puts

        puts "  Les joueurs sont :"
        a = 1
        myGame.cerbereBoard.players.each do |player|
            puts "PLAYER_ID : #{a}"
            puts "  Le joueur a #{player.myHand.cartesAction.size} cartes Action"
            puts "  Le joueur a #{player.myHand.cartesBonus.size} cartes Survie"
            puts "  Le joueur est de type #{player.typeJoueur}"
            puts "  Le joueur est a la case #{player.position}"
            puts
            a + 1
        end

        puts "  Les attributs du plateau sont :"
        puts "Barques : #{myGame.cerbereBoard.barques}"
        puts "La vitesse est #{myGame.cerbereBoard.vitesseCerbere}"
        puts "La rage est #{myGame.cerbereBoard.rageCerbere}"
    end
end

Test.run
