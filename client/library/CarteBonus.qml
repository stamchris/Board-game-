import QtQuick 2.9
    
Column {
    id: columnIdB
    height: parent.height
    width: parent.width

    anchors {
        top:parent.top;
        left: parent.left
    }

    signal clickCard()

    function discardBonus() {
        var numberOfCards = columnIdB.parent.children[1].children[0].text
        if (numberOfCards == "1") {
            columnIdB.parent.parent.visible = false 
        } else {
            var newNumberOfCards = parseInt(numberOfCards, 10) - 1
            columnIdB.parent.children[1].children[0].text = "" + newNumberOfCards
        }
    }

    function blockCard() {
        hover1Id.hoverEnabled = false
        up.color = "gray"
        up.opacity = 0.75
        hover2Id.hoverEnabled = false
        down.color = "gray"
        down.opacity = 0.75
    }

    function unblockCard() {
        hover1Id.hoverEnabled = true
        up.color = "White"
        up.opacity = 0
        hover2Id.hoverEnabled = true
        down.color = "White"
        down.opacity = 0
    }

    function playBonus(choix) {
        var carteBonusName = parent.source.toString()
        carteBonusName = carteBonusName.slice(carteBonusName.indexOf("_", carteBonusName.length-10))
        carteBonusName = carteBonusName.slice(1, carteBonusName.length - 4)

        if (carteBonusName == 'Arro' && choix == 0) {
            window.choosePlayers(["Choisissez un joueur à faire avancer de 1 case", "Choisissez un joueur à faire avancer d'1 case"], carteBonusName, choix, "play_bonus", "aventurier")
        } else if (carteBonusName == 'Fata' && choix == 1) {
            window.choosePlayers(["Choisissez un joueur à faire avancer de 3 cases"], carteBonusName, choix, "play_bonus", "aventurier")
        } else if (carteBonusName == "Fav" && choix == 0) {
            window.choosePlayers(["Choisissez un joueur à faire avancer d'1 case"], carteBonusName, choix, "play_bonus", "aventurier")
        } else if (carteBonusName == "Oppo" && choix == 0) {
            window.choosePlayers(["Choisissez un joueur à faire reculer d'1 case"], carteBonusName, choix, "play_bonus", "aventurier")
        } else if (carteBonusName == "Sac" && choix == 0) {
            window.choosePlayers(["Choisissez un joueur à faire reculer d'1 case"], carteBonusName, choix, "play_bonus", "aventurier")
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
        opacity: 0
        color: "White"

        MouseArea {
            id: hover1Id
            width: parent.width
            height: parent.height
            hoverEnabled: true

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
                    columnIdB.discardBonus()
                }
            }
        }
    }

    Rectangle {
        id: down
        width: columnIdB.width
        height: 1/5*columnIdB.height
        opacity: 0
        color: "White"
        
        MouseArea {
            id: hover2Id
            width: parent.width
            height: parent.height
            hoverEnabled: true

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
                    columnIdB.discardBonus()
                }
            }
        }
    }

    Component.onCompleted: {
        clickCard.connect(columnIdB.discardBonus)
    }
}


