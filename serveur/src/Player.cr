require "./Hand.cr"

class Player
    property lobbyId : Int32 = 0    # A definir
    property myHandAventurier : HandAventurier
    property myHandCerbere : HandCerbere
    property typeJoueur : Int32 = 1 # 0 si Cerbere
                                    # 1 si Aventurier
                                    # 2 si JoueurCerbere
    property position : Int32 = 1

    def initialize(@lobbyId, type = 1)
        # Cerbere est de type 0 et commence à la case 0
        if type == 0
            @typeJoueur = 0
            @position = 0
        end
        @myHandAventurier = HandAventurier.new
        @myHandCerbere = HandCerbere.new
    end
end