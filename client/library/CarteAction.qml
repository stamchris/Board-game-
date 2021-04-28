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
	
	Repeater {
		model: 2
		delegate: Rectangle {
			width: columnId.width
			height: columnId.height/2
			anchors.left: parent.left
			opacity: if(blocked) 0.75
				 else if(hover.containsMouse) 0.25
				 else 0
			color: blocked ? "gray" : "white"
			
			MouseArea {
				id: hover
				width: parent.width
				height: parent.height
				hoverEnabled: !blocked

				onClicked: {
					if(hoverEnabled){
						columnId.playAction(index);
					}
				}
			}
		}
	}
}
