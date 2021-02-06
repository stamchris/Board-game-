require "./Carte.cr"

class Deck
end

class DeckSurvie < Deck
    property cards : Array(CarteSurvie) = CARTES_SURVIE

    def initialize()
        i = 3

        while i != 0
            @cards.concat(CARTES_SURVIE)
            i = i -1
        end

        @cards.shuffle!()
    end
end

class DeckTrahison < Deck
    property cards : Array(CarteTrahison) = CARTES_TRAHISON

    def initialize()
        @cards.new
        i = 3

        while i != 0
            @cards.concat(CARTES_TRAHISON)
            i = i -1 
        end

        @cards.shuffle!()
    end
end


            