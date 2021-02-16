require "./Hand.cr"

class Player
    property lobbyId : Int32 = 0    # A definir
    property myHand : Hand = Hand.new
    property typeJoueur : Int32 = 1 # 0 si Elimine
                                    # 1 si Aventurier
                                    # 2 si JoueurCerbere
    property position : Int32 = 1

    def initialize(@lobbyId)
    end
end