import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

Item {

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "#ffffde"

    }

    ScrollView {
        x: 0
        y: app.height - 78
        width: 355
        height: 78
        Layout.fillHeight:true
        Layout.alignment: Qt.AlignHCenter

        ListView {
            x: 0
            y: parent.height - 78
            model: game.players
            delegate:Text {
                color: modelData.colour
                text: modelData.name + " est connecté"
                font.pointSize: 12
                font.family: "Stoneyard"
                Layout.alignment: Qt.AlignHCenter

            }
        }
    }


    ColumnLayout {

        width: 800
        height: 600

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0

        BorderImage {
            width: 270
            height: 115
            y: 150
            source: "client_images_cerbere_logo.png"
            anchors.horizontalCenter: parent.horizontalCenter

        }

        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text : "Choix des joueurs :"
            font.pointSize: 24
            font.family: "Stoneyard"
        }

        RowLayout {
            id: lobby

            width: parent.width
            height: 250

            spacing: 10

            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle{

                width: 100
                height: 300
                color: "#ffffde"

                anchors.verticalCenter: parent.VerticalCenter

                    BorderImage {
                        y: 17
                        width: 100
                        height: 100
                        source: "cyan_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: "cyan_pion.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {

                        text : "Cyan"
                        font.pointSize: 12
                        font.family: "Stoneyard"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y:260
                        background: Rectangle {
                            color: "Cyan"
                            border.color: "black"
                        }


                        onClicked: {
                            socket.send({type:"change_colour",colour:"White"})
                        }
                    }

            }

            Rectangle{

                width: 100
                height: 300
                color: "#ffffde"

                anchors.verticalCenter: parent.VerticalCenter

                    BorderImage {
                        y: 17
                        width: 100
                        height: 100
                        source: "orange_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: "orange_pion.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {

                        text : "Orange"
                        font.pointSize: 12
                        font.family: "Stoneyard"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y:260
                        background: Rectangle {
                            color: "Orange"
                            border.color: "black"
                        }


                        onClicked: {
                            socket.send({type:"change_colour",colour:"White"})
                        }
                    }

            }

            Rectangle{

                width: 100
                height: 300
                color: "#ffffde"

                anchors.verticalCenter: parent.VerticalCenter

                    BorderImage {
                        y: 17
                        width: 100
                        height: 100
                        source: "vert_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: "vert_pion.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {

                        text : "Green"
                        font.pointSize: 12
                        font.family: "Stoneyard"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y:260
                        background: Rectangle {
                            color: "Green"
                            border.color: "black"
                        }


                        onClicked: {
                            socket.send({type:"change_colour",colour:"White"})
                        }
                    }

            }

            Rectangle{

                width: 100
                height: 300
                color: "#ffffde"

                anchors.verticalCenter: parent.VerticalCenter

                    BorderImage {
                        y: 17
                        width: 100
                        height: 100
                        source: "rose_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: "rose_pion.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {

                        text : "Pink"
                        font.pointSize: 12
                        font.family: "Stoneyard"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y:260
                        background: Rectangle {
                            color: "Pink"
                            border.color: "black"
                        }


                        onClicked: {
                            socket.send({type:"change_colour",colour:"White"})
                        }
                    }

            }

            Rectangle{

                width: 100
                height: 300
                color: "#ffffde"

                anchors.verticalCenter: parent.VerticalCenter

                    BorderImage {
                        y: 17
                        width: 100
                        height: 100
                        source: "bleu_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: "bleu_pion.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {

                        text : "Blue"
                        font.pointSize: 12
                        font.family: "Stoneyard"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y:260
                        background: Rectangle {
                            color: "Blue"
                            border.color: "black"
                        }


                        onClicked: {
                            socket.send({type:"change_colour",colour:"White"})
                        }
                    }

            }

            Rectangle{

                width: 100
                height: 300
                color: "#ffffde"

                anchors.verticalCenter: parent.VerticalCenter

                    BorderImage {
                        y: 17
                        width: 100
                        height: 100
                        source: "rouge_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: "rouge_pion.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {

                        text : "Red"
                        font.pointSize: 12
                        font.family: "Stoneyard"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y:260
                        background: Rectangle {
                            color: "Red"
                            border.color: "black"
                        }


                        onClicked: {
                            socket.send({type:"change_colour",colour:"White"})
                        }
                    }

            }

            Rectangle{

                width: 100
                height: 300
                color: "#ffffde"

                anchors.verticalCenter: parent.VerticalCenter

                    BorderImage {
                        y: 17
                        width: 100
                        height: 100
                        source: "blanc_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: "blanc_pion.png"
                        rotation: 270
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Button {

                        text : "White"
                        font.pointSize: 12
                        font.family: "Stoneyard"
                        anchors.horizontalCenter: parent.horizontalCenter
                        y:260
                        background: Rectangle {
                            color: "White"
                            border.color: "black"
                        }


                        onClicked: {
                            socket.send({type:"change_colour",colour:"White"})
                        }
                    }

            }
        }


        CheckBox {
            y: 600
            anchors.horizontalCenter: parent.horizontalCenter
            text : "Je suis prêt !"
            font.pointSize: 12
            font.family: "Stoneyard"
            onClicked : {
                socket.send({type: "ready"})
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:768;width:1024}D{i:1;locked:true}D{i:5;locked:true}
}
##^##*/


/*Repeater {
model:["Cyan","Orange","Green","White","Pink","Blue","Red"]

Image {
width: 10
height: 20
source: "cerbere-personnages-" + modelData + ".jpg"
}



Button {

text : modelData
font.pointSize: 12
font.family: "Stoneyard"
    background: Rectangle {
        color: modelData
    }

    onClicked: {
        socket.send({type:"change_colour",colour:modelData})
        }
}
anchors.verticalCenter: parent.verticalCenter
anchors.horizontalCenter: parent.horizontalCenter
}*/
