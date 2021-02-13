import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: window
    width: 1600
    height: 800
    visible: true
    property alias plateauImageId: plateauImageId
    title: qsTr("Cerbere")

    ImagePopUp{
            id: imgEffetDeCarteId
            source:"images/effetDeCarte.jpg"
    }
    ImagePopUp{
           id: imgRegleId
           source:"images/effetDeCarte.jpg"
    }

       Rectangle {
        id: menuBarId
        height: 60
        color: "#0ba360"
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#30cfd0"
            }

            GradientStop {
                position: 1
                color: "#330867"
            }
        }
        border{color: "#e51111" ; width:2;}
        anchors { left: parent.left; right:parent.right; top: parent.top }


          Image {
                id: imglogoId
                width: 120
                height: 50
                anchors { bottom: parent.bottom; left:parent.left; top: parent.top; leftMargin: 8; topMargin: 5 }
                horizontalAlignment: Image.AlignHCenter
                source: "images/cerbere_logo.png"
                fillMode: Image.Stretch
            }

       Rectangle {
           id: loginId
           width: 50
           height: 50
           color: "#ffffff"
           radius: 40
           border.color: "#1143c8"
           border.width: 2
           anchors { right: parent.right ; top:parent.top; topMargin:5; rightMargin:10 }

           Text {
               id: loginTextId
               text: qsTr("Button")
               anchors.centerIn: parent
               font.pixelSize: 12
               horizontalAlignment: Text.AlignHCenter
           }
       }

        Rectangle {
            id: sonId
            width: 50
            height: 50
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
            border.width: 2
            anchors { right: loginId.left; top: parent.top; topMargin: 5; rightMargin: 10 }

            Text {
                id: sonTextId
                text: qsTr("Son")
                anchors.centerIn: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
            }

        }
        Rectangle {
            id: bugId
            width: 50
            height: 50
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
            border.width: 2
            anchors { right: sonId.left; top: parent.top; topMargin: 5; rightMargin: 10 }

            Text {
                id: bugTextId
                text: qsTr("Bug")
                anchors.centerIn: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
            }

        }

        Rectangle {
            id: effetcarteId
            width: 50
            height: 50
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
            border.width: 2
            anchors { right: bugId.left; top: parent.top; topMargin: 5; rightMargin: 10 }

            Text {
                id: effetcarteTextId
                text: qsTr("Effet \nCarte")
                anchors.centerIn: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.FixedSize
            }

            MouseArea{
                    anchors.fill: parent
                    onClicked:{
                               if (imgEffetDeCarteId.visible == false)
                                {
                                   imgEffetDeCarteId.visible = true
                                } else {
                                   imgEffetDeCarteId.visible = false
                               }
                    }
            }

        }

        Rectangle {
            id: regleId
            width: 50
            height: 50
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
            border.width: 2
            anchors { right: bugId.left; top: parent.top; topMargin: 5; rightMargin: 66 }
            Text {
                id: regleTextId
                text: qsTr("Regles")
                anchors.centerIn: parent
                font.pixelSize: 12
                fontSizeMode: Text.FixedSize
            }
            MouseArea{
                visible: true
                anchors.fill: parent
                onClicked:{
                    var component = Qt.createComponent("ReglesDuJeu.qml")
                    var window    = component.createObject("window2")
                    window.show()
                }

            }

        }
    }
    Rectangle {
        id: underBarId
        height: 68
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: menuBarId.bottom
        anchors.topMargin: 5

        Rectangle {
            id: chronoId
            width: 1/10 * underBarId.width
            height: underBarId.height
            color: "#ffffff"
            border.color: "#3fe219"
            border.width: 2
            anchors { left: underBarId.left; top: underBarId.top; leftMargin:2}

            Text {
                id: chronoTimeId
                width: 95
                height: 17
                color: "#e51111"
                text: qsTr("01:00")
                font.pixelSize: 22
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }
        }

        Rectangle {
            id: progressBarId
            width: 6/10 * underBarId.width
            height: underBarId.height
            color: "#ffffff"
            border.color: "#f23f1e"
            border.width: 2
            anchors { top:underBarId; left: chronoId.right; leftMargin: 5}
        }

        Rectangle {
            id: actionId
            height: underBarId.height
            color: "#ffffff"
            border.color: "#3fe219"
            border.width: 2
            anchors { top: underBarId.top; left: progressBarId.right; leftMargin: 5; right: parent.right; rightMargin: 2 }
        }

    }
    Rectangle{
        id: leftContainerId
        width: 2/10 * parent.width
        color: "#ffffff"
        border.width: 3
        anchors { top: underBarId.bottom; left: parent.left; bottom:parent.bottom; topMargin: 5; leftMargin: 2; bottomMargin: 5}

        Rectangle {
            id: chatId
            width: parent.width
            height: 6/10 * parent.height
            color: "#ffffff"
            border.width: 2
            anchors { top:infoJoueurId.bottom; topMargin:0}
        }

        Rectangle {
            id: infoJoueurId
            width: parent.width
            height: 4/10 * parent.height
            color: "#ffffff"
            border.color: "#f23f1e"
            border.width: 2
            anchors { top: parent.top}

            Column {
                id: columnId
                anchors.fill: parent

                Rectangle{
                    id: user1InfoId
                    width: parent.width
                    height: 1/6* parent.height
                    color: "blue"

                    Text {
                        id: text1
                        height: parent.height
                        text: qsTr("USER1")
                        anchors.top: parent.top
                        font.pixelSize: 20
                        anchors.topMargin: 2
                    }
                }

                Rectangle{
                    id: user2InfoId
                    width: parent.width
                    height: 1/6* parent.height
                    color: "#9f9fdf"
                    Text {
                        id: text2
                        height: parent.height
                        text: qsTr("USER2")
                        anchors.top: parent.top
                        font.pixelSize: 20
                        anchors.topMargin: 2
                    }
                }

                Rectangle{
                    id:user3InfoId
                    width: parent.width
                    height: 1/6* parent.height
                    color: "#c6d6e7"
                    Text {
                        id: text3
                        height: parent.height
                        text: qsTr("USER3")
                        anchors.top: parent.top
                        font.pixelSize: 20
                        anchors.topMargin: 2
                    }
                }

                Rectangle{
                    id:user4InfoId
                    width: parent.width
                    height: 1/6* parent.height
                    color: "#40c9d9"
                    Text {
                        id: text4
                        height: parent.height
                        text: qsTr("USER4")
                        anchors.top: parent.top
                        font.pixelSize: 20
                        anchors.topMargin: 2
                    }
                }

                Rectangle{
                    id:user5InfoId
                    width: parent.width
                    height: 1/6* parent.height
                    color: "#26d08a"
                    Text {
                        id: text5
                        height: parent.height
                        text: qsTr("USER5")
                        anchors.top: parent.top
                        font.pixelSize: 20
                        anchors.topMargin: 2
                    }
                }

                Rectangle{
                    id:user6InfoId
                    width: parent.width
                    height: 1/6* parent.height
                    color: "#acde98"
                    Text {
                        id: text6
                        height: parent.height
                        text: qsTr("USER6")
                        anchors.top: parent.top
                        font.pixelSize: 20
                        anchors.topMargin: 2
                    }
                }

            }
        }
    }

    Rectangle {
        id: plateauId
        width: 8/10 * parent.width
        color: "#ffffff"
        border.width: 3
        anchors {
            top: underBarId.bottom; bottom: joueurId.top; right: parent.right; left: leftContainerId.right;
            topMargin: 5; bottomMargin: 5; rightMargin: 2; leftMargin: 2
        }

        Image {
            id: plateauImageId
            anchors.fill: parent
            horizontalAlignment: Image.AlignHCenter
            source: "images/plateau.png"
            z: 1
            fillMode: Image.Stretch

        }
    }


    Rectangle {
        id: joueurId
        width: 8/10 * parent.width
        height: 210
        color: "#ffffff"
        border.color: "#e51111"
        border.width: 2
        anchors {
            bottom: parent.bottom; left: leftContainerId.right; right: parent.right;
            bottomMargin: 5; leftMargin: 2; rightMargin: 2
        }
    }


}

