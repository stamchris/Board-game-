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
        source: "images/background_fin.jpg"
        anchors.fill:parent
    }
    property alias endcolumnid : endcolumnid
    property alias titleend : titleend
    property alias adventurercolumn : adventurercolumn
    property alias cerberecolumn : cerberecolumn

    Rectangle {
        height : parent.height
        width : parent.width
        color : "transparent"
        Rectangle {
            width : parent.width/5
            x : 74/100*parent.width/2
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
            x : 1/20*width
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
                    Column {
                        id : adventurercolumn
                        width : parent.width
                        height : parent.height
                        x : 20/100*width
                        spacing : parent.height/20
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/8
                            color : "transparent"
                            x : 1.5*parent.x
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
                    Column {
                        id : cerberecolumn
                        width : parent.width
                        height : parent.height
                        x : 20/100*width
                        spacing : parent.height/20
                        Rectangle {
                            width : parent.width/2
                            height : parent.height/8
                            color : "transparent"
                            x : 1.5*parent.x

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