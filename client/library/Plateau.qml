import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0


Row {
    /////// Send data to Piones.qml from main.qml
    signal notifyPiones(string counter, string player) // Declare signal

    function receiveCounter(count,player) {
        notifyPiones(count,player)
    }

    Component.onCompleted: {
        notifyPiones.connect(pionesId.children[0].receiveCounterPiones) //connect button to Pion
    }
    //////////////////////////////////////////////

    id: rowId
    anchors.fill: parent

    Piones {
        id: pionesId
    }

    Rectangle {
        id: firstPlateauid
        width: parent.width*29/100
        color: "transparent"
        height: parent.height
        border.color: "red"
        border.width: 1


        ShowEffect{
            id:msg1
        }

        Row {
            id:rowFirstPlateauid
            width : parent.width
            height : parent.height
            x : 11
            spacing : 3

            Rectangle {
                id : case0Id
                width: 13/100* parent.width
                height: 30/100 * parent.height
                y: height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn0
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id : case1Id
                width: 13/100* parent.width
                height: 29/100 * parent.height
                y : 85/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onHoveredChanged:{
                        if(containsMouse == true)
                             {
                                msg1.msgText = "Cerberus\nCheckpoint"
                                msg1.visible = true
                             }
                        else
                            msg1.visible = false
                    }
                }

                Grid {
                    id:layoutPawn1
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id : case2Id
                width: 13/100* parent.width
                height: 40/100 *parent.height
                y : 70/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onHoveredChanged:{
                                        if(containsMouse == true)
                                             {
                                                msg1.msgText = "+2 Cartes de\nde Trahison"
                                                msg1.visible = true
                                             }
                                        else
                                            msg1.visible = false
                                    }
                                }

                Grid {
                    id:layoutPawn2
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id : case3Id
                width: 13/100* parent.width
                height: 32/100*parent.height
                y: 70/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onHoveredChanged:{
                        if(containsMouse == true)
                             {
                                 msg1.msgText = "+1 Carte de\n Survie"
                                 msg1.visible = true
                             }
                        else
                            msg1.visible = false
                    }
                }

                Grid {
                    id:layoutPawn3
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: case4Id
                width: 14/100* parent.width
                height: 32/100*parent.height
                y : 128/100 * height
                color: "transparent"
                border.color :"black"
                border.width: 1

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onHoveredChanged:{
                        if(containsMouse == true)
                             {
                                msg1.msgText = "Cerberus\nCheckpoint"
                                msg1.visible = true
                             }
                        else
                            msg1.visible = false
                    }
                }

                Grid {
                    id:layoutPawn4
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id:case5Id
                width: 13/100* parent.width
                height:33/100*parent.height
                y : 65/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn5
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id:case6Id
                width: 14/100* parent.width
                height:29/100*parent.height
                y : 138/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                MouseArea{
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onHoveredChanged:{
                                        if(containsMouse == true)
                                             {
                                                msg1.msgText = "+1 Carte de\nde Trahison"
                                                msg1.visible = true
                                             }
                                        else
                                            msg1.visible = false
                                    }
                                }

                Grid {
                    id:layoutPawn6
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
        }
    }
    Rectangle {
        id: secondPlateauid
        width: 17/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1

        ShowEffect{
            id:msg2
            width: parent.width /2.5
            height: parent.height/6
        }

        Row {
            id:rowSecondPlateauid
            anchors.fill : parent
            spacing : 2

            Rectangle {
                id : case7Id
                width: 22/100* parent.width
                height:25/100*parent.height
                y : 165/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged:{
                            if(containsMouse == true)
                                 {
                                    msg2.msgText = "Cerberus\nCheckpoint"
                                    msg2.visible = true
                                 }
                            else
                                msg2.visible = false
                        }
                    }

                Grid {
                    id:layoutPawn7
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Column {
                id : cases8_9id
                height: parent.height
                width: 27/100* parent.width
                y : 30/100*height
                spacing : 2/100*parent.height
                Rectangle {
                    id: case9Id
                    width: 65/100*parent.width
                    height : 18/100*parent.height
                    y : 108/100*height
                    x : 56/100*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn9
                        columns:2
                        spacing : 2
                        y : 1/5*parent.y
                    }
                }
                Rectangle {
                    id: case8Id
                    width: 85/100*parent.width
                    height: 25/100*parent.height
                    y : 97/100*height
                    x : 14/100*width
                    color: "transparent"
                    radius: 15
                    border.color :"black"
                    border.width: 1

                    MouseArea{
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onHoveredChanged:{
                                                if(containsMouse == true)
                                                {
                                                        msg2.msgText = "Si le joueur se pose\n sur la case bleu,\nil peut passer le pont"
                                                        msg2.width = thirdPlateauid.width /1.4
                                                        msg2.visible = true
                                                        case8Id.opacity = 0.25
                                                        case12Id.opacity = 0.25
                                                        case8Id.color = "cyan"
                                                        case12Id.color="cyan"
                                                }
                                                else
                                                {
                                                      msg2.visible = false
                                                      msg2.width = thirdPlateauid.width /2.2
                                                      case8Id.opacity = 1
                                                      case12Id.opacity = 1
                                                      case8Id.color="transparent"
                                                      case12Id.color="transparent"
                                                }
                                            }
                                        }

                    Grid {
                        id:layoutPawn8
                        columns:2
                        spacing : 2
                        y : 1/5*parent.y
                    }
                }
            }
            Rectangle {
                id: case10Id
                width: 19/100*parent.width
                height: 18/100*parent.height
                y : 103/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged:{
                            if(containsMouse == true)
                                 {
                                    msg2.msgText = "Cerberus\nCheckpoint"
                                    msg2.visible = true
                                 }
                            else
                                msg2.visible = false
                        }
                    }
                Grid {
                    id:layoutPawn10
                    columns:2
                    spacing : 2
                    y : 1/20*parent.y
                }
            }
            Column {
                id : cases11_12id
                height: parent.height
                width: 25/100* parent.width
                y : 27/100*height
                spacing : 2/100*parent.height
                Rectangle {
                    id: case11Id
                    width: 67/100*parent.width
                    height : 19/100*parent.height
                    y : 90/100*height
                    x : 13/100*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                    Grid {
                        id:layoutPawn11
                        columns:2
                        spacing : 2
                        y : parent.y
                    }
                }
                Rectangle {
                    id: case12Id
                    width: 70/100* parent.width
                    x : 40/100*width
                    height: 30/100* parent.height
                    color: "transparent"
                    radius: 18
                    border.color :"black"
                    border.width: 1


                    MouseArea{
                                            anchors.fill: parent
                                            hoverEnabled: true
                                            onHoveredChanged:{
                                                if(containsMouse == true)
                                                {
                                                        msg2.msgText = "Si le joueur se pose\n sur la case bleu,\nil peut passer le pont"
                                                        msg2.width = thirdPlateauid.width /1.4
                                                        msg2.visible = true
                                                        case8Id.opacity = 0.25
                                                        case12Id.opacity = 0.25
                                                        case8Id.color = "cyan"
                                                        case12Id.color="cyan"
                                                        case12Id.running = true
                                                }
                                                else
                                                {
                                                      msg2.visible = false
                                                      msg2.width = thirdPlateauid.width /2.2
                                                      case8Id.opacity = 0.1
                                                      case12Id.opacity = 0.1
                                                      case8Id.color="transparent"
                                                      case12Id.color="transparent"
                                                }
                                            }
                                        }


                    Grid {
                        id:layoutPawn12
                        columns:2
                        spacing : 2
                        y : 1/5*parent.y
                    }
                }
            }
        }
    }

    Rectangle {
        id: thirdPlateauid
        width: 20/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1

        ShowEffect{
            id:msg3
            width: parent.width /2.2
            height: parent.height/5.5
        }


        Row {
            id:rowThirdPlateauid
            width : parent.width
            height : parent.height
            x : 20
            spacing : 3

            Rectangle {
                id: case13Id
                width: 19/100*parent.width
                height : 30/100*parent.height
                y : 120/100*height
                x : 120/100*width
                color: "transparent"
                border.color :"black"
                border.width: 1

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onHoveredChanged:{
                                if(containsMouse == true)
                                     {
                                        msg3.msgText = "Cerberus\nCheckpoint"
                                        msg3.visible = true
                                     }
                                else
                                    msg3.visible = false
                            }
                        }

                Grid {
                    id:layoutPawn13
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }

            Column {
                id : cases14_15id
                height: 34/100*parent.height
                width: 29/100* parent.width
                y : 105/100*height
                spacing : 3/100*parent.height
                Rectangle {
                    id: case14Id
                    width: 55/100*parent.width
                    height: 80/100*parent.height
                    x : 40/100*width
                    color: "transparent"
                    opacity: 0.25
                    radius: 15
                    border.color :"black"
                    border.width: 1

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged:{
                            if(containsMouse == true)
                            {
                                    msg3.msgText = "Si le joueur se pose\n sur la case bleu,\nle portail ouvre"
                                    msg3.width = thirdPlateauid.width /1.6
                                    msg3.visible = true
                                    case16Id.color = "cyan"
                                    case17Id.color="red"
                                    case14Id.color="red"

                            }
                            else
                            {
                                msg3.visible = false
                                msg3.width = thirdPlateauid.width /2.2
                                case16Id.color="transparent"
                                case17Id.color="transparent"
                                case14Id.color="transparent"
                            }
                        }
                    }

                    Grid {
                        id:layoutPawn14
                        columns:2
                        spacing : 2
                        y : 1/5*parent.y
                    }
                }
                Rectangle {
                    id: case15Id
                    x: 65/100 * parent.x
                    width: 50/100* parent.width
                    height: 65/100* parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onHoveredChanged:{
                                if(containsMouse == true)
                                     {
                                        msg3.msgText = "Cerberus\nCheckpoint"
                                        msg3.visible = true
                                     }
                                else
                                    msg3.visible = false
                            }
                        }

                    Grid {
                        id:layoutPawn15
                        columns:2
                        spacing : 2
                    }
                }
            }

            Column {
                id : cases16_17id
                height: 33/100*parent.height
                width: 33/100* parent.width
                y : 99/100*height
                x : 105/100*width
                spacing : 3/100*parent.height
                Rectangle {
                    id: case17Id
                    x: 20/100 * parent.x
                    width: 60/100 * parent.width
                    height: 85/100*parent.height
                    color: "transparent"
                    opacity: 0.25
                    radius: 15
                    border.color :"black"
                    border.width: 1

                    MouseArea{
                        anchors.fill: case17Id
                        hoverEnabled: true
                        onHoveredChanged:{
                            if(containsMouse == true)
                            {
                                    msg3.msgText = "Si le joueur se pose\n sur la case bleu,\nle portail ouvre"
                                    msg3.width = thirdPlateauid.width /1.6
                                    msg3.visible = true
                                    case16Id.color = "cyan"
                                    case17Id.color="red"
                                    case14Id.color="red"

                            }
                            else
                            {
                                msg3.visible = false
                                msg3.width = thirdPlateauid.width /2.2
                                case16Id.color="transparent"
                                case17Id.color="transparent"
                                case14Id.color="transparent"
                            }
                        }
                    }
                    Grid {
                        id:layoutPawn17
                        columns:2
                        spacing : 2
                    }
                }
                Rectangle {
                    id: case16Id
                    width: 45/100* parent.width
                    height: 65/100* parent.height
                    color: "transparent"
                    opacity: 0.25
                    radius: 15
                    border.color :"black"
                    border.width: 1

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onHoveredChanged:{
                            if(containsMouse == true)
                            {
                                    msg3.msgText = "Si le joueur se pose\n sur la case bleu,\nle portail ouvre"
                                    msg3.width = thirdPlateauid.width /1.6
                                    msg3.visible = true
                                    case16Id.color = "cyan"
                                    case17Id.color="red"
                                    case14Id.color="red"

                            }
                            else
                            {
                                msg3.visible = false
                                msg3.width = thirdPlateauid.width /2.2
                                case16Id.color="transparent"
                                case17Id.color="transparent"
                                case14Id.color="transparent"
                            }
                        }
                    }

                    Grid {
                        id:layoutPawn16
                        columns:2
                        spacing : 2
                    }
                }
            }
        }
    }

    Rectangle {
        id: endPlateauId
        width: 34/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1

        ShowEffect{
            id:msg4
            width: parent.width /2.5
            height: parent.height/6
        }

        Row {
            id:rowEndPlateauid
            width : parent.width
            height : parent.height
            x : 8
            spacing : 4

            Rectangle {
                id: case18Id
                width: 10/100*parent.width
                height : 1/5*parent.height
                y : 188/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onHoveredChanged:{
                                if(containsMouse == true)
                                     {
                                        msg4.msgText = "Cerberus\nCheckpoint"
                                        msg4.visible = true
                                     }
                                else
                                    msg4.visible = false
                            }
                        }

                Grid {
                    id:layoutPawn18
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: case19Id
                width: 11/100*parent.width
                height : 24/100*parent.height
                y : 94/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn19
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: case20Id
                width: 11/100*parent.width
                height : 1/4*parent.height
                y : 150/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn20
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: case21Id
                width: 11/100*parent.width
                height : 1/4*parent.height
                y : 90/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Grid {
                    id:layoutPawn21
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
             Rectangle {
                id: case22Id
                width: 11/100*parent.width
                height : 1/4*parent.height
                y : 140/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onHoveredChanged:{
                                if(containsMouse == true)
                                     {
                                        msg4.msgText = "Rage de\nCerbere+1"
                                        msg4.visible = true
                                     }
                                else
                                    msg4.visible = false
                            }
                        }

                Grid {
                    id:layoutPawn22
                    columns:2
                    spacing : 2
                    y : 1/5*parent.y
                }
            }
            Rectangle {
                id: caseBarqueId
                width: 12/100*parent.width
                height : 37/100*parent.height
                y : 85/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Column {
                    width : parent.width
                    height : parent.height
                    x : 20/100*width
                    y : 20/100*height
                    id:layoutPawnBarque
                    spacing : 2
                }
            }
        }
    }
}
