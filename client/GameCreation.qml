import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick 2.14

Item {
	property int difficulty: 3
	property int maxPlayers: 3
	property string boardType: "default"
	property bool teamChat: false // not bound in its widget, careful

    Rectangle {
        id: wrap_container
        anchors.fill: parent

        BorderImage {
            id: background
            source: "images/background_image.jpg"
            anchors.fill:parent
        }
    }
	
	RowLayout {
		anchors.fill: parent
		Button {
			anchors.top: parent.top
			anchors.left: parent.left
			text: "Lobby"
			onClicked: loader.pop()
		}

		// FIXME: split each single option in its own widget
		ColumnLayout {
			id: leftColumn
			Layout.fillWidth: true

			Rectangle {
				color: "blue"
				anchors.fill: parent
			}

			LobbyOption {
				label: "Difficulty"

				RowLayout {
					Button {
						text: "*"
						checked: difficulty == 3
						onClicked: difficulty = 3
						font.family: "Noto Emoji"
						Layout.fillWidth: true
					}

					Button {
						text: "**"
						checked: difficulty == 4
						onClicked: difficulty = 4
						font.family: "Noto Emoji"
						Layout.fillWidth: true
					}

					Button {
						text: "***"
						checked: difficulty == 5
						onClicked: difficulty = 5
						font.family: "Noto Emoji"
						Layout.fillWidth: true
					}

					Button {
						text: "****"
						checked : difficulty == 6
						onClicked: difficulty = 6
						font.family: "Noto Emoji"
						Layout.fillWidth: true
					}
				}
			}

			LobbyOption {
				label: "Max. Players"

				SpinBox {
					value: maxPlayers
					from: 3
					to: 7

					onValueChanged: maxPlayers = value
					Layout.fillWidth: true
				}
			}
			
			/*
			LobbyOption {
				label: "Board"

				RowLayout {
					Layout.fillWidth: true
					Button {
						text: "1"
						checked: boardType == "default"
						onClicked: boardType = "default"
						font.family: "Noto Emoji"
						Layout.fillWidth: true
					}

					Button {
						text: "2"
						checked: boardType == "fire"
						onClicked: boardType = "fire"
						font.family: "Noto Emoji"
						Layout.fillWidth: true
					}

					Button {
						text: "3"
						checked: boardType == "skull"
						onClicked: boardType = "skull"
						font.family: "Noto Emoji"
						Layout.fillWidth: true
					}
				}
			}
			*/

			LobbyOption {
				label: "Team Chat"

				Button {
					text: if (teamChat)
						"v"
					else
						"x"
					checkable: true
					onCheckedChanged: teamChat = checked
				}
			}

			Button {
				id: submit
				text: "Configurer"
				onClicked: socket.send({type: "game_config", difficulty:difficulty, maxPlayers:maxPlayers})
			}
		}

		UsersView {
			width: 300
			Layout.fillWidth: true
			height: leftColumn.height
			users: game.players
			showKickButtons: true
			gameOwnerLogin: "???"

			onKickClicked: console.log("unimplemented: kick clicked for " + user.login)
		}
	}
}
