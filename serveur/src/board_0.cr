require "./Node.cr"

BOARD_0 = [

    Node.new(Effet.new(Evenement::RIEN,0),       # Effet
            false),                              # Checkpoint pour Cerbere

    Node.new(Effet.new(Evenement::RIEN,0),
            true),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::PIOCHER_MOI,1),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            true),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            true),

    Node.new(Effet.new(Evenement::PONT,0),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            true),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::PONT,1),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            true),

    Node.new(Effet.new(Evenement::PORTAIL,0),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            true),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::PORTAIL,1),
            false),

    Node.new(Effet.new(Evenement::REVELER_BARQUE,0),
            true),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::RIEN,0),
            false),

    Node.new(Effet.new(Evenement::CHANGER_RAGE,1),
            false),

    Node.new(Effet.new(Evenement::VERIFIER_BARQUE,0),
            false)

] of Node
