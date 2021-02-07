require "./Node.cr"

BOARD_0 = [

    Node.new(Effet.new(Evenement::RIEN,0),       # Effet
            false,                              # Checkpoint pour Cerbere ?
            [] of Int32,                        # Cases precedentes
            [1]),                               # Cases suivantes

    Node.new(Effet.new(Evenement::RIEN,0),
            true,
            [0],
            [2]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [1],
            [3]),

    Node.new(Effet.new(Evenement::PIOCHER_MOI,1),
            false,
            [2],
            [4]),

    Node.new(Effet.new(Evenement::RIEN,0),
            true,
            [3],
            [5]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [4],
            [6]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [5],
            [7]),

    Node.new(Effet.new(Evenement::RIEN,0),
            true,
            [6],
            [8]),
    
    Node.new(Effet.new(Evenement::ENTREE_PONT,0),
            false,
            [7],
            [9, 12]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [8],
            [10]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [9],
            [11]),

    Node.new(Effet.new(Evenement::SORTIE_PONT,0),
            false,
            [9, 10],
            [12]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [11],
            [13]),

    Node.new(Effet.new(Evenement::RIEN,0),
            true,
            [12],
            [14]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [13],
            [15]),

    Node.new(Effet.new(Evenement::RIEN,0),
            true,
            [14],
            [16]),

    Node.new(Effet.new(Evenement::ACTIVER_PORTAIL,0),
            false,
            [15],
            [17]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [16],
            [18]),
    
    Node.new(Effet.new(Evenement::REVELER_BARQUE,0),
            true,
            [17],
            [19]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [18],
            [20]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [19],
            [21]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [20],
            [22]),

    Node.new(Effet.new(Evenement::RIEN,0),
            false,
            [21],
            [22]),

    Node.new(Effet.new(Evenement::VERIFIER_BARQUE,0),
            false,
            [22],
            [] of Int32)

] of Node