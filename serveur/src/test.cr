require "./Player.cr"
require "./Deck.cr"

class Test
    def self.run
        puts "Test de creation de joueur + main"
        jean : Player = Player.new(354,1)
        puts "  Le joueur a #{jean.myHandAventurier.mesCartesAction.size} cartes Action"
        puts "  Le joueur a #{jean.myHandAventurier.mesCartesBonus.size} cartes Survie"
        puts "  Le joueur est de type #{jean.typeJoueur}"
        puts "  Le joueur est a la case #{jean.position}"

        puts
        puts "Test de creation de Cerbere"
        cerbere : Player = Player.new(0,0)
        puts "  Cerbere est de type #{cerbere.typeJoueur}"
        puts "  Cerbere commence a la case #{cerbere.position}"

        puts
        puts "Test de la creation de la pioche Survie"
        testSurvie : DeckSurvie = DeckSurvie.new()
        a = 1
        testSurvie.cards.each do |card|
            puts "  #{a} : #{card.name}"
            a = a + 1
        end

        puts
        puts "Test de la creation de la pioche Trahison"
        testTrahison : DeckTrahison = DeckTrahison.new()
        a = 1
        testTrahison.cards.each do |card|
            puts "  #{a} : #{card.name}"
            a = a + 1
        end
    end
end

Test.run
