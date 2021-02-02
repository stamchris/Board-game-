require "json"
require "kemal"


class Payload::Login
	include JSON::Serializable

	property login : String
end


"""




"""









"""
/* @brief : La classe jeu possède des plateaux 
 * 			les plateaux possède des cases/cases spéciales
 *			Chaque plateau possède une difficulté
 *			Le plateau de départ possède la piste de rage
 *			
 *			Lors de la création du Jeu on doit initialiser la piste de rage
 *			en fonction de la difficulté donné par les joueurs avec le dé 
 *			et du nombre de joueur qui joue 
 *			

 * @param[nb_Joueurs] : Le nombre de joueur qui joue sur le plateau
 * @param[Plateau] ; Plateau
 * @param[tab_int]: ordre des joueurs
 * @param[vitesse]
 * @param[pioche] : 
 * @param[rage]
 



 * @return Cette classe renvoie un Jeu initialiser au départ, avec des plateaux vides
 *		   et des joueurs qui sont placés sur la case départ
 *         Au fur et à mesure que le jeu avance le Jeu devra se modifier avec le nb
 *		   joueurs qu'il reste en jeu et une fois que les vainqueurs auront 
 *		   donc étaient désignés vainqueurs alors on enverra à l'interface 
 *		   le signal pour afficher les vainqueurs, puis le Jeu pour se terminer
 *		   et le serveur pourra s'éteindre

"""

class Jeu 




"""
 @param[Tableaux_Objet_Case]
 @param[3_Barques]
 @param[]


"""


class Plateau 


"""
	@param[bool_checkpoint]
	@param[methode_effet]
	@param[méthode avant_apres]



"""

class Case 


"""
@param[Pile_de_cartes]
"""


class Pioche 


"""
 @param[nom]
 @param[couleur]
 @param[id]
 @param[Main]
 @param[bool_cerbere]
 @param[achievement] //option
 @param[position]
 @param[statut] //0 : aventurieur , //1: cerbere ,//2 : eliminer
 


"""


class Player
	name : String
	color : String

	def initialize(@name,@color) 
		@name = name
		@color = color


	end
end

players = [] of Player
players << Player.new "John","red"
players << Player.new "Luc","blue"
players << Player.new "Marc", "green"



"""
@param[tableaux_bonus]
@param[tableaux_action]
"""

class Main

