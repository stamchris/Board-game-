import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.10
import QtWebSockets 1.0
import "library"

Item {
    id : endwindow
    height : 400
    width : 700

        Image {        
        source: "images/background_image.jpg"
        anchors.fill:parent
    }
    property alias endcolumnid : endcolumnid
    property alias titleend : titleend

    Rectangle {
        height : parent.height
        width : parent.width
        color : "transparent"
        Rectangle {
            width : parent.width/5
            x : 80/100*parent.width/2
            y : 40
            height : 80
            color : "transparent"
            Row {
                width : parent.width
                height : parent.height
                spacing : 3
                Rectangle {
                    width : parent.width/3
                    height : parent.height/3
                    color : "transparent"
                    Text {
                        id : titleend
                        height : 50
                        width : 30
                        text : "Cerbère "
                        anchors.centerIn: parent 
                        font.pointSize: 24
			            font.family: "Stoneyard"
                    }

                }
            }
        }


        Rectangle {
            width : 8/10*parent.width
            height : 9/10*parent.height
            y : 2/10*height
            x : 51/100*width
            color : "transparent"
            Column {
                id : endcolumnid
                width : parent.width
                height : parent.height
                Rectangle {
                    width : 9/10*parent.width
                    height : parent.height/3
                   // border.color : "indianred"
                    //border.width : 1
                     color : "transparent"
                    Column {
                        width : parent.width
                        height : parent.height
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5
                            anchors.leftMargin: parent.width/2
                            color : "transparent"

                            Text {
                                text : "Aventuriers " 
                                anchors.leftMargin: parent.width/2
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }

                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5
                            color : "transparent"
                            Text {
                                text : "" 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }
                    }
                    
                }

                Rectangle {
                    width : 9/10*parent.width
                    height : parent.height/3
                   // border.color : "indianred"
                    //border.width : 1
                     color : "transparent"
                    
                    Column {
                        width : parent.width
                        height : parent.height
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5
                            anchors.leftMargin: parent.width/2
                            color : "transparent"
                            Text {
                                text : "Cerbère : " 
                                font.pointSize: 24
                                 anchors.leftMargin: parent.width/2
                                font.family: "Stoneyard"
                            }
                        }

                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5
                             color : "transparent"

                            Text {
                                text : "" 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }
                    }

                }
 

                Rectangle {
                    width : 9/10*parent.width
                    height : parent.height/3
                   // border.color : "indianred"
                    //border.width : 1
                    color : "transparent"                    

                    Column {
                        width : parent.width
                        height : parent.height
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5
                            color : "transparent"
                            Text {
                                text : "Aventuriers Éliminés : " 
                                anchors.leftMargin: parent.width/2
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/5
                             color : "transparent"
                            Text {
                                text : "" 
                                font.pointSize: 24
                                font.family: "Stoneyard"
                            }
                        }
                    }

                   
                }
            }
        }
    }
}
