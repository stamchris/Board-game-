require "./Carte.cr"

class Hand
    property cartesAction = [] of CarteAction
    property cartesBonus = [] of CarteBonus
      
    def initialize
        @cartesAction = CARTES_ACTION_SURVIVANT
    end
    
end


