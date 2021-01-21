import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

ApplicationWindow {
	id: app

	minimumWidth: 800
	minimumHeight: 400

	WebSocket {
		id: socket

		property bool waiting4Connect: false
		property string login: ""

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
				payload: JSON.stringify({login: socket.login})
				}))
			}
		}
		
		onTextMessageReceived: {
			console.log(message)
			loader.push("Game.qml")
		}
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
}
