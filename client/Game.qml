import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
<<<<<<< client/Game.qml
	property var players:[]
	property var view:"Login"
	property var rank: -1
	property var messages : []
	property alias board: window
	
	function getPlayer()
	{
		return players[rank]
	}

	function addMessage(player,timestamp, message) {
		messages.push({player:player, timestamp:timestamp, message:message})
    	messages = messages
	}
	
	Lobby {
		anchors.fill: parent
		visible:view == "Login"

		Chat {
			width: parent.width/2
			height: parent.height/2
			Layout.alignment: Qt.AlignBottom
		}
	}

	Board {
		id: window
		anchors.fill: parent
		visible: view == "Board"
	}
}
