import QtQuick 2.9

Column {
	id: columnIdB
	height: parent.height
	width: parent.width
	property bool blocked: true
	property string name
	
	anchors {
		top:parent.top;
		left: parent.left
	}
	
	function playBonus(choix) {
		if(name === "Oppo" && choix === 1){
			window.chooseOppoEffect(name, choix, "play_bonus", []);
		}else{
			window.generator = window.playCard("bonus", name, name, choix);
			window.generator.next();
		}
	}
	
	Rectangle {
		id: empty
		width: columnIdB.width
		height: 3/5*columnIdB.height
		opacity: 0
	}
	
	Repeater {
		model: 2
		delegate: Rectangle {
			width: columnIdB.width
			height: 1/5*columnIdB.height
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
						playBonus(index);
					}
				}
			}
		}
	}
}
