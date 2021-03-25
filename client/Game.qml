import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
	property var players: []
	property var view: "Lobby"
	property var messages : []
	property alias board: window
	
	function addMessage(player,message) {
		messages.push({player:player,message:message})
    	messages = messages
	}
	
	Lobby {
		anchors.fill: parent
		visible:view == "Lobby"

		Chat {
			id: chat
			width: parent.width/2
			height: parent.height/2
			
			anchors {
				bottom: parent.bottom;
				right: parent.right
			}
		}
	}

	Board {
		id: window
		anchors.fill: parent
		visible: view == "Board"
	}
}
