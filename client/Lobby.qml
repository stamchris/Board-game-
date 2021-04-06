import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

Item {

        Rectangle {
            id: wrap_container
            anchors.fill: parent

            BorderImage {
                id: background
                source: "images/background_image.jpg"
                anchors.fill:parent
            }


        }

        property Gradient bcolor: Gradient {
            GradientStop { position: 0; color: "#f58226" }
            GradientStop { position: 0.09; color: "#ffbb4c" }
            GradientStop { position: 0.36; color: "#ffffde" }
    }

        ColumnLayout {
            anchors{bottom: wrap_container.bottom;right: wrap_container.right;bottomMargin: 5;rightMargin: 5}
            height: 200
            width: 200

            ListView {
                id:listView
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: game.players
                verticalLayoutDirection: ListView.BottomToTop

                    delegate:Rectangle {
                        id: rectaId
                        width: listView.width
                        height: userText.implicitHeight + 10
                        color: "#D7BDE2"
                        opacity: 0.6
                        radius:1

                        Text {
                            id:userText
                            width: parent.width
                            horizontalAlignment: Text.AlignHCenter
                            color:if (modelData.colour === "Cyan")
                                        userText.color = "#5DADE2"
                                    else
                                        userText.color = modelData.colour
                            text: modelData.name + " est connecté"
                            font.pointSize: 12
                            font.family: "Stoneyard"
                        }
                    }
            }
        }


        GridLayout {
            id:gridLayout
            height: parent.height*0.7
            width: parent.width *0.8
            anchors{horizontalCenter: wrap_container.horizontalCenter;top: wrap_container.top}
            columns: 7
            columnSpacing: 10
            rowSpacing: 10

                    BorderImage {
                        id:logo
                        width: 300
                        height: width/2
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: if(gridLayout.height<650||gridLayout.width<950){350} else{450}
                        Layout.maximumHeight: if(gridLayout.height<650||gridLayout.width<950){200} else{300}
                        source: "images/cerbere_logo.png"
                        Layout.columnSpan: 7
                        Layout.alignment: Qt.AlignCenter
                        Layout.leftMargin: 200
                        Layout.rightMargin: 200

                    }
                    Rectangle{
                        id:empty1
                        Layout.fillWidth: true
                        Layout.minimumHeight: 30
                        Layout.rightMargin: -50
                        Layout.columnSpan: 3
                        color: "transparent"
                    }

                    Text{
                        id:bigText
                        text : "Choix des joueurs :"
                        font.pointSize: 24
                        font.family: "Stoneyard"
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: 40
                        Layout.maximumHeight: 30
                        Layout.columnSpan: 2
                        Layout.alignment: Qt.AlignLeft
                        Layout.leftMargin: -60

                    }

                    Rectangle{
                        id:empty2
                        Layout.fillWidth: true
                        Layout.columnSpan: 2
                        Layout.minimumHeight: 30
                        Layout.leftMargin: 30
                        color: "transparent"
                    }


                    BorderImage {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: 150
                        Layout.maximumHeight: 150
                        Layout.alignment: Qt.AlignRight
                        source: "images/cyan_icone.png"
                    }
                    BorderImage {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: 150
                        Layout.maximumHeight: 150
                        Layout.alignment: Qt.AlignCenter
                        source: "images/bleu_icone.png"
                    }
                    BorderImage {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: 150
                        Layout.maximumHeight: 150
                        Layout.alignment: Qt.AlignCenter
                        source: "images/rose_icone.png"
                    }
                    BorderImage {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: 150
                        Layout.maximumHeight: 150
                        Layout.alignment: Qt.AlignCenter
                        source: "images/vert_icone.png"
                    }
                    BorderImage {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: 150
                        Layout.maximumHeight: 150
                        Layout.alignment: Qt.AlignCenter
                        source: "images/blanc_icone.png"
                    }
                    BorderImage {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: 150
                        Layout.maximumHeight: 150
                        Layout.alignment: Qt.AlignCenter
                        source: "images/rouge_icone.png"
                    }
                    BorderImage {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth: 150
                        Layout.maximumHeight: 150
                        Layout.alignment: Qt.AlignLeft
                        source: "images/orange_icone.png"
                    }

                    // Pions
                    Button {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {70}else{100}
                        Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {70}else{100}
                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: 20
                        background:

                        Rectangle{
                                id:rec1
                                height: parent.height*1.5
                                width: parent.width*1.5
                                anchors{centerIn: parent}
                                radius:80
                                color: "transparent"

                                BorderImage {
                                anchors.centerIn: parent
                                height: parent.height/1.5
                                width: parent.width/1.5
                                source: "images/cyan_pion.png"
                                rotation: -90
                                }


                                    MouseArea{
                                        anchors.fill:parent
                                            hoverEnabled: true
                                            onHoveredChanged: {
                                                if (hoverEnabled == true) {
                                                if (containsMouse == true) {
                                                    rec1.color = "#f0f0d3"
                                                } else {
                                                    rec1.color = "transparent"
                                                        }
                                                }
                                            }
                                        onClicked: {
                                            socket.send({type:"change_colour",colour:"Cyan"})
                                        }
                                    }


                        }   
                    }
                    Button {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {70}else{100}
                        Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {70}else{100}
                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: 20

                        background: Rectangle{
                            id:rec2
                            height: parent.height*1.5
                            width: parent.width*1.5
                            anchors{centerIn: parent}
                            radius:80
                            color: "transparent"


                            BorderImage {
                            anchors.centerIn: parent
                            height: parent.height/1.5
                            width: parent.width/1.5
                            source: "images/belu_pion.png"
                            rotation: -90
                            }


                            MouseArea{
                                anchors.fill:parent
                                hoverEnabled: true
                                onHoveredChanged: {
                                    if (hoverEnabled == true) {
                                        if (containsMouse == true) {
                                           rec2.color = "#f0f0d3"
                                        } else {
                                            rec2.color = "transparent"
                                        }
                                    }
                                }
                                onClicked: {
                                    socket.send({type:"change_colour",colour:"Blue"})
                                }
                            }
                        }

                    }





                    Button {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {70}else{100}
                        Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {70}else{100}
                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: 20

                        background: Rectangle{
                            id:rec3
                            height: parent.height*1.5
                            width: parent.width*1.5
                            anchors{centerIn: parent}
                            radius:80
                            color: "transparent"

                            BorderImage {
                            anchors.centerIn: parent
                            height: parent.height/1.5
                            width: parent.width/1.5
                            source: "images/rose_pion.png"
                            rotation: -90
                            }
                            MouseArea{
                                anchors.fill:parent
                                hoverEnabled: true
                                onHoveredChanged: {
                                    if (hoverEnabled == true) {
                                        if (containsMouse == true) {
                                            rec3.color = "#f0f0d3"

                                        } else {
                                            rec3.color = "transparent"
                                        }
                                    }
                                }
                                onClicked: {
                                    socket.send({type:"change_colour",colour:"Pink"})
                                }
                            }
                            }

                    }

                    Button {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {70}else{100}
                        Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {70}else{100}
                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: 20

                        background: Rectangle{
                            id:rec4
                            height: parent.height*1.5
                            width: parent.width*1.5
                            anchors{centerIn: parent}
                            radius:80
                            color: "transparent"

                            BorderImage {
                            anchors.centerIn: parent
                            height: parent.height/1.5
                            width: parent.width/1.5
                            source: "images/vert_pion.png"
                            rotation: -90
                            }


                            MouseArea{
                                anchors.fill:parent
                                hoverEnabled: true
                                onHoveredChanged: {
                                    if (hoverEnabled == true) {
                                        if (containsMouse == true) {
                                            rec4.color = "#f0f0d3"

                                        } else {
                                            rec4.color = "transparent"
                                        }
                                    }
                                }
                                onClicked: {
                                    socket.send({type:"change_colour",colour:"Green"})
                                }
                            }
                        }

                    }

                    Button {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {70}else{100}
                        Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {70}else{100}
                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: 20

                        background: Rectangle{
                            id:rec5
                            height: parent.height*1.5
                            width: parent.width*1.5
                            anchors{centerIn: parent}
                            radius:80
                            color: "transparent"

                            BorderImage {
                            anchors.centerIn: parent
                            height: parent.height/1.5
                            width: parent.width/1.5
                            source: "images/blanc_pion.png"
                            rotation: -90
                            }


                            MouseArea{
                                anchors.fill:parent
                                hoverEnabled: true
                                onHoveredChanged: {
                                    if (hoverEnabled == true) {
                                        if (containsMouse == true) {
                                           rec5.color = "#f0f0d3"

                                        } else {
                                            rec5.color = "transparent"
                                        }
                                    }
                                }
                                onClicked: {
                                    socket.send({type:"change_colour",colour:"White"})
                                }
                            }
                        }

                    }
                    Button {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {70}else{100}
                        Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {70}else{100}
                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: 20

                        background: Rectangle{
                            id:rec6
                            height: parent.height*1.5
                            width: parent.width*1.5
                            anchors{centerIn: parent}
                            radius:80
                            color: "transparent"

                            BorderImage {
                            anchors.centerIn: parent
                            height: parent.height/1.5
                            width: parent.width/1.5
                            source: "images/rouge_pion.png"
                            rotation: -90
                            }


                            MouseArea{
                                anchors.fill:parent
                                hoverEnabled: true
                                onHoveredChanged: {
                                    if (hoverEnabled == true) {
                                        if (containsMouse == true) {
                                            rec6.color = "#f0f0d3"
                                        } else {
                                            rec6.color = "transparent"
                                        }
                                    }
                                }
                                onClicked: {
                                    socket.send({type:"change_colour",colour:"Red"})
                                }
                            }
                        }

                    }
                    Button {
                        width: 100
                        height: width
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {70}else{100}
                        Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {70}else{100}
                        Layout.alignment: Qt.AlignCenter
                        Layout.topMargin: 20

                        background: Rectangle{
                            id:rec7
                            height: parent.height*1.5
                            width: parent.width*1.5
                            anchors{centerIn: parent}
                            radius:80
                            color: "transparent"

                            BorderImage {
                            anchors.centerIn: parent
                            height: parent.height/1.5
                            width: parent.width/1.5
                            source: "images/orange_pion.png"
                            rotation: -90
                            }


                            MouseArea{
                                anchors.fill:parent
                                hoverEnabled: true
                                onHoveredChanged: {
                                    if (hoverEnabled == true) {
                                        if (containsMouse == true) {
                                            rec7.color = "#f0f0d3"

                                        } else {
                                            rec7.color = "transparent"
                                        }
                                    }
                                }
                                onClicked: {
                                    socket.send({type:"change_colour",colour:"Orange"})
                                }
                            }
                        }

                    }
        }
                    // Buttons



//                    Button {
//                        text : "Blue"
//                        font.pointSize: 12
//                        font.family: "Stoneyard"
//                        anchors.horizontalCenter: parent.horizontalCenter

//                        background: Rectangle {
//                            color: "Blue"
//                            border.color: "black"
//                        }

//                        onClicked: {
//                            socket.send({type:"change_colour",colour:"Blue"})
//                        }
//                    }

//                    Button {
//                        text : "Pink"
//                        font.pointSize: 12
//                        font.family: "Stoneyard"
//                        anchors.horizontalCenter: parent.horizontalCenter

//                        background: Rectangle {
//                            color: "Pink"
//                            border.color: "black"
//                        }

//                        onClicked: {
//                            socket.send({type:"change_colour",colour:"Pink"})
//                        }
//                    }

//                    Button {
//                        text : "Green"
//                        font.pointSize: 12
//                        font.family: "Stoneyard"
//                        anchors.horizontalCenter: parent.horizontalCenter

//                        background: Rectangle {
//                            color: "Green"
//                            border.color: "black"
//                        }

//                        onClicked: {
//                            socket.send({type:"change_colour",colour:"Green"})
//                        }
//                    }

//                    Button {
//                        text : "White"
//                        font.pointSize: 12
//                        font.family: "Stoneyard"
//                        anchors.horizontalCenter: parent.horizontalCenter

//                        background: Rectangle {
//                            color: "White"
//                            border.color: "black"
//                        }

//                        onClicked: {
//                            socket.send({type:"change_colour",colour:"White"})
//                        }
//                    }

//                    Button {
//                        text : "Red"
//                        font.pointSize: 12
//                        font.family: "Stoneyard"
//                        anchors.horizontalCenter: parent.horizontalCenter

//                        background: Rectangle {
//                            color: "Red"
//                            border.color: "black"
//                        }

//                        onClicked: {
//                            socket.send({type:"change_colour",colour:"Red"})
//                        }
//                    }
//                    Button {
//                        text : "Orange"
//                        font.pointSize: 12
//                        font.family: "Stoneyard"
//                        anchors.horizontalCenter: parent.horizontalCenter

//                        background: Rectangle {
//                            color: "Orange"
//                            border.color: "black"
//                            height: 1/4*parent.height
//                        }

//                        onClicked: {
//                            socket.send({type:"change_colour",colour:"Orange"})
//                        }
//                    }



        CheckBox {
            anchors{horizontalCenter: parent.horizontalCenter;top:gridLayout.bottom;topMargin: 20}
            text : "Je suis prêt !"
            font.pointSize: 20
            font.family: "Stoneyard"
            onClicked : {
                socket.send({type: "ready"})
            }
        }

        Chat {
            width: wrap_container.width/4
            height: wrap_container.height*0.25
            anchors{bottom: wrap_container.bottom;left: wrap_container.left}
        }


}



