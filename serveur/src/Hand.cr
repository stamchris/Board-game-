require "./carte.cr"

class Hand
    property action : Array(Bool) = [true, true, true, true]
    property bonus = [] of CarteBonus

    def reset(type : TypeJoueur)
	action.each_index do |i|
		action[i] = true
	end
    end

    def self.actions_of(type : TypeJoueur) : Array
        if(type == TypeJoueur::AVENTURIER)
            return CARTES_ACTION_SURVIVANT
        else
            return CARTES_ACTION_CERBERE
        end
    end
end
