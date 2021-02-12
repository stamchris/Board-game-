require "./Carte.cr"

abstract class Deck
	abstract def cards() : Array(CarteBonus)
	abstract def discard() : Array(CarteBonus)

	def drawCard() : CarteBonus
		if(cards().size() == 0)
			discard().shuffle!()
			discard().each do |card|
				cards() << card
			end
			discard().clear()
		end
		return cards().pop()
	end

	def disCard(card : CarteBonus) : Nil
		discard().push(card)
	end
end

class DeckSurvie < Deck
	@cards : Array(CarteSurvie) = (CARTES_SURVIE*4).shuffle
	@discard : Array(CarteSurvie) = [] of CarteSurvie

	def cards() : Array(CarteSurvie)
		return @cards
	end

	def discard() : Array(CarteSurvie)
		return @discard
	end

	def drawCard() : CarteSurvie
		return super().as(CarteSurvie)
	end

	def disCard(card : CarteSurvie) : Nil
		super(card)
	end
end

class DeckTrahison < Deck
	@cards : Array(CarteTrahison) = (CARTES_TRAHISON*3).shuffle
	@discard : Array(CarteTrahison) = [] of CarteTrahison

	def cards() : Array(CarteTrahison)
		return @cards
	end

	def discard() : Array(CarteTrahison)
		return @discard
	end

	def drawCard() : CarteTrahison
		return super().as(CarteTrahison)
	end

	def disCard(card : CarteTrahison) : Nil
		super(card)
	end
end
