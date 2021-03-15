import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import "movePions.js" as MovePions

Rectangle {
    Row  {
        id: playersId
        x: 5
        spacing: 2

        //[counter of pions]
        property variant yArray: [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1]
        property variant xArray: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        property variant xCounter: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

        function receiveCounterPiones(count, playerColor) {
            MovePions.fixYArray(yArray, count)
            MovePions.fixXCounter(xCounter, count)
            MovePions.fixXArray(xArray, xCounter, count)
            MovePions.findYposition(count, MovePions.choosePlayer(playerColor), yArray)
            MovePions.findXposition(count, MovePions.choosePlayer(playerColor), xArray)
        }

        function unhideNonPlayerPieces(players) {
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

        Pion {
            id: cerbere
            visible: true
            yPosition: 0
            xPosition: 5

            Image {
                anchors.fill : parent
                source : "../images/cerbere_pion.png"
            }  
        }

        Pion {
            id: player1
            visible: false
            yPosition: 0
            xPosition: 5

            Image {
                anchors.fill: parent
                source: "../images/cyan_pion.png"
            }
        }

        Pion {
            id: player2
            visible: false
            yPosition: 0
            xPosition: 5
        
            Image {
                anchors.fill: parent
                source: "../images/orange_pion.png"
            }
        }

        Pion {
            id: player3
            visible: false
            yPosition: 0
            xPosition: 5
            
            Image {
                anchors.fill: parent
                source: "../images/vert_pion.png"
            }
        }

        Pion {
            id: player4
            visible: false
            yPosition: 0
            xPosition: 5

            Image {
                anchors.fill: parent
                source: "../images/blanc_pion.png"
            }   
        }

        Pion {
            id: player5
            visible: false
            yPosition: 0
            xPosition: 5

            Image {
                anchors.fill: parent
                source: "../images/rose_pion.png"
            }
        }

        Pion {
            id: player6
            visible: false
            yPosition: 0
            xPosition: 5

            Image {
                anchors.fill: parent
                source: "../images/belu_pion.png"
            }
        }

        Pion {
            id: player7
            visible: false
            yPosition: 0
            xPosition: 5

            Image {
                anchors.fill: parent
                source: "../images/rouge_pion.png"
            }
        }
    }
}
