require "./carte.cr"

class Hand
	include JSON::Serializable

	property action : Array(Bool) = [true, true, true, true]
	@[JSON::Field(ignore: true)]
	property bonus = [] of CarteBonus
	property bonus_size : Int32 = 0

	def initialize()
	end

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
