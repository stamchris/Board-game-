require "./effet.cr"

class Node
	getter effect : Effet
	getter checkpoint_cerbere : Bool

	def initialize(@effect, @checkpoint_cerbere)
	end
end
