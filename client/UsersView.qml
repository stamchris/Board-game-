import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick 2.14

ListView {
	id: widget
	property var users: [
		{
			"login": "???",
			"colour": "salmon"
		},
		{
			"login": "???",
			"colour": "turquoise"
		},
		{
			"login": "???",
			"colour": "teal"
		}
	]

	property var gameOwnerLogin: undefined
	property var showKickButtons: false

	signal kickClicked(string login)

	model: users
	clip: true

	Component {
		id: crownButton

		Button {
			width: 32
			text: "^^^"
			font.family: "Noto Emoji"
		}
	}

	Component {
		id: kickButton
		
		Button {
			height: 28
			width: 32
			text: "X"
			font.family: "Noto Emoji"
		}
	}

	delegate: RowLayout {
		spacing: 15
		Text {
			Layout.minimumHeight: 40
			Layout.fillWidth: true
			text: modelData.name
			font.pointSize: 15
			font.family: "Stoneyard"
			style: Text.Outline
			color: "#FFF8E4"
			styleColor: modelData.colour
			leftPadding: 10
			Layout.alignment: Qt.AlignCenter
		}

		Loader {
			sourceComponent: if (modelData.login == gameOwnerLogin)
				crownButton
			Layout.alignment: Qt.AlignTop
		}

		Loader {
			id: kickLoader
			sourceComponent: if (showKickButtons)
				kickButton
			Layout.alignment: Qt.AlignTop
		}
		
		Connections {target: kickLoader.item
			function onClicked(mouse) {
				kickClicked(modelData.name)
			}
		}
	}
}

