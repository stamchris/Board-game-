import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0
import QtQuick.VirtualKeyboard 2.2

ApplicationWindow {
	id: app

	minimumWidth: 800
	minimumHeight: 400
	
	visible: true
	WebSocket {
		id: socket

		property bool waiting4Connect: false
		property string login: ""
		
		function send(message) {
			socket.sendTextMessage(JSON.stringify(message))
		}

		function switchMessage(message) {
			switch(message.type) {
				case "newPlayer":
					game.players.push(message.player)
					game.players = game.players
					//Used to update the var status
					break
				case "welcome":
					game.players = message.players
					game.visible = true
					loader.push(game)
					break
				case "starter":
					game.view = "Board"
					break
				case "updatePlayer":
					game.players = game.players.map( player =>
						(player.name==message.player.name) ?
							message.player
						:
							player
						)
					break
			}
		}

		function connect(serveur, login) {
			socket.url = "ws://" + serveur
			socket.active = true

			socket.waiting4Connect = true
			socket.login = login
		}

		onStatusChanged: {
			console.log(status)
			if (status == WebSocket.Error) {
				console.log(socket.errorString)
			}
			if (status == WebSocket.Open && socket.waiting4Connect) {
				socket.sendTextMessage(JSON.stringify({
				type: "login",
				name:socket.login
				}))
			}
		}
		
		onTextMessageReceived: {
			console.log(message)
			switchMessage(JSON.parse(message))
		}
	}

	MouseArea {
		anchors.fill: parent

		onClicked: virtualKeyboard.visible = false
	}

	StackView {
		id: loader
		anchors.fill: parent

		popEnter: Transition {
			PropertyAnimation{
				property: "opacity"
				from: 0
				to: 1
				duration: 300
			}
		}

		popExit: Transition {
			PropertyAnimation{
				property: "opacity"
				from: 1
				to: 0
				duration: 250
			}
		}

		initialItem: "Login.qml"
	}

	Game {
		id: game
		visible: false
	}

	InputPanel {
		id: virtualKeyboard
		visible: false
		anchors.bottom: parent.bottom
		width: parent.width
		y: parent.height
	}
}
