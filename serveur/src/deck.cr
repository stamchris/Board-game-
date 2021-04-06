require "./carte.cr"

abstract class Deck
	abstract def cards() : Array
	abstract def discard() : Array
	abstract def dump() : Nil

	def draw_card() : CarteBonus
		if(cards().size() == 0)
			discard().shuffle!()
			discard().each do |card|
				cards() << card
			end
			discard().clear()
		end
		return cards().pop()
	end

	def dis_card(card : CarteBonus) : Nil
		discard().push(card)
	end
end

class DeckSurvie < Deck
	private getter cards : Array(CarteSurvie) = (CARTES_SURVIE*4).shuffle
	private getter discard : Array(CarteSurvie) = [] of CarteSurvie

	def draw_card() : CarteSurvie
		return super().as(CarteSurvie)
	end

	def dis_card(card : CarteSurvie) : Nil
		super(card)
	end

	def dump() : Nil
		cards.each_index do |index|
			puts "#{index} : #{cards[index].name}"
		end
	end
end

class DeckTrahison < Deck
	private getter cards : Array(CarteTrahison) = (CARTES_TRAHISON*3).shuffle
	private getter discard : Array(CarteTrahison) = [] of CarteTrahison

	def draw_card() : CarteTrahison
		return super().as(CarteTrahison)
	end

	def dis_card(card : CarteTrahison) : Nil
		super(card)
	end

	def dump() : Nil
		cards.each_index do |index|
			puts "#{index} : #{cards[index].name}"
		end
	end
end
