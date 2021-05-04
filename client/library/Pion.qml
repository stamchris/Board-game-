import QtQuick 2.10
import QtGraphicalEffects 1.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10

Rectangle {
	id: pionId
	width: 25
	height: 25
	visible: false
	color: "transparent"
	property alias imgPionId: imgPionId

	Image {
		id: imgPionId
		source: ""
		width: parent.width*0.85
		height: parent.height*0.85
		anchors.centerIn: parent
	}

	Glow {
		anchors.fill: imgPionId
		radius: 8
		samples: 17
		color: "white"
		source: imgPionId
	}
}
