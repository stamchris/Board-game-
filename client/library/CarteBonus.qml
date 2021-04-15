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

	if(carteBonusName === "Oppo"){
		window.chooseOppoEffect(carteBonusName, choix, "play_bonus", []);
	}else{
		window.todoGenerator = window.playCard("bonus", carteBonusName, carteBonusName, choix);
		window.todoGenerator.next();
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


