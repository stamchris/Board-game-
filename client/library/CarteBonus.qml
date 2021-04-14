import QtQuick 2.9
    
Column {
    id: columnIdB
    height: parent.height
    width: parent.width
    property bool blocked: true

    anchors {
        top:parent.top;
        left: parent.left
    }

    function playBonus(choix) {
        var carteBonusName = parent.source.toString()
        carteBonusName = carteBonusName.slice(carteBonusName.indexOf("_", carteBonusName.length-10))
        carteBonusName = carteBonusName.slice(1, carteBonusName.length - 4)

        if (carteBonusName == 'Arro' && choix == 0) {
            window.choosePlayers(["Choisissez un joueur à faire avancer de 1 case", "Choisissez un joueur à faire avancer d'1 case"], carteBonusName, choix, "play_bonus", "aventurier", [])
        } else if (carteBonusName == 'Arro' && choix == 1){
            window.chooseCardsToDiscard(carteBonusName, choix, 1, "play_bonus")
        } else if (carteBonusName == 'Couar' && choix == 0){
            window.chooseBarquesEffect(carteBonusName, choix, "play_bonus")
        } else if (carteBonusName == 'Couar' && choix == 1){
            window.chooseCardsToDiscard(carteBonusName, choix, 1, "play_bonus")
        } else if (carteBonusName == 'Ego' && choix == 1){
            window.chooseCardsToDiscard(carteBonusName, choix, 1, "play_bonus")
        } else if (carteBonusName == 'Fata' && choix == 1) {
            window.choosePlayers(["Choisissez un joueur à faire avancer de 3 cases"], carteBonusName, choix, "play_bonus", "aventurier", [])
        } else if (carteBonusName == "Fav" && choix == 0) {
            window.choosePlayers(["Choisissez un joueur à faire avancer d'1 case"], carteBonusName, choix, "play_bonus", "aventurier", [])
        } else if (carteBonusName == "Fav" && choix == 1) {
            window.chooseCardsToDiscard(carteBonusName, choix, 3, "play_bonus")
        } else if (carteBonusName == "Oppo" && choix == 0) {
            window.choosePlayers(["Choisissez un joueur à faire reculer d'1 case"], carteBonusName, choix, "play_bonus", "aventurier", [])
        } else if (carteBonusName == "Oppo" && choix == 1) {
           window.chooseCardsToDiscard(carteBonusName, choix, 1, "play_bonus")
        } else if (carteBonusName == "Sac" && choix == 0) {
            window.choosePlayers(["Choisissez un joueur à faire reculer d'1 case"], carteBonusName, choix, "play_bonus", "aventurier", [])
        } else if (carteBonusName == "Sac" && choix == 1) {
            window.chooseCardsToDiscard(carteBonusName, choix, 1, "play_bonus")
        } else {
            window.parent.state.send({
                type: "play_bonus",
                effet: choix,
                carte: carteBonusName,
                args: []
            })
        }
    }

    Rectangle {
        id: empty
        width: columnIdB.width
        height: 3/5*columnIdB.height
        opacity: 0
    }

    Rectangle {
        id: up
        width: columnIdB.width
        height: 1/5*columnIdB.height
        anchors.left: parent.left
        opacity: columnIdB.blocked ? 0.75 : 0
        color: columnIdB.blocked ? "gray" : "White"

        MouseArea {
            id: hover1Id
            width: parent.width
            height: parent.height
            hoverEnabled: !columnIdB.blocked

            onHoveredChanged: {
                if(hoverEnabled == true) {
                    if(containsMouse == true) {
                        up.opacity = 0.25
                    } else {
                        up.opacity = 0
                    }
                }
            }

            onClicked: {
                if (hover1Id.hoverEnabled == true) {
                    playBonus(0)
                }
            }
        }
    }

    Rectangle {
        id: down
        width: columnIdB.width
        height: 1/5*columnIdB.height
        opacity: columnIdB.blocked ? 0.75 : 0
        color: columnIdB.blocked ? "gray" : "White"
        
        MouseArea {
            id: hover2Id
            width: parent.width
            height: parent.height
            hoverEnabled: !columnIdB.blocked

            onHoveredChanged: {
                if(hoverEnabled == true) {
                    if(containsMouse == true) {
                        down.opacity = 0.25
                    } else {
                        down.opacity = 0
                    }
                }
            }

            onClicked: {
                if (hover2Id.hoverEnabled == true) {
                    playBonus(1)
                }
            }
        }
    }
}


