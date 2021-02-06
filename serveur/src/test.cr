require "./Player.cr"

class Test
    def self.run
        puts "Test de creation de joueur + main"
        jean : Player = Player.new
        puts jean.myHandAventurier.mesCartesAction.size
        puts jean.myHandAventurier.mesCartesBonus.size
        puts jean.myHandCerbere.mesCartesAction.size
        puts jean.myHandCerbere.mesCartesBonus.size
        puts jean.typeJoueur
        puts jean.position

        puts
        puts "Test de creation de Cerbere"
        cerbere : Player = Player.new(0)
        puts cerbere.myHandAventurier.mesCartesAction.size
        puts cerbere.myHandAventurier.mesCartesBonus.size
        puts cerbere.myHandCerbere.mesCartesAction.size
        puts cerbere.myHandCerbere.mesCartesBonus.size
        puts cerbere.typeJoueur
        puts cerbere.position
    end
end

Test.run
