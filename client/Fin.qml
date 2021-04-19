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
                        font.pointSize: 36
			            font.family: "Stoneyard"
                    }

                }
            }
        }


        Rectangle {
            width : parent.width
            height : 9/10*parent.height
            y : 2/10*height
            x : 0
            color : "transparent"
            Row {
                id : endcolumnid
                width : parent.width
                height : parent.height
                Rectangle {
                    width : 4/10*parent.width
                    height : parent.height 
                    x: 1/10*parent.width
                    color : "transparent"
                    /*border.color : "blue"
                    border.width : 4*/
                    Column {
                        width : parent.width
                        height : parent.height
                        x : 20/100*width
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/8
                            color : "transparent"
                            x : 1.3*parent.x

                            Text {
                                text : "Aventuriers " 
                                font.pointSize: 30
                                font.family: "Stoneyard"
                            }
                        }
                    }
                       Rectangle {
                        width : parent.width/1.1
                        height : parent.height/1.3
                        x : 20/100*width
                         y: 10/100*height
                        border.color: "white"
                        border.width: 3
                        color : "black"
                        opacity: 0.5
                          radius: 10
                          gradient: Gradient {
                                         GradientStop { position: 0.0; color: "black"; }
                                         GradientStop { position: 0.6; color: "transparent"; }
                                         GradientStop { position: 1.0; color: "white"; }
                                     }

                    }
                    
                }

                Rectangle {
                    width : 4/10*parent.width
                    height : parent.height 
                    color : "transparent"
                    /*border.color : "blue"
                    border.width : 4*/
                    Column {
                        width : parent.width
                        height : parent.height
                        x : 20/100*width
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/8
                            color : "transparent"
                            x : 1.3*parent.x

                            Text {
                                text : "Cerbere " 
                                font.pointSize: 30
                                font.family: "Stoneyard"
                            }
                        }
                    }
                    Rectangle{
                    width : parent.width/1.1
                    height : parent.height/1.3
                    x : 20/100*width
                    y: 10/100*height
                    border.color: "white"
                    border.width: 2.5
                    color : "black"
                    opacity: 0.5
                      radius: 10
                      gradient: Gradient {
                                     GradientStop { position: 0.0; color: "black"; }
                                     GradientStop { position: 0.6; color: "transparent"; }
                                     GradientStop { position: 1.0; color: "white"; }
                                 }
                    }
                }
            }
        }
    }
}
