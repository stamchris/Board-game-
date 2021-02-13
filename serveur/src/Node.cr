require "./Effet.cr"

class Node
    getter effect : Effet
    getter checkpointCerbere : Bool

    def initialize(@effect, @checkpointCerbere)
    end
end
