require "./effet.cr"

class Node
    getter effect : Effet
    getter checkpoint_cerbere : Bool
    property previous_nodes : Array(Int32)
    property next_nodes : Array(Int32)

    def initialize(@effect, @checkpoint_cerbere, @previous_nodes, @next_nodes)
    end
end