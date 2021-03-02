require "./effet.cr"

class Choix
	getter cout : Effet
	getter effets : Array(Effet)

	def initialize(@cout,@effets)
	end
end

class Carte
	getter choix : Array(Choix)

	def initialize(@choix)
		if(choix.size != 2 && choix.size != 3)
			raise "Une Carte n'a que deux choix"
		end
	end
end

class CarteAction < Carte
end

class CarteActionSurvivant < CarteAction
end

class CarteActionCerbere < CarteAction
end

class CarteBonus < Carte
	getter name : String

	def initialize(@name,@choix)
	end
end

class CarteSurvie < CarteBonus
end

class CarteTrahison < CarteBonus
end

CARTES_SURVIE=[

    CarteSurvie.new("Couardise",
            [Choix.new(Effet.new(Evenement::RIEN,0),
               [Effet.new(Evenement::BARQUE,0)]),
            Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
               [Effet.new(Evenement::COUARDISE,0)])]),

   CarteSurvie.new("Opportunisme",
	[Choix.new(Effet.new(Evenement::RIEN,0),
		  [Effet.new(Evenement::DEPLACER_MOI,1),Effet.new(Evenement::DEPLACER_AUTRE,-1)]),
            Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
	  [Effet.new(Evenement::DEPLACER_AUTRE,-2),Effet.new(Evenement::DEPLACER_MOI,1)]),
	Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
	   [Effet.new(Evenement::DEPLACER_AUTRE,2),Effet.new(Evenement::DEPLACER_MOI,1)])]),

    CarteSurvie.new("Arrogance",
            [Choix.new(Effet.new(Evenement::RIEN,0),
              [Effet.new(Evenement::DEPLACER_AUTRE,1),Effet.new(Evenement::DEPLACER_AUTRE,1)]),
            Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
	  [Effet.new(Evenement::DEPLACER_AUTRE,3),Effet.new(Evenement::CHANGER_RAGE,-1)])]),

    CarteSurvie.new("Favoritisme",
            [Choix.new(Effet.new(Evenement::RIEN,0),
	       [Effet.new(Evenement::DEPLACER_MOI,1),Effet.new(Evenement::DEPLACER_AUTRE,1)]),
            Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,3),
               [Effet.new(Evenement::DEPLACER_MOI,3),Effet.new(Evenement::DEPLACER_AUTRE,2),Effet.new(Evenement::DEPLACER_AUTRE,1)])]),

    CarteSurvie.new("Sacrifice",
            [Choix.new(Effet.new(Evenement::RIEN,0),
	   [Effet.new(Evenement::CHANGER_RAGE,-1),Effet.new(Evenement::DEPLACER_AUTRE,-1)]),
            Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
              [Effet.new(Evenement::CHANGER_RAGE,-2),Effet.new(Evenement::DEPLACER_AUTRE,-2)])]),

   CarteSurvie.new("Egoïsme",
	[Choix.new(Effet.new(Evenement::RIEN,0),
               [Effet.new(Evenement::DEPLACER_MOI,1)]),
            Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
               [Effet.new(Evenement::DEPLACER_MOI,2)])]),

   CarteSurvie.new("Fatalisme",
	        [Choix.new(Effet.new(Evenement::RIEN,0),
		       [Effet.new(Evenement::DEPLACER_MOI,-2)]),
            Choix.new(Effet.new(Evenement::DEPLACER_MOI,-1),
               [Effet.new(Evenement::DEPLACER_AUTRE,3)])]),

] of CarteSurvie

CARTES_TRAHISON = [
	CarteTrahison.new("Rancune",
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::DEPLACER_AUTRE,-2)]),
		Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,2),
			[Effet.new(Evenement::DEPLACER_AVENTURIERS,-2)])]),
	CarteTrahison.new("Violence",
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::CHANGER_RAGE,1)]),
		Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,2),
			[Effet.new(Evenement::CHANGER_VITESSE,2)])]),
	CarteTrahison.new("Sabotage",
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::DEFAUSSER_SURVIE,2)]),
		Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
			[Effet.new(Evenement::SABOTAGE,0)])]),
	CarteTrahison.new("Perfidie",
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::CHANGER_VITESSE,1)]),
		Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
			[Effet.new(Evenement::CHANGER_RAGE,2)])]),
	CarteTrahison.new("Fourberie",
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::BARQUE,0)]),
		Choix.new(Effet.new(Evenement::DEPLACER_AUTRE,1),
			[Effet.new(Evenement::DEPLACER_AUTRE,-3)])]),
	CarteTrahison.new("Embuscade",
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::DEPLACER_CERBERE,1)]),
		Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
			[Effet.new(Evenement::DEPLACER_CERBERE,2)])])
] of CarteTrahison

CARTES_ACTION_SURVIVANT = [

	CarteActionSurvivant.new(
		[Choix.new(Effet.new(Evenement::CHANGER_RAGE,1),
			[Effet.new(Evenement::RECUPERER_CARTE,0),Effet.new(Evenement::PIOCHER_MOI,1)]),
		Choix.new(Effet.new(Evenement::CHANGER_RAGE,1),
			[Effet.new(Evenement::BARQUE,0),Effet.new(Evenement::RECUPERER_CARTE,0)])]),

	CarteActionSurvivant.new(
		[Choix.new(Effet.new(Evenement::CHANGER_RAGE,1),
			[Effet.new(Evenement::PIOCHER_MOI,2)]),
		Choix.new(Effet.new(Evenement::CHANGER_RAGE,1),
			[Effet.new(Evenement::PIOCHER_MOI,1),Effet.new(Evenement::PIOCHER_ALLIE,2)])]),

	CarteActionSurvivant.new(
		[Choix.new(Effet.new(Evenement::CHANGER_RAGE,1),
			[Effet.new(Evenement::DEPLACER_MOI,2)]),
		Choix.new(Effet.new(Evenement::CHANGER_RAGE,1),
			[Effet.new(Evenement::DEPLACER_AUTRE,3),Effet.new(Evenement::DEPLACER_AUTRE,1)])]),

	CarteActionSurvivant.new(
		[Choix.new(Effet.new(Evenement::CHANGER_VITESSE,1),
			[Effet.new(Evenement::DEPLACER_MOI,2),Effet.new(Evenement::DEPLACER_AUTRE,1)]),
		Choix.new(Effet.new(Evenement::DEFAUSSER_MOI,1),
			[Effet.new(Evenement::DEPLACER_AUTRE,2),Effet.new(Evenement::DEPLACER_MOI,1)])]),

] of CarteActionSurvivant

CARTES_ACTION_CERBERE = [
	CarteActionCerbere.new(
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::CHANGER_VITESSE,1)]),
		Choix.new(Effet.new(Evenement::CHANGER_VITESSE,-1),
			[Effet.new(Evenement::PIOCHER_MOI,2),Effet.new(Evenement::PIOCHER_ALLIE,1)])]),
	CarteActionCerbere.new(
		[Choix.new(Effet.new(Evenement::DEPLACER_AUTRE,1),
			[Effet.new(Evenement::DEPLACER_AUTRE,-1),Effet.new(Evenement::DEPLACER_AUTRE,-1),Effet.new(Evenement::DEPLACER_AUTRE,-1)]),
		Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::CHANGER_VITESSE,1)])]),
	CarteActionCerbere.new(
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::DEPLACER_CERBERE,1)]),
		Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::PIOCHER_MOI,1)])]),
	CarteActionCerbere.new(
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::RECUPERER_CARTE,0)]),
		Choix.new(Effet.new(Evenement::DEPLACER_AUTRE,2),
			[Effet.new(Evenement::PIOCHER_MOI,1),Effet.new(Evenement::RECUPERER_CARTE,0)])])
] of CarteActionCerbere
