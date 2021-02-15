enum Evenement
	RIEN # La carte n'a aucun coût
	RECUPERER_CARTE # Le joueur récupère toutes ses cartes Action
	PIOCHER_MOI # Le joueur pioche X cartes Survie/Trahison
	PIOCHER_ALLIE # X alliés du joueur pioche une carte Survie/Trahison
	DEFAUSSER_MOI # Le joueur doit défausser X cartes
	DEFAUSSER_SURVIE # X survivants sont obligés de défausser une carte
	DEFAUSSER_PARTAGE # X cartes Survie/Trahison doivent être défaussés, ce coût est partageable parmi les alliés
	CHANGER_VITESSE # La vitesse (valeur du dé) change
	CHANGER_RAGE # La colère (jauge) change
	DEPLACER_MOI # Le joueur se déplace
	DEPLACER_AUTRE # Le joueur déplace d'autres joueurs
	DEPLACER_AVENTURIERS # Tous les aventuriers se déplacent
	DEPLACER_CERBERE # Cerbère se déplace sur le plateau
	BARQUE # Le joueur peut soit consulter les barques, soit les changer de place
	COUARDISE # Deuxième effet de Couardise: le joueur avance d'autant de cases qu'il n'y a d'aventurier devant lui (max 3)
	SABOTAGE # Deuxième effet de Sabotage: tous les survivants choisissent soit de défausser une carte, soit de reculer de 2 cases

	ACTIVER_PORTAIL # Active le portail
	REVELER_BARQUE # Revele les barques
	VERIFIER_BARQUE # Verifie le nombre de joueur sur la barque
	ENTREE_PONT # Entree du pont
	SORTIE_PONT # Sortie du pont
end

class Effet
	getter evenement : Evenement
	getter force : Int32

	def initialize(@evenement,@force)
	end
end