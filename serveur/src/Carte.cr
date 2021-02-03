enum Evenement
	RIEN # La carte n'a aucun coût
	RECUPERER_CARTE # Le joueur récupère toutes ses cartes Action
	PIOCHER_MOI # Le joueur pioche X cartes Survie/Trahison
	PIOCHER_ALLIE # X alliés du joueur pioche une carte Survie/Trahison
	DEFAUSSER_MOI # Le joueur doit défausser X cartes
	DEFAUSSER_SURVIE # X survivants sont obligés de défausser une carte
	DEFAUSSER_PARTAGE # X cartes Survie/Trahison doivent être défaussés, ce coût est partageable parmi les alliés
	CHANGER_VITESSE # La vitesse (valeur du dé) change
	CHANGER_COLERE # La colère (jauge) change
	DEPLACER_MOI # Le joueur se déplace
	DEPLACER_AUTRE # Le joueur déplace d'autres joueurs
	DEPLACER_SURVIVANTS # Tous les survivants se déplacent
	DEPLACER_CERBERE # Cerbère se déplace sur le plateau
	BARQUE # Le joueur peut soit consulter les barques, soit les changer de place
	COUARDISE # Deuxième effet de Couardise: le joueur avance d'autant de cases qu'il n'y a d'aventurier devant lui (max 3)
	SABOTAGE # Deuxième effet de Sabotage: tous les survivants choisissent soit de défausser une carte, soit de reculer de 2 cases
end

class Effet
	getter evenement : Evenement
	getter force : Int32
	
	def initialize(@evenement,@force)
	end
end

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
	property actif : Bool = true
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
          	  [Effet.new(Evenement::DEPLACER_AUTRE,3),Effet.new(Evenement::CHANGER_COLERE,-1)])]),
      
    CarteSurvie.new("Favoritisme",
            [Choix.new(Effet.new(Evenement::RIEN,0),
       	       [Effet.new(Evenement::DEPLACER_MOI,1),Effet.new(Evenement::DEPLACER_AUTRE,1)]),
            Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,3),
               [Effet.new(Evenement::DEPLACER_MOI,3),Effet.new(Evenement::DEPLACER_AUTRE,2),Effet.new(Evenement::DEPLACER_AUTRE,1)])]),

    CarteSurvie.new("Sacrifice",
            [Choix.new(Effet.new(Evenement::RIEN,0),
          	   [Effet.new(Evenement::CHANGER_COLERE,-1),Effet.new(Evenement::DEPLACER_AUTRE,-1)]),
            Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,1),
              [Effet.new(Evenement::CHANGER_COLERE,-2),Effet.new(Evenement::DEPLACER_AUTRE,-2)])]),
        
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

class CarteTrahison < CarteBonus
end

CARTES_TRAHISON = [
	CarteTrahison.new("Rancune",
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::DEPLACER_AUTRE,-2)]),
		Choix.new(Effet.new(Evenement::DEFAUSSER_PARTAGE,2),
			[Effet.new(Evenement::DEPLACER_SURVIVANTS,-2)])]),
	CarteTrahison.new("Violence",
		[Choix.new(Effet.new(Evenement::RIEN,0),
			[Effet.new(Evenement::CHANGER_COLERE,1)]),
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
			[Effet.new(Evenement::CHANGER_COLERE,2)])]),
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
		[Choix.new(Effet.new(Evenement::CHANGER_COLERE,1),
			[Effet.new(Evenement::RECUPERER_CARTE,0),Effet.new(Evenement::PIOCHER_MOI,1)]),
		Choix.new(Effet.new(Evenement::CHANGER_COLERE,1),
			[Effet.new(Evenement::BARQUE,0),Effet.new(Evenement::RECUPERER_CARTE,0)])]),
		
	CarteActionSurvivant.new(
		[Choix.new(Effet.new(Evenement::CHANGER_COLERE,1),
			[Effet.new(Evenement::PIOCHER_MOI,2)]),
		Choix.new(Effet.new(Evenement::CHANGER_COLERE,1),
			[Effet.new(Evenement::PIOCHER_MOI,1),Effet.new(Evenement::PIOCHER_ALLIE,1),Effet.new(Evenement::PIOCHER_ALLIE,1)])]),
		
	CarteActionSurvivant.new(
		[Choix.new(Effet.new(Evenement::CHANGER_COLERE,1),
			[Effet.new(Evenement::DEPLACER_MOI,2)]),
		Choix.new(Effet.new(Evenement::CHANGER_COLERE,1),
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


