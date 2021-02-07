require "./Carte.cr"

class Deck
end

class DeckSurvie < Deck
    property cards : Array(CarteSurvie) = (CARTES_SURVIE*4).shuffle!
end

class DeckTrahison < Deck
    property cards : Array(CarteTrahison) = (CARTES_TRAHISON*3).shuffle!
end


            