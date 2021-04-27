import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtGraphicalEffects 1.10
import QtQuick.Controls 2.10
import "movePions.js" as MovePions

Rectangle {
	id: playersId
	
	property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL
	
	function receiveCounterPiones(newPosition, playerColor) {
		MovePions.movePlayer(newPosition, MovePions.choosePlayer(playerColor))
	}
	
	function unhideNonPlayerPieces(players) {  
		cerbere.visible = true             
		receiveCounterPiones(0, "Black")
		window.parent.state.changePosCerbere("Black", 0)
		
		for(var i = 0; i < players.length; i++){
			switch(players[i].colour) {
				case "Cyan":
					player1.visible = true
					receiveCounterPiones(1, "Cyan")
					window.parent.state.changePosition("Cyan", 1)
					break
				case "Orange":
					player2.visible = true
					receiveCounterPiones(1, "Orange")
					window.parent.state.changePosition("Orange", 1)
					break
				case "Green":
					player3.visible = true
					receiveCounterPiones(1, "Green")
					window.parent.state.changePosition("Green", 1)
					break
				case "White":
					player4.visible = true
					receiveCounterPiones(1, "White")
					window.parent.state.changePosition("White", 1)
					break
				case "Pink":
					player5.visible = true
					receiveCounterPiones(1, "Pink")
					window.parent.state.changePosition("Pink", 1)
					break
				case "Blue":
					player6.visible = true
					receiveCounterPiones(1, "Blue")
					window.parent.state.changePosition("Blue", 1)
					break
				case "Red":
					player7.visible = true
					receiveCounterPiones(1, "Red")
					window.parent.state.changePosition("Red", 1)
					break
				default:
					break
			}
		}
	}
	
	function hidePlayerPiece(player_color) {
		switch(player_color) {
			case "Cyan":
				player1.visible = false
				break
			case "Orange":
				player2.visible = false
				break
			case "Green":
				player3.visible = false
				break
			case "White":
				player4.visible = false
				break
			case "Pink":
				player5.visible = false
				break
			case "Blue":
				player6.visible = false
				break
			case "Red":
				player7.visible = false
				break
			default:
				break
		}
	}
	
	Pion {
		id: cerbere
		width: 50
		height: 50
		imgPionId.source: src+"images/Cerbere_pion.png"
	}
	
	Pion {
		id: player1
		imgPionId.source: src+"images/Cyan_pion.png"
	}
	
	Pion {
		id: player2
		imgPionId.source: src+"images/Orange_pion.png"
	}
	
	Pion {
		id: player3
		imgPionId.source: src+"images/Green_pion.png"
	}
	
	Pion {
		id: player4
		imgPionId.source: src+"images/White_pion.png" 
	}
	
	Pion {
		id: player5
		imgPionId.source: src+"images/Pink_pion.png"
	}
		
	Pion {
		id: player6
		imgPionId.source: src+"images/Blue_pion.png"
	}
	
	Pion {
		id: player7
		imgPionId.source: src+"images/Red_pion.png"
	}
}