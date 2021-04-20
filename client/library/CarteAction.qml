import QtQuick 2.10

Column {
	id: columnId
	height: parent.height
	width: parent.width
	
	anchors {
		top: parent.top;
		left: parent.left
	}
	
	function blockCard() {
		hover1Id.hoverEnabled = false
		up.color = "gray"
		up.opacity = 0.75
		hover2Id.hoverEnabled = false
		down.color = "gray"
		down.opacity = 0.75
	}
	
	function unblockCard() {
		hover1Id.hoverEnabled = true
		up.color = "White"
		up.opacity = 0
		hover2Id.hoverEnabled = true
		down.color = "White"
		down.opacity = 0
	}
	
	function playAction(choix) {
		var num_carte = parent.source.toString()
		num_carte = num_carte.charAt(num_carte.length - 5)

		window.generator = window.playCard("action", num_carte, window.parent.state.playerType+num_carte, choix);
		window.generator.next();
	}
	
	Rectangle {
		id: up
		width: columnId.width
		height: columnId.height/2
		anchors.left: parent.left
		opacity: 0
		color: "blue"
		
		MouseArea {
			id: hover1Id
			width: parent.width
			height: parent.height
			hoverEnabled: true
			
			onHoveredChanged: {
				if (hoverEnabled == true) {
					if (containsMouse == true) {
						up.opacity = 0.25
					} else {
						up.opacity = 0
					}
				}
			}
			
			onClicked: {
				if (hover1Id.hoverEnabled == true) {
					columnId.playAction(0)
				}
			}
		}
	}
	
	Rectangle {
		id: down
		width: columnId.width
		height: columnId.height/2
		opacity: 0
		color:  "red"
		
		MouseArea {
			id: hover2Id
			width: parent.width
			height: parent.height
			hoverEnabled: true
			
			onHoveredChanged: {
				if (hoverEnabled == true) {
					if (containsMouse == true) {
						down.opacity = 0.25
					} else {
						down.opacity = 0
					}
				}
			}
			
			onClicked: {
				if (hover1Id.hoverEnabled == true) {
					columnId.playAction(1)
				}
			}
		}
	}
}
