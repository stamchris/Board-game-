import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12


Row {
    id: rowId
    anchors.fill: parent
    Rectangle {
        id: firstPlateauid
        width: 29/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1

        Row {
            id:rowFirstPlateauid
            anchors.fill : parent

            Rectangle {
                id: ragecolumnId 
                width: 8/100* parent.width
                color: "transparent"
                height: parent.height
                border.color :"green"
                border.width: 1
            }
                        
            Rectangle {
                id : case0id
                anchors.fill : zone_drop
                width: 14/100* parent.width
                height: 30/100 * parent.height
                y: height
                color: "transparent"
                border.color :"black"
                border.width: 1

                Column {
                    
                    
                }
                   
            }
            Rectangle {
                id : case1Id
                width: 13/100* parent.width
                height: 27/100 * parent.height
                y : height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id : case2Id
                width: 13/100* parent.width
                height: 36/100 *parent.height
                y : 85/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id : case3Id
                width: 13/100* parent.width
                height: 30/100*parent.height
                y: 85/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id: case4Id
                width: 13/100* parent.width
                height: 30/100*parent.height
                y : 145/100 * height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id:case5Id
                width: 13/100* parent.width
                height:30/100*parent.height
                y : 80/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id:case6Id
                width: 14/100* parent.width
                height:29/100*parent.height
                y : 142/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
        }
    }
    Rectangle {
        id: secondPlateauid
        width: 22/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1

        Row {
            id:rowSecondPlateauid
            anchors.fill : parent

            Rectangle {
                id : case7id
                width: 23/100* parent.width
                height:25/100*parent.height
                y : 165/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Column {
                id : cases8_9id
                height: parent.height
                width: 28/100* parent.width
                y : 30/100*height
                spacing : 2/100*parent.height
                Rectangle {
                    id: case9id
                    width: 60/100*parent.width
                    height : 18/100*parent.height
                    y : 110/100*height
                    x : 60/100*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1

                }
                Rectangle {
                    id: case8id
                    width: 80/100*parent.width
                    height: 25/100*parent.height
                    y : height
                    x : 10/100*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1
                }
            }

            Rectangle {
                id: case10id
                width: 15/100*parent.width
                height: 18/100*parent.height
                y : 103/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Column {
                id : cases11_12id
                height: parent.height
                width: 33/100* parent.width
                y : 27/100*height
                spacing : 2/100*parent.height
                Rectangle {
                    id: case11id
                    width: 60/100*parent.width
                    height : 19/100*parent.height
                    y : 90/100*height
                    x : 22/100*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1
                }
                Rectangle {
                    id: case12id
                    width: 70/100* parent.width
                    x : 40/100*width
                    height: 30/100* parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1
                }
            }
        }   
    }

    Rectangle {
        id: thirdPlateauid
        width: 21/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1

        Row {
            id:rowThirdPlateauid
            anchors.fill : parent

            Rectangle {
                id: case13id
                width: 25/100*parent.width
                height : 30/100*parent.height
                y : 120/100*height 
                x : 120/100*width
                color: "transparent"
                border.color :"black"
                border.width: 1
            }

            Column {
                id : cases14_15id
                height: 34/100*parent.height
                width: 33/100* parent.width
                y : height
                spacing : 3/100*parent.height
                Rectangle {
                    id: case14id
                    width: 2/3*parent.width
                    height: 85/100*parent.height
                    x : 1/3*width
                    color: "transparent"
                    border.color :"black"
                    border.width: 1
                }
                Rectangle {
                    id: case15id
                    x: 75/100 * parent.x
                    width: 50/100* parent.width
                    height: 36/100* parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1
                }
            }

            Column {
                id : cases16_17id
                height: 33/100*parent.height
                width: 33/100* parent.width
                y : height
                spacing : 3/100*parent.height
                Rectangle {
                    id: case16id
                    x: 20/100 * parent.x
                    width: 80/100 * parent.width
                    height: 88/100*parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1
                }
                Rectangle {
                    id: case17id
                    width: 60/100* parent.width
                    height: 45/100* parent.height
                    color: "transparent"
                    border.color :"black"
                    border.width: 1
                }
            }
        }    
    }

    Rectangle {
        id: endPlateauId
        width: 28/100* parent.width
        color: "transparent"
        height: parent.height
        border.color :"red"
        border.width: 1
        Row {
            id:rowEndPlateauid
            anchors.fill : parent
            Rectangle {
                id: case18id
                width: 15/100*parent.width
                height : 1/4*parent.height
                y : 140/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id: case19id
                width: 13/100*parent.width
                height : 1/4*parent.height
                y : 80/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id: case20id
                width: 12/100*parent.width
                height : 1/4*parent.height
                y : 140/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id: case21id
                width: 10/100*parent.width
                height : 1/4*parent.height
                y : 90/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
             Rectangle {
                id: case22id
                width: 10/100*parent.width
                height : 1/4*parent.height
                y : 140/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
            Rectangle {
                id: caseBarqueId
                width: 13/100*parent.width
                height : 1/4*parent.height
                y : 150/100*height
                color: "transparent"
                border.color :"black"
                border.width: 1
            }
        }       
    } 
}
