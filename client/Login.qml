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

	Column {
		spacing: 10
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter

		BorderImage {
			width: 270 * 2
			height: 115 * 2
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
