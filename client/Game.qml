import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
	property var players:[]
	property var view:"Login"
	property var messages : []
	
	function addMessage(player,message) {
		messages.push({player:player,message:message})
		messages=messages
		console.log(messages)
	}

	Item {
		id : kek
		anchors.top:parent.top

		Lobby {
		anchors.fill:parent
			visible:view=="Login"
		}	
	
		Board {
			visible:view=="Board"
		}
	}

	Chat {
		anchors.top:parent.verticalCenter
		anchors.bottom:parent.bottom
		anchors.right:parent.horizontalCenter
		anchors.left:parent.left

		id: chat
	}

}
