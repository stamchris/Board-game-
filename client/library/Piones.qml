import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import "movePions.js" as MovePions

Rectangle {
    Row {
        id: playersId
        x: 5
        spacing: 2

        //[counter of pions]
        property variant yArray: [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1]
        property variant xArray: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        property variant xCounter: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

        function receiveCounterPiones(count, player){
            console.log("Player : " + player + " is in the case : " + count)
            MovePions.fixYArray(yArray, count)
            MovePions.fixXCounter(xCounter, count)
            MovePions.fixXArray(xArray,xCounter, count)
            MovePions.findYposition(count, MovePions.choosePlayer(player), yArray)
            MovePions.findXposition(count, MovePions.choosePlayer(player), xArray)
        }

        Pion {
            id: player1
            color: "white"
            visible: true
            yPosition: 0
            xPosition: 5
            
        }

        Pion {
            id: player2
            color: "gray"
            yPosition: 0
            xPosition: 5

            Image {
                anchors.fill : parent
                source : "../images/belu_pion.png"
            }
        }

        Pion {
            id: player3
            color: "gray"
            yPosition: 0
            xPosition: 5

            Image {
                anchors.fill : parent
                source : "../images/rouge_pion.png"
            }
        }

        Pion {
            id: player4
            yPosition: 0
            color : "gray"
            xPosition: 5

            Image {
                anchors.fill : parent
                source : "../images/rose_pion.png"
            }
        }

        Pion {
            id: player5
            yPosition: 0
            color : "gray"
            xPosition: 5

            Image {
                anchors.fill : parent
                source : "../images/vert_pion.png"
            }
        }

        Pion {
            id: player6
            yPosition: 0
            color : "gray"
            xPosition: 5

            Image {
                anchors.fill : parent
                source : "../images/orange_pion.png"
            }
        }

        Pion {
            id: player7
            yPosition: 0
            color : "gray"
            xPosition: 5

            Image {
                anchors.fill : parent
                source : "../images/cyan_pion.png"
            }
        }
    }
}
