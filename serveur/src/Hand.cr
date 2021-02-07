require "./Carte.cr"

class Hand
end

class HandAventurier < Hand
    property mesCartesAction : Array(CarteActionSurvivant) = CARTES_ACTION_SURVIVANT
    property mesCartesBonus = [] of CarteSurvie
end

class HandCerbere < Hand
    property mesCartesAction : Array(CarteActionCerbere) = CARTES_ACTION_CERBERE
    property mesCartesBonus = [] of CarteTrahison
end
