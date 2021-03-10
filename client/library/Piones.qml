import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import "movePions.js" as MovePions

Column {
    id: playersId
    x: 5
    spacing: 2

    //[counter of pions]
    property variant yArray: [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,1,1]
    property variant xArray: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    property variant xCounter: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

    function receiveCounterPiones(count, player) {
        MovePions.fixYArray(yArray, count)
        MovePions.fixXCounter(xCounter, count)
        MovePions.fixXArray(xArray,xCounter, count)
        MovePions.findYposition(count, MovePions.choosePlayer(player), yArray)
        MovePions.findXposition(count, MovePions.choosePlayer(player), xArray)
    }

    Pion {
        id: player1
        color: "Cyan"
        visible: true
        yPosition: 0
        xPosition: 5
    }

    Pion {
        id: player2
        color: "Orange"
        yPosition: 0
        xPosition: 5
    }

    Pion {
          id: player3
          color: "Green"
          yPosition: 0
          xPosition: 5
    }

    Pion {
        id: player4
        color: "White"
        yPosition: 0
        xPosition: 5
    }

    Pion {
        id: player5
        color: "Pink"
        yPosition: 0
        xPosition: 5
    }

    Pion {
        id: player6
        color: "Blue"
        yPosition: 0
        xPosition: 5
    }

    Pion {
        id: player7
        color: "Red"
        yPosition: 0
        xPosition: 5
    }
}
