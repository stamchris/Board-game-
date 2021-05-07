import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0


Rectangle {
	width: rowId.width/10
	height: rowId.height/7
	radius: 10
	color: "#AA000000"
	visible: false
	anchors.horizontalCenter: parent.horizontalCenter
	property alias msgText: message.text

	Text {
		id: message
		anchors.fill: parent
		fontSizeMode: Text.Fit
		color: "White"
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}
}
