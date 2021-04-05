import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

Item {

    //visible: false

    Rectangle {
        id: rectangle
        x: 0
        y: 0
        width: parent.width
        height: parent.height
        color: "#ffffde"

    }

    ColumnLayout {

        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: 0
        anchors.horizontalCenterOffset: 0
        //y:150

        BorderImage {
            width: 270
            height: 115
            source: "images/cerbere_logo.png"
            anchors.horizontalCenter: parent.horizontalCenter

        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Serveur :"
            font.pointSize: 12
            font.family: "Stoneyard"
        }
        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 220
            id: serveurInput
            text: "localhost:3000"
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Pseudo :"
            font.pointSize: 12
            font.family: "Stoneyard"
        }
        TextField {
            anchors.horizontalCenter: parent.horizontalCenter
            width: 220
            id: loginInput
        }

        RoundButton {
            id: boutton_rond
            anchors.horizontalCenter: parent.horizontalCenter
            text: "     Go     "
            font.family: "Stoneyard"
            radius: 5
            width: 10
            height: 20


            onHoverEnabledChanged: boutton_rond.background.color = "grey"



            onClicked: socket.connect(serveurInput.text, loginInput.text)
        }

        Label {
            id: lStatus
            visible: true
        }

        Label {
            id: lMessage
            visible: false
        }


    }


}

