require "./Hand.cr"

"_P : fonction que je rajoute en plus : idée "

class Player
    property lobbyId : Int32 = 0    # A definir
    property myHand : Hand = Hand.new
    property typeJoueur : Int32 = 1 # 0 si Elimine
                                    # 1 si Aventurier
                                    # 2 si JoueurCerbere
    property position : Int32 = 1

    def initialize(@lobbyId)
    end



    def mouv_Pplayer(num : Int32)
        
    end
end