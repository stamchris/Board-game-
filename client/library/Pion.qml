import QtQuick 2.10
import QtGraphicalEffects 1.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10

Rectangle {
	id: pionId
	visible: false
	color: "transparent"
	property alias imgPionId: imgPionId
	property alias pionMoveId: pionMoveId
	property var xOffset: 0.0
	property var yOffset: 0.0
	property var heightRatio: 0.25
	property var widthRatio: 0.50
	property var newX: 0.0
	property var newY: 0.0

	function moveTo(newCase) {
		height = newCase.height*heightRatio
		width = newCase.width*widthRatio
		newX = newCase.x + newCase.width*xOffset
		newY = newCase.y + newCase.height*yOffset
		pionMoveId.start()
	}

	Image {
		id: imgPionId
		width: parent.width*0.95
		height: parent.height*0.95
		anchors.centerIn: parent
		source: ""
		fillMode: Image.PreserveAspectFit
	}

	Glow {
		anchors.fill: imgPionId
		radius: 8
		samples: 17
		color: "white"
		source: imgPionId
	}

	SequentialAnimation {
		id: pionMoveId
		running: false

		ParallelAnimation {
			XAnimator {
				target: pionId
				from: x
				to: (x + newX)/2
				duration: 500
			}

			YAnimator {
				target: pionId
				from: y
				to: (y + newY)/2
				duration: 500
			}

			ScaleAnimator {
				target: pionId
				from: 1
				to: 1.5
				duration: 500
			}
		}

		ParallelAnimation {
			XAnimator {
				target: pionId
				from: (x + newX)/2
				to: newX
				duration: 500
			}

			YAnimator {
				target: pionId
				from: (y + newY)/2
				to: newY
				duration: 500
			}

			ScaleAnimator {
				target: pionId
				from: 1.5
				to: 1
				duration: 500
			}
		}
	}
}
