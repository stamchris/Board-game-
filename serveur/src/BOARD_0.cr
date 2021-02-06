require "./Node.cr"

BOARD_0 : Array(Node) = [

    Node.new(0,                 # Id de la case
            Effet.new(RIEN,0),  # Effet
            false,              # Checkpoint pour Cerbere ?
            []                  # Cases precedentes
            [1]),               # Cases suivantes

    Node.new(1,
            Effet.new(RIEN,0),
            true,
            [0]
            [2]),

    Node.new(2,
            Effet.new(RIEN,0),
            false,
            [1]
            [3]),

    Node.new(3,
            Effet.new(PIOCHER_MOI,1),
            false,
            [2]
            [4]),

    Node.new(4,
            Effet.new(RIEN,0),
            true,
            [3]
            [5]),

    Node.new(5,
            Effet.new(RIEN,0),
            false,
            [4]
            [6]),

    Node.new(6,
            Effet.new(RIEN,0),
            false,
            [5]
            [7]),

    Node.new(7,
            Effet.new(RIEN,0),
            true,
            [6]
            [8]),
    
    Node.new(8,
            Effet.new(RIEN,0),
            false,
            [7]
            [9, 12]),

    Node.new(9,
            Effet.new(RIEN,0),
            false,
            [8]
            [10]),

    Node.new(10,
            Effet.new(RIEN,0),
            false,
            [9]
            [11]),

    Node.new(11,
            Effet.new(RIEN,0),
            false,
            [10]
            [12]),

    Node.new(12,
            Effet.new(RIEN,0),
            false,
            [11]
            [13]),

    Node.new(13,
            Effet.new(RIEN,0),
            true,
            [12]
            [14]),

    Node.new(14,
            Effet.new(RIEN,0),
            false,
            [13]
            [15]),

    Node.new(15,
            Effet.new(RIEN,0),
            true,
            [14]
            [16]),

    Node.new(16,
            Effet.new(ACTIVER_PORTAIL,0),
            false,
            [15]
            [17]),

    Node.new(17,
            Effet.new(RIEN,0),
            false,
            [16]
            [18]),
    
    Node.new(18,
            Effet.new(REVELER_BARQUE,0),
            true,
            [17]
            [19]),

    Node.new(19,
            Effet.new(RIEN,0),
            false,
            []18
            [20]),

    Node.new(20,
            Effet.new(RIEN,0),
            false,
            [19]
            [21])

    Node.new(21,
            Effet.new(RIEN,0),
            false,
            [20]
            [22])

    Node.new(22,
            Effet.new(RIEN,0),
            false,
            [21]
            [22])

    Node.new(23,
            Effet.new(VERIFIER_BARQUE,0),
            false,
            [22]
            [])

]