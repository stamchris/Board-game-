import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0


Rectangle{
    property alias msgText: message.text

        id:rectRoot
        width: parent.width /3
        height: parent.height/7
        opacity: 0.7
        color: "#566573"
        visible:false
        radius: 10
        anchors {top: parent.top;horizontalCenter: parent.horizontalCenter}

        Text {
            id: message
            anchors{fill:parent}
            font.weight: Font.Black
            font.pixelSize: parent.width /6
            color: "#CCD1D1"
            style: Text.Outline
            styleColor: "red"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: qsTr("Cerberus\nCheckpoint")
        }
}
