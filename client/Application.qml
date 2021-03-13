import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

ApplicationWindow {
	id: app
	minimumWidth: 1200
	minimumHeight: 540
	visible: true
	property alias game: game
	property alias socket: socket
	title : "Cerbere"

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
					break
				case "welcome":
					app.title = "Cerbere :" + login
					game.players = message.players
					game.visible = true
					loader.push(game)
					break
				case "starter":
					for (var i = 0; i < game.players.length; i++) {
						if (game.players[i].name == login) {
							game.state.changeLogin(game.players[i].name)
							game.state.changeColor(game.players[i].colour)
							break
						}
					}
					game.state.initGame(message.players, message.difficulty)
					game.view = "Board"
					break
				case "updatePlayer":
					for (var i = 0; i < game.players.length; i++) {
						if (game.players[i].name == message.player.name) {
							game.players[i] = message.player
							break
						}
					}
					game.players = game.players
					break
				case "updatePosition":
					game.state.changePosition(message.player.colour, message.player.position)
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

	StackView {
		id: loader
		anchors.fill: parent

		popEnter: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 0
				to: 1
				duration: 300
			}
		}

		popExit: Transition {
			PropertyAnimation {
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
		property alias state: state

		GameState {
			id: state
			
			function send(message) {
				app.socket.send(message)
			}
		}
	}
}
