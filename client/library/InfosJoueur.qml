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


	Rectangle {
		id: little_action1_usr
		height: parent.height
		width: parent.width/5 -2
		border.color: "white"
		color: "transparent"
		x: parent.width
		property alias source: img1.source

		Image {
			id: img1
			anchors.fill : parent
			source : actions[0] ? src+"images/"+(adventurer ? color : "Cerbere")+"1.png" : src+"images/verso.png"
		}
	}

	Rectangle {
		id: little_action2_usr
		height: parent.height
		width: parent.width/5 -2
		border.color: "white"
		color: "transparent"
		property alias source: img2.source

		Image {
			id: img2
			anchors.fill: parent
			source : actions[1] ? src+"images/"+(adventurer ? color : "Cerbere")+"2.png" : src+"images/verso.png"
		}
	}

	Rectangle {
		id:little_action3_usr
		height: parent.height
		width: parent.width/5-2
		border.color: "white"
		color: "transparent"
		property alias source: img3.source

		Image {
			id: img3
			anchors.fill: parent
			source : actions[2] ? src+"images/"+(adventurer ? color : "Cerbere")+"3.png" : src+"images/verso.png"
		}
	}

	Rectangle {
		id: little_action4_usr
		height: parent.height
		width: parent.width/5-2
		border.color: "white"
		color: "transparent"
		property alias source: img4.source

		Image {
			id: img4
			anchors.fill: parent
			source : actions[3] ? src+"images/"+(adventurer ? color : "Cerbere")+"4.png" : src+"images/verso.png"
		}
	}
}
