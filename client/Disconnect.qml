import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Button {
	background: Rectangle {
		id:decbutton
		radius:5
		height: 40
		width: textdeco.width + 40
		color: configD.hoverEnabled && configD.containsMouse ? "#27AE60" : "white"

		Text {
			id:textdeco
			text: ("Déconnexion")
			font.pointSize: 14
			color: configD.hoverEnabled && configD.containsMouse ? "white" : "black"
			font.family: "Stoneyard"
			anchors.centerIn: parent
		}

		MouseArea{
			id:configD
			anchors.fill:parent
			enabled: true
			hoverEnabled: true
			onClicked: socket.send({type:"warnDisconnect"})
		}
	}
}