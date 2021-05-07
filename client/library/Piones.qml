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
		window.parent.state.changePosCerbere(0)
		
		for(var i = 0; i < players.length; i++){
			switch(players[i].colour) {
				case "Cyan":
					player1.visible = true
					window.parent.state.changePosition("Cyan", 1)
					break
				case "Orange":
					player2.visible = true
					window.parent.state.changePosition("Orange", 1)
					break
				case "Green":
					player3.visible = true
					window.parent.state.changePosition("Green", 1)
					break
				case "White":
					player4.visible = true
					window.parent.state.changePosition("White", 1)
					break
				case "Pink":
					player5.visible = true
					window.parent.state.changePosition("Pink", 1)
					break
				case "Blue":
					player6.visible = true
					window.parent.state.changePosition("Blue", 1)
					break
				case "Red":
					player7.visible = true
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
		xOffset: 0.25
		yOffset: 0.0
		heightRatio: 0.50
		widthRatio: 1.00
		imgPionId.source: src+"images/Cerbere_pion.png"
	}
	
	Pion {
		id: player1
		xOffset: 0.0
		yOffset: 0.0
		imgPionId.source: src+"images/Cyan_pion.png"
	}
	
	Pion {
		id: player2
		xOffset: 0.0
		yOffset: 0.25
		imgPionId.source: src+"images/Orange_pion.png"
	}
	
	Pion {
		id: player3
		xOffset: 0.0
		yOffset: 0.50
		imgPionId.source: src+"images/Green_pion.png"
	}
	
	Pion {
		id: player4
		xOffset: 0.0
		yOffset: 0.75
		imgPionId.source: src+"images/White_pion.png" 
	}
	
	Pion {
		id: player5
		xOffset: 0.50
		yOffset: 0.125
		imgPionId.source: src+"images/Pink_pion.png"
	}
		
	Pion {
		id: player6
		xOffset: 0.25
		yOffset: 0.375
		imgPionId.source: src+"images/Blue_pion.png"
	}
	
	Pion {
		id: player7
		xOffset: 0.25
		yOffset: 0.625
		imgPionId.source: src+"images/Red_pion.png"
	}
}