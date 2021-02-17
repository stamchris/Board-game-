require "./Board.cr"
require "./Player.cr"
require "./deck.cr"
require "./carte.cr"

# Classe temporaire representant les utilisateurs provenant du lobby
class User
    property user_id : Int32

    def initialize(@user_id)
    end
end

class Game
    property board : Board
    getter difficulty : Int32
    getter users : Array(User)
    getter number_players : Int32

    def initialize(@difficulty, @users)
        @number_players = users.size
        @board = Board.new(@difficulty, @users)
    end
end