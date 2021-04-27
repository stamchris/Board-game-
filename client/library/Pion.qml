import QtQuick 2.10
import QtGraphicalEffects 1.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10

Rectangle {
	id: pionId
	property alias imgPionId: imgPionId
	width: 25
	height: 25
	radius: 15
	visible: false
	color: "transparent"

	Image {
		id: imgPionId
		source: ""
		width: parent.width
		height: parent.height/5*4.5
		y: parent.y
		z:1

		SequentialAnimation {
			running: true
			loops: Animation.Infinite

			NumberAnimation { 
				target: imgPionId; 
				property: "y"; 
				to: y+5; 
				duration: 1000
			}

			NumberAnimation { 
				target: imgPionId; 
				property: "y"; 
				to: y-5; 
				duration: 1000
			}
		}
	}

	Rectangle {
		id: basePionId
		width: parent.width
		height: parent.width/5
		color: "Black"
		opacity: 0.66
		radius: parent.width/3
		y: imgPionId.height - parent.width/10
		z:0

		SequentialAnimation {
			running: true
			loops: Animation.Infinite

			ParallelAnimation { 
				NumberAnimation { 
					target: basePionId; 
					property: "height"; 
					to: pionId.width/2; 
					duration: 1000
				}

				NumberAnimation { 
					target: basePionId; 
					property: "width"; 
					to: pionId.width; 
					duration: 1000
				}

				NumberAnimation { 
					target: basePionId; 
					property: "x"; 
					to: 0;
					duration: 1000
				}
			}

			ParallelAnimation { 
				NumberAnimation { 
					target: basePionId; 
					property: "height"; 
					to: pionId.width/2*0.75; 
					duration: 1000
				}

				NumberAnimation { 
					target: basePionId; 
					property: "width"; 
					to: pionId.width*0.75; 
					duration: 1000
				}

				NumberAnimation { 
					target: basePionId; 
					property: "x"; 
					to: pionId.width/8; 
					duration: 1000
				}
			}
		}
	}
}
