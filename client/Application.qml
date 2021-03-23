import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0
import QtQuick.Window 2.12

ApplicationWindow {
	id: app
	width: 1600
	height: width/16*9
	visible: true
	property alias game: game
	property alias socket: socket
	title : "Cerbere"

	FontLoader {
		id: stoneyard
		source: "images/Stoneyard.ttf"
	}

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
					app.title = "Cerbere : " + login
					game.players = message.players
					game.visible = true
					game.rank = message.rank
					loader.push(game)
					break
				case "starter":
					for (var i = 0; i < game.players.length; i++) {
						if (game.players[i].name == login) {
							game.state.login = game.players[i].name
							game.state.color = game.players[i].colour
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
				case "updateBoard":
					for (var i = 0; i < game.players.length; i++) {
						if ((game.state.players[i].position != message.players[i].position)) {
							game.state.changePosition(message.players[i].colour, message.players[i].position)
						}
					}
					if (game.state.posCerbere != message.cerberepos) {
						game.state.changePosCerbere(message.cerberepos)
					}
					game.state.changePlayers(message.players, message.active_player)
					game.state.changeRage(message.rage)
					game.state.changeVitesse(message.vitesse)
					game.state.changePont(message.pont)
					game.board.popupBridge.close()
					game.board.popupPortal.close()
					game.board.playersChoice.close()
					game.board.popupChooseBarquesEffect.close()
					game.board.popupSwapBarques.close()
					game.board.popupSeeBarques.close()
					game.board.popupChooseCardsToDiscard.close()
					game.board.popupChooseOppoEffect.close()
					break
				case "newBonus":
					game.state.newBonus(message.cardname)
					break
				case "discardBonus":
					game.state.discardBonus(message.cardname)
					break
                case "useBridge":
                    game.state.useBridge(message.pontQueue)
                    break
				case "usePortal":
					game.state.usePortal(message.portalQueue)
					break
				case "chatResponse":
					game.addMessage(message.player, message.timestamp, message.message)
					break
				case "actionPlayed":
					game.state.lockCards("action")
					break
				case "bonusPlayed":
					game.state.lockCards("bonus")
					break
				case "gameConfigUpdated":
					console.log("Received config")
					break
				case "changeType":
					game.state.changeType(message.new_type)
					break
				case "swapBarque":
					game.state.showSwapBarque(message.barques)
					break
				case "revealBarque":
					game.state.showRevealBarque(message.barque)
					break
				case "awinner":
					game.state.showAWinner(message.plyr)
					break
				case "aloser":
					game.state.showALoser(message.plyr)
					break
				case "swinner":
					game.state.showSWinner(message.plyr)
					break
				case "sloser":
					game.state.showSLoser(message.plyr)
					break
				case "eliminate":
					game.state.showEliminate(message.plyr)
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

	Component.onCompleted: {
		if(NEEDS_VIRTUAL_KEYBOARD){
			Qt.createQmlObject("import QtQuick.VirtualKeyboard 2.2
			InputPanel {
				id: virtualKeyboard
				visible: active
				anchors.bottom: parent.bottom
				width: parent.width
				y: parent.height - height
			}", app, null);
		}
	}
}
