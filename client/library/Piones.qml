import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import "movePions.js" as MovePions

Rectangle {
	Row  {
		id: playersId
		x: 5
		spacing: 2
		
		property variant yArray: [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
		property variant xArray: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
		property variant xCounter: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
		
		property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL
		
		function receiveCounterPiones(count, playerColor) {
			MovePions.fixYArray(yArray, count)
			MovePions.fixXCounter(xCounter, count)
			MovePions.fixXArray(xArray, xCounter, count)
			MovePions.findYposition(count, MovePions.choosePlayer(playerColor), yArray)
			MovePions.findXposition(count, MovePions.choosePlayer(playerColor), xArray)
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
			visible: false
			yPosition: 0
			xPosition: 5
			width : 45
			height : 45
			color: "transparent"
			
			Image {
				anchors.fill : parent
				source : src+"images/Cerbere_pion.png"
			}  
		}
		
		Pion {
			id: player1
			visible: false
			yPosition: 0
			xPosition: 5
			color: "transparent"
			
			Image {
				anchors.fill: parent
				source: src+"images/Cyan_pion.png"
			}
		}
		
		Pion {
			id: player2
			visible: false
			yPosition: 0
			xPosition: 5
			color: "transparent"
			
			Image {
				anchors.fill: parent
				source: src+"images/Orange_pion.png"
			}
		}
		
		Pion {
			id: player3
			visible: false
			yPosition: 0
			xPosition: 5
			color: "transparent"
			
			Image {
				anchors.fill: parent
				source: src+"images/Green_pion.png"
			}
		}
		
		Pion {
			id: player4
			visible: false
			yPosition: 0
			xPosition: 5
			color: "transparent"
			
			Image {
				anchors.fill: parent
				source: src+"images/White_pion.png"
			}   
		}
		
		Pion {
			id: player5
			visible: false
			yPosition: 0
			xPosition: 5
			color: "transparent"
			
			Image {
				anchors.fill: parent
				source: src+"images/Pink_pion.png"
			}
		}
		
		
		Pion {
			id: player6
			visible: false
			yPosition: 0
			xPosition: 5
			color: "transparent"
			
			Image {
				anchors.fill: parent
				source: src+"images/Blue_pion.png"
			}
		}
		
		Pion {
			id: player7
			visible: false
			yPosition: 0
			xPosition: 5
			color: "transparent"
			
			Image {
				anchors.fill: parent
				source: src+"images/Red_pion.png"
			}
		}
	}
}
