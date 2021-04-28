import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
	property var players:[]
	property var view:"Login"
	property var rank: -1
	property var messages : []
	property alias board: window
	property alias endwindow : endwindow
	
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
	}

	Board {
		id: window
		anchors.fill: parent
		visible: view == "Board"
	}

	Fin {
		id: endwindow
		anchors.fill : parent
		visible:view == "Fin"
	}
}
