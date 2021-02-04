"
	@param[bool_checkpoint]
	@param[methode_effet]
	@param[méthode avant_apres]
"
class Case 
	getter bool_checkpoint : Bool
	def initialize(@bool_checkpoint)
	end

	def effet()
		#Affiche l'effet de la case // ou le renvoie en String
	end

	def case_before_after()
		#Affiche la case avant et la case après // ou les renvoie en struct{b,a}
	end

	def get_checkpoint()
		@bool_checkpoint
	end

end

"
 @param[Tableaux_Objet_Case]
 @param[3_Barques]
 @param[]
"
class Plateau 
	getter tab_case : Array(Case)


	def initialize(@tab_case)
	end

	def nb_case()
		i = 0
		@tab_case.each do |cse|
			i+= 1
		end

		i
	end

end

class Barque 
	getter num_place : Int32
	getter reveal : Bool 
	@reveal = false


	def initialize(@num_place)
	end


	def reveal_barque()
		reveal = true
	end

end 

class Carte 
end 

class Carte_Bonus < Carte
	def initialize()

	end

end

class Carte_Action < Carte
	def initialize()
	end
end

"
@param[Pile_de_cartes]
"

class Pioche 
	getter carte_bonus_p : Array(Carte_Bonus)
	
	def initialize(@carte_bonus_p)
	end


	def nb_carte_b()
		i = 0
		@carte_bonus_p.each do |cbp|
			i+=1
		end

		i

	end

	def melanger()
		#Tire un nombre random entre le nombre max de chaque Pioche
		nb_carte = self.nb_carte_b()
		new_index = 0
		old_index = 0
		i = 0
		tmp = Carte_Bonus.new 
		@carte_bonus_p.each do |cbp|
			old_index = i
			new_index = Random.rand(nb_carte)
			tmp = carte_bonus_p[old_index]
			carte_bonus_p[old_index] = carte_bonus_p[new_index]
			carte_bonus_p[new_index] = tmp 
			i+=1
		end 	
	end
	def piocher()
		#Avant chaque pioche on appellera mélanger
		self.melanger() # donne celui en tête du tableau 
		#on retourne l'id de la carte 
		carte_bonus_p[(self.nb_carte_b())-1]
	end

end
"
@param[tableaux_bonus]
@param[tableaux_action]
"

class Main
	#property Carte_Action_tab : [] of Carte_Action  
	#property Carte Bonus_tab : [] of Carte_Bonus

	def initialize()
	end

end


"
 @param[nom]
 @param[couleur]
 @param[id]
 @param[Main]
 @param[bool_cerbere]
 @param[achievement] //option
 @param[position]
 @param[statut] //0 : aventurieur , //1: cerbere ,//2 : eliminer
 


"


class Player
	getter nom : String
	getter couleur : String
	getter id : Int32
	getter achievement : Int32 #option
	getter position : Int32
	getter statut : Int32 # 0 , 1 , 2 : cerbere, aventurier,eliminé
	#getter socket : HTTP::WebSocket

	def initialize(@nom,@couleur,@id,@achievement,@position,@statut)#@socket) 
		
	end


	def get_color()
		@couleur
	end


end


"
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

"




class Jeu 
	getter nb_joueurs : Int32
	plateau_p : Plateau 
	joueurs_k : Array(Player)
	ordre_joueurs : Array(Int32) #Premiere case du tab pour Cerbere
	getter vitesse : Int32
	getter rage : Int32
	def initialize(@nb_joueurs,@vitesse,@rage)
		@vitesse = vitesse
	end

	def get_nb_joueurs()
		puts nb_joueurs
	end 

	def joueurs_in_game()
		#Si il y'a changement de statut on modifie le nombre de joueurs
		#On estime que c'est le nombre d'aventurier

		#Parcourir les joueurs et voir si statut à changé
		#Si c'est le cas : nb_joueurs--

	end

	def up_speed()
		if (vitesse < 8)
			@vitesse+=1
		end

	end

	def up_rage()
		if (rage < 9)
			@rage+=1
		end

	end

	def down_speed()
		if (vitesse > 3)
			@vitesse-= 1
		end
	end

	def down_rage()
		if(rage > nb_joueurs)
			@rage-=1
		end
	end

end




"Test Player"


players = [] of Player
players << Player.new "John","red",1,1000,0,1
players << Player.new "Luc","blue",1,1000,0,1
players << Player.new "Marc", "green",1,1000,0,1

puts players[2].get_color();


"Test "

Cases = Array(Case).new
Cases << Case.new false
Cases << Case.new false
Cases << Case.new false
Cases << Case.new true

puts Cases[3].get_checkpoint();
puts Cases[2].get_checkpoint();

"Test"

P = Plateau.new(Cases)
puts P.nb_case();

"Test"

Bonus_card = [] of Carte_Bonus
Bonus_card << Carte_Bonus.new

Pioche_p = Pioche.new(Bonus_card)

puts Pioche_p.piocher() # il faut encore savoir ce que j'affiche de la carte renvoyer




