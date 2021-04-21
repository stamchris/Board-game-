import QtQuick 2.10

Column {
	id: columnId
	height: parent.height
	width: parent.width
	property bool blocked: false
	property int numCard: 0
	
	anchors {
		top: parent.top;
		left: parent.left
	}
	
	function playAction(choix) {
		window.generator = window.playCard("action", numCard.toString(), window.parent.state.playerType+numCard, choix);
		window.generator.next();
	}
	
	Rectangle {
		id: up
		width: columnId.width
		height: columnId.height/2
		anchors.left: parent.left
		opacity: if(blocked) 0.75
			 else if(hover1Id.containsMouse) 0.25
			 else 0
		color: blocked ? "gray" : "white"
		
		MouseArea {
			id: hover1Id
			width: parent.width
			height: parent.height
			hoverEnabled: !blocked
			
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
		opacity: if(blocked) 0.75
			 else if(hover2Id.containsMouse) 0.25
			 else 0
		color:  blocked ? "gray" : "white"
		
		MouseArea {
			id: hover2Id
			width: parent.width
			height: parent.height
			hoverEnabled: !blocked
			
			onClicked: {
				if (hover1Id.hoverEnabled == true) {
					columnId.playAction(1)
				}
			}
		}
	}
}
