import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import "movePions.js" as MovePions

Column{
    id: playersId
    x:5
    spacing: 2

    //[counter of pions]
    property variant yArray: [-1,-1,-1,-1,-1]
    property variant xArray: [0,0,0,0,0]
    property variant xCounter: [0,0,0,0,0]

    function receiveCounterPiones(count,player){
        console.log("Player : "+ player+" is in the case : "+count)
        MovePions.fixYArray(yArray,count)
        MovePions.fixXCounter(xCounter,count)
        MovePions.fixXArray(xArray,xCounter,count)
        MovePions.findYposition(count,MovePions.choosePlayer(player),yArray)
        MovePions.findXposition(count,MovePions.choosePlayer(player),xArray)
    }




    Pion{
        id:player1
        color: "white"
        visible: true
        yPosition:0
        xPosition: 5
    }

    Pion{

        id:player2
        color: "blue"
        yPosition:0
        xPosition: 5

    }
    Pion{
          id:player3
          color:"red"
          yPosition:0
          xPosition: 5
    }
    Pion{
        id:player4
        color:"pink"
        yPosition:0
        xPosition: 5    }

    Pion{
        id:player5
        color:"green"
        yPosition:0
        xPosition: 5    }

    Pion{
        id:player6
        color:"yellow"
        yPosition:0
        xPosition: 5    }

    Pion{
        id:player7
        color:"cyan"
        yPosition:0
        xPosition: 5    }
}
