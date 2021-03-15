import QtQuick 2.10

Column {
    id: columnId
    height: 210
    width: 170

    anchors {
        top: parent.top;
        left: parent.left
    }

    function blockCard() {
        hover1Id.hoverEnabled = false
        up.color = "gray"
        up.opacity = 0.9
        hover2Id.hoverEnabled = false
        down.color = "gray"
        down.opacity = 0.9
    }

    function unblockCard() {
        hover1Id.hoverEnabled = true
        up.color = "blue"
        up.opacity = 0
        hover2Id.hoverEnabled = true
        down.color = "red"
        down.opacity = 0
    }

    function playAction(choix) {
        var num_carte = parent.source.toString()
        num_carte = num_carte.charAt(num_carte.length - 5)
        window.parent.state.send({
            type: "play_action",
            effet: choix,
            carte: num_carte
        })
    }

    Rectangle {
        id: up
        width: columnId.width
        height: columnId.height/2
        anchors.left: parent.left
        opacity: 0
        color: "blue"

        MouseArea {
            id: hover1Id
            width: parent.width
            height: parent.height
            hoverEnabled: true

            onHoveredChanged: {
                if (hoverEnabled == true) {
                    if (containsMouse == true) {
                        up.opacity = 0.4
                    } else {
                        up.opacity = 0
                    }
                }
            }

            onClicked: {
                columnId.playAction(0)
            }
        }
    }

    Rectangle {
        id: down
        width: columnId.width
        height: columnId.height/2
        opacity: 0
        color:  "red"
        
        MouseArea {
            id: hover2Id
            width: parent.width
            height: parent.height
            hoverEnabled: true

            onHoveredChanged: {
                if (hoverEnabled == true) {
                    if (containsMouse == true) {
                        down.opacity = 0.4
                    } else {
                        down.opacity = 0
                    }
                }
            }

            onClicked: {
                columnId.playAction(1)
            }
        }
    }
}

