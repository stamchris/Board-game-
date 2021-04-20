import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick 2.14

ListView {
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
			width: 32
			text: "X"
			font.family: "Noto Emoji"
		}
	}

	delegate: RowLayout {
		Layout.fillWidth: true
		Text {
			Layout.fillWidth: true
			color: modelData.colour
			text: modelData.name + " est connecté"
			font.pointSize: 12
			font.family: "Stoneyard"
            Layout.alignment: Qt.AlignHCenter
		}

		Loader {
			sourceComponent: if (modelData.login == gameOwnerLogin)
				crownButton
		}

		Loader {
			sourceComponent: if (showKickButtons)
				kickButton
		}
	}
}

