require "./carte.cr"

class Hand
    property action : Array(CarteActionCerbere) | Array(CarteActionSurvivant) = CARTES_ACTION_SURVIVANT*1
    property bonus = [] of CarteBonus

    def reset(type : TypeJoueur)
        if type == TypeJoueur::AVENTURIER
            @action = CARTES_ACTION_SURVIVANT*1
        else 
            @action = CARTES_ACTION_CERBERE*1
        end 
    end
end
