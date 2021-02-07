require "./Effet.cr"

class Node
    getter number : Int32
    getter effect : Effet
    getter checkpointCerbere : Bool
    property previousNodes : Array(Int32)
    property nextNodes : Array(Int32)

    def initialize(@number, @effect, @checkpointCerbere,
                   @previousNodes, @nextNodes)
    end
end