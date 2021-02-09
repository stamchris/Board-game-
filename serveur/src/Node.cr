require "./Effet.cr"

class Node
    getter effect : Effet
    getter checkpointCerbere : Bool
    property previousNodes : Array(Int32)
    property nextNodes : Array(Int32)

    def initialize(@effect, @checkpointCerbere, @previousNodes, @nextNodes)
    end
end