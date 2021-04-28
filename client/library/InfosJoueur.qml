import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtWebSockets 1.0

Row {
    id : rowinfos
    width: parent.width*5/6
    height: parent.height
	property bool adventurer: true
	property var actions: [true, true, true, true]
	property int bonusSize: 0
	property string color: "Cyan"

    Rectangle {
        id: typejoueur
        width: parent.width/5
        height: parent.height
        color: "#e8e1cd"

        Image {
            anchors.fill: parent
            source: adventurer ? "../images/aventurier_image.png" : src+"/images/Cerbere_pion.png"
        }

        Rectangle {
            id: nb_bonus
            width : parent.width/2
            height : parent.height/2
            anchors.centerIn : parent
            border.width : 2
            border.color : "gold"
            color : "black"
            radius : 25

            Text {
                anchors.centerIn: parent
                id: nb_bonus_txt
                text: bonusSize
                color: "Gold"
            }
        }
    }

	Repeater {
		model: actions
		delegate: Rectangle {
			height: parent.height
			width: parent.width/5 - 2
			border.color: "white"
			color: "transparent"
			x: parent.width

			Image {
				anchors.fill: parent
				source: if(modelData) src+"images/"+(adventurer ? rowinfos.color : "Cerbere")+(index+1)+".png"
					else src+"images/verso.png"
			}
		}
	}
}
