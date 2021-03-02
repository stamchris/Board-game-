import QtQuick 2.10

Column {
    id: columnId
    height: 210
    width: 170

    anchors {
        top:parent.top;
        left: parent.left
    }

    signal clickCard()

    function blockCard() {
        hover1Id.hoverEnabled = false
        up.color = "gray"
        up.opacity = 0.9
        hover2Id.hoverEnabled = false
        down.color = "gray"
        down.opacity = 0.9
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
                if(hoverEnabled == true) {
                    if(containsMouse == true) {
                        up.opacity = 0.4
                    } else {
                        up.opacity = 0
                    }
                }
            }

            onClicked: {
                columnId.clickCard()
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
                if(hoverEnabled == true) {
                    if(containsMouse == true) {
                        down.opacity = 0.4
                    } else {
                        down.opacity = 0
                    }
                }
            }

            onClicked: {
                columnId.clickCard()
            }
        }
    }

    Component.onCompleted: {
        clickCard.connect(columnId.blockCard)
    }
}

