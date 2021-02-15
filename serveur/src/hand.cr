require "./carte.cr"

class Hand
    property action = CARTES_ACTION_SURVIVANT
    property bonus = [] of CarteBonus
end