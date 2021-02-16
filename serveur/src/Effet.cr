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

	PROMONTOIRE # Lorsqu'un joueur arrive sur la case promontoire, il peut voir une barque ou échanger 2 barques
	PILOTIS # Si un joueur se trouve sur une case pilotis, on ne peut pas passer par cette case ou s'y arrêter
	FUNICULAIRE # Si un joueur commence son déplacement sur une case funiculaire, il peut aller à l'autre case funiculaire en 1 déplacement
	PORTAIL # Portail actif lorsqu'il y a un joueur sur la stèle
	REVELER_BARQUE # Révèle la barque active
	VERIFIER_BARQUE # Vérifie le nombre de joueurs sur la barque active
	PONT # Pont de cordes, utilisable une fois dans la partie
end

class Effet
	property evenement : Evenement
	getter force : Int32

	def initialize(@evenement,@force)
	end
end
