require "./Board.cr"
require "./Player.cr"
require "./Deck.cr"
require "./Carte.cr"

# Classe temporaire representant les utilisateurs provenant du lobby
class User
    property userId : Int32

    def initialize(@userId)
    end
end

class Game
    property cerbereBoard : Board
    getter difficulty : Int32
    getter users : Array(User)
    getter numberOfPlayers : Int32

    def initialize(@difficulty, @users)
        @numberOfPlayers = users.size
        @cerbereBoard.new(users, difficulty)
    end
end