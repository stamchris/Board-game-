import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import "movePions.js" as MovePions

Column {
    id: playersId
    x: 5
    spacing: 2

    // Data from main button
    property int positionCounter: 0
    property string cpy_player: " "

    function receiveCounterPiones(count, player) {
        positionCounter = count
        cpy_player = player
        console.log("Player : " + player + " is in the case : " + count)
        MovePions.findYposition(count, MovePions.choosePlayer(player))
        MovePions.findXposition(count, MovePions.choosePlayer(player))
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
        color: "blue"
        yPosition: 0
        xPosition: 5
    }

    Pion {
          id: player3
          color: "red"
          yPosition: 0
          xPosition: 5
    }

    Pion {
        id: player4
        color: "pink"
        yPosition: 0
        xPosition: 5
    }

    Pion {
        id: player5
        color: "green"
        yPosition: 0
        xPosition: 5
    }

    Pion {
        id: player6
        color: "yellow"
        yPosition: 0
        xPosition: 5
    }

    Pion {
        id: player7
        color: "cyan"
        yPosition: 0
        xPosition: 5
    }
}
