require "./hand.cr"

enum TypeJoueur
    AVENTURIER # Joueur dans le camp Aventurier
    CERBERE # Joueur dans le camp Cerbère
    MORT # Joueur éliminé
end

class Player
    property lobby_id : Int32 = 0    # A definir
    property hand : Hand = Hand.new
    property type : TypeJoueur = TypeJoueur::AVENTURIER
    property position : Int32 = 1

    def initialize(@lobby_id)
    end
end