import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
import QtWebSockets 1.0


Rectangle {
    id : imageStatusid
    width : parent.width/2
    height : parent.height/7
    x : parent.x
    color : "transparent"
    border.width : 2
    property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL
    property alias textname : textname
    property alias imagestatut : imagestatut

    Row {
        height : parent.height
        width : parent.width
        spacing : 4

        Rectangle {
            width : parent.width/2
            height : parent.height/3
            color : "transparent"
            y : height
            Text {
                anchors.centerIn : parent
                id : textname
                y : 1/4*parent.height
                text : "" 
                font.pointSize: 30
                font.family: "Stoneyard"
            }
        }
        Rectangle {
            width : parent.width/2
            height : parent.height
            color : "transparent"
            Image {
                id : imagestatut
                anchors.centerIn : parent
                width : parent.width
                height : parent.height
                source : src + "images/cerbere_victory.png"
            }
        }
    }
}