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

        function blockCard() {
            var nb_same_card_bonus = columnIdB.parent.children[1].children[0].text
            if (nb_same_card_bonus == "1") {
                columnIdB.parent.parent.visible = false 
            }
            else {
                var nb_card = parseInt(nb_same_card_bonus,10)
                var new_nb_card = nb_card - 1
                var str_nb_card = ""+new_nb_card
                columnIdB.parent.children[1].children[0].text = str_nb_card
            }
        }

        Rectangle {
            id:empty
            width : columnIdB.width
            height : 3/5*columnIdB.height
            opacity : 0
        }

        Rectangle {
            id: up
            width: columnIdB.width
            height: 1/5*columnIdB.height
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
                    columnIdB.blockCard()
                }
            }
        }

        Rectangle {
            id: down
            width: columnIdB.width
            height: 1/5*columnIdB.height
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
                    columnIdB.blockCard()
                }
            }
        }

        Component.onCompleted: {
            clickCard.connect(columnIdB.blockCard)
        }
    }


