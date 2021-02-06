require "./Effet.cr"

class Node
    getter nodeNumber : Int8
    getter effect : Effet
    getter checkpointCerbere : Bool
    property previousNodes : Array(Int32)
    property nextNodes : Array(Int32)

    def initialize(@nodeNumber, @effect, @checkpointCerbere,
                   @previousNodes, @nextNodes)
    end
end