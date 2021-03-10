import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
import QtWebSockets 1.0
import "library"

Item {
    id: window
    property alias playerInfo: underBarId.playerInfo
    property alias boardId: boardId

    ImagePopUp {
            id: imgEffetDeCarteId
            source: "images/effetDeCarte.jpg"
    }

    Rectangle {
        id: menuBarId
        height: 60
        color: "#0ba360"
        
        anchors { 
            left: parent.left;
            right: parent.right;
            top: parent.top
        }

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

        Image {
            id: imglogoId
            width: 120
            height: 50
            horizontalAlignment: Image.AlignHCenter
            source: "images/cerbere_logo.png"
            fillMode: Image.Stretch

            anchors {
                bottom: parent.bottom;
                left: parent.left;
                top: parent.top;
                leftMargin: 8;
                topMargin: 5 
            }
        }

        Rectangle {
            id: loginId
            width: 50
            height: 50
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
            border.width: 2

            anchors {
                right: parent.right;
                top: parent.top;
                topMargin: 5;
                rightMargin: 10
            }

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

            anchors {
                right: loginId.left;
                top: parent.top;
                topMargin: 5;
                rightMargin: 10
            }

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

            anchors {
                right: sonId.left;
                top: parent.top;
                topMargin: 5;
                rightMargin: 10
            }

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

            anchors {
                right: bugId.left;
                top: parent.top;
                topMargin: 5;
                rightMargin: 10
            }

            Text {
                id: effetcarteTextId
                text: qsTr("Effet \nCarte")
                anchors.centerIn: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.FixedSize
            }

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    if (imgEffetDeCarteId.visible == false) {
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

            anchors {
                right: bugId.left;
                top: parent.top;
                topMargin: 5;
                rightMargin: 66
            }

            Text {
                id: regleTextId
                text: qsTr("Regles")
                anchors.centerIn: parent
                font.pixelSize: 12
                fontSizeMode: Text.FixedSize
            }

            MouseArea {
                visible: true
                anchors.fill: parent

                onClicked: {
                    var component = Qt.createComponent("library/ReglesDuJeu.qml")
                    var window = component.createObject("window2")
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
        property alias playerInfo: actionId.playerInfo

        Rectangle {
            id: chronoId
            width: underBarId.width*1/10
            height: underBarId.height
            color: "#ffffff"
            border.color: "#3fe219"
            border.width: 2

            anchors {
                left: underBarId.left;
                top: underBarId.top;
                leftMargin:2
            }

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
            width: underBarId.width*6/10
            height: underBarId.height
            color: "#ffffff"
            border.color: "#f23f1e"
            border.width: 2

            anchors {
                top:underBarId.top;
                left: chronoId.right;
                leftMargin: 5
            }

            CerbereBar{}
        }

        Rectangle {
            id: actionId
            height: underBarId.height
            color: "#ffffff"
            border.color: "#3fe219"
            border.width: 2
            property alias playerInfo: playerInfoId

            anchors {
                top: underBarId.top;
                left: progressBarId.right;
                right: parent.right;
                leftMargin: 5;
                rightMargin: 2
            }

            Text {
                id: playerInfoId
                text: window.parent.state.login
                color: window.parent.state.color 

                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                function updateLogin() {
                    text: window.parent.state.login
                }

                function updateColor() {
                    color: window.parent.state.color
                }
            }
        }
    }

    Rectangle {
        id: leftContainerId
        width: parent.width*2/10
        color: "#ffffff"
        border.width: 3

        anchors {
            top: underBarId.bottom;
            left: parent.left;
            bottom:parent.bottom;
            topMargin: 5;
            leftMargin: 2;
            bottomMargin: 5
        }

        Rectangle {
            id: chatId
            width: parent.width
            height: parent.height*6/10
            color: "#ffffff"
            border.width: 2

            anchors {
                top: infoJoueurId.bottom;
                topMargin: 0
            }
        }

        Rectangle {
            id: infoJoueurId
            width:  parent.width
            height: parent.height*4/10
            color: "#ffffff"
            border.color: "#f23f1e"
            border.width: 2

            anchors {
                top: parent.top
            }

            Column {
                id: columnId
                anchors.fill: parent

                Rectangle{
                    id: user1InfoId
                    width: parent.width
                    height: parent.height*1/6
                    color: "Blue"

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
                    height: parent.height*1/6
                    color: "Cyan"

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
                    id: user3InfoId
                    width: parent.width
                    height: parent.height*1/6
                    color: "Orange"

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
                    id: user4InfoId
                    width: parent.width
                    height: parent.height*1/6
                    color: "Green"

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
                    id: user5InfoId
                    width: parent.width
                    height: parent.height*1/6
                    color: "Red"

                    Text {
                        id: text5
                        height: parent.height
                        text: qsTr("USER5")
                        anchors.top: parent.top
                        font.pixelSize: 20
                        anchors.topMargin: 2
                    }
                }

                Rectangle {
                    id: user6InfoId
                    width: parent.width
                    height: parent.height*1/6
                    color: "Pink"

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
        width: parent.width*8/10
        color: "#ffffff"
        border.width: 3
        property alias boardId: boardId

        anchors {
            top: underBarId.bottom;
            bottom: joueurId.top;
            right: parent.right;
            left: leftContainerId.right;
            topMargin: 5;
            bottomMargin: 5;
            rightMargin: 2;
            leftMargin: 2
        }

        Image {
            id: plateauImageId
            anchors.fill: parent
            horizontalAlignment: Image.AlignHCenter
            source: "images/client_plateau-redimensionné.png"
            fillMode: Image.Stretch
            property alias boardId: boardId

            Plateau {
                id: boardId
            }
        }

        Rectangle {
            id: rectGroupsId
            height: 50
            width: 150
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            Rectangle {
                id: plusOne
                height: 50
                width: 50
                color: "Yellow"

                anchors {
                    top: parent.top;
                    left: parent.left
                }

                Text {
                    text: "+1"

                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    
                    onClicked: {
                        window.parent.state.send({
                            type: "change_position",
                            change: 1,
                            login: window.parent.state.login
                        })
                    }
                }
            }

            Rectangle {
                id: plusTwo
                height: 50
                width: 50
                color: "Orange"
            
                anchors {
                    top: parent.top;
                    left: plusOne.right
                }

                Text {
                    text: "+2"

                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    
                    onClicked: {
                        window.parent.state.send({
                            type: "change_position",
                            change: 2,
                            login: window.parent.state.login
                        })
                    }
                }
            }

            Rectangle {
                id: plusThree
                height: 50
                width: 50
                color: "Red"
            
                anchors {
                    top: parent.top;
                    left: plusTwo.right
                }

                Text {
                    text: "+3"

                    anchors {
                        verticalCenter: parent.verticalCenter
                        horizontalCenter: parent.horizontalCenter
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    
                    onClicked: {
                        window.parent.state.send({
                            type: "change_position",
                            change: 3,
                            login: window.parent.state.login
                        })
                    }
                }
            }    
        }
    }

    Rectangle {
        id: joueurId
        width: parent.width*8/10
        height: 210
        color: "#ffffff"
        border.color: "#e51111"
        border.width: 2

        anchors {
            bottom: parent.bottom;
            left: leftContainerId.right;
            right: parent.right;
            bottomMargin: 5;
            leftMargin: 2;
            rightMargin: 2
        }

        Rectangle {
            id: carte_Action1Id
            width: 170
            height: 210
            anchors.left: parent.left
            border.color: "#000000"
            border.width: 2

            Image {
                id:imgCAction1
                anchors.fill: parent
                anchors.leftMargin: 0
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source: "images/Carte1.png"

                CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action2Id
            width: 170
            height: 210
            anchors.left: carte_Action1Id.right
            border.color: "#000000"
            border.width: 2
            
            Image {
                id:imgCAction2
                anchors.fill: parent
                anchors.leftMargin: 5
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source: "images/Carte2.png"

                CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action3Id
            width: 170
            height: 210
            anchors.left: carte_Action2Id.right
            border.color: "#000000"
            border.width: 2
        
            Image {
               id: imgCAction3
               anchors.fill: parent
               anchors.leftMargin: 5
               horizontalAlignment: Image.AlignHCenter
               z: 1
               fillMode: Image.Stretch
               source: "images/Carte3.png"

               CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action4Id
            width: 170
            height: 210
            anchors.left: carte_Action3Id.right
            border.color: "#000000"
            border.width: 2
        
            Image {
                id: imgCAction4
                anchors.fill: parent
                horizontalAlignment: Image.AlignHCenter
                z: 1
                anchors.leftMargin: 5
                fillMode: Image.Stretch
                source: "images/Carte4.png"

                CarteAction{}
            }
        }
    }
}

