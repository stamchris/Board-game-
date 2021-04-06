import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

Item {

	property string src: typeof ROOT_URL === "undefined" ? "" : ROOT_URL

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
            source: "images/cerbere_logo.png"
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
                        source: "images/cyan_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: src+"images/cyan_pion.png"
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
                            socket.send({type:"change_colour",colour:"Cyan"})
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
                        source: "images/orange_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: src+"images/orange_pion.png"
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
                            socket.send({type:"change_colour",colour:"Orange"})
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
                        source: "images/vert_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: src+"images/vert_pion.png"
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
                            socket.send({type:"change_colour",colour:"Green"})
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
                        source: "images/rose_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: src+"images/rose_pion.png"
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
                            socket.send({type:"change_colour",colour:"Pink"})
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
                        source: "images/bleu_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: src+"images/bleu_pion.png"
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
                            socket.send({type:"change_colour",colour:"Blue"})
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
                        source: "images/rouge_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: src+"images/rouge_pion.png"
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
                            socket.send({type:"change_colour",colour:"Red"})
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
                        source: "images/blanc_icone.png"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    BorderImage {
                        y: 134
                        width: 100
                        height: 100
                        source: src+"images/blanc_pion.png"
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



