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
<<<<<<< HEAD
	property alias endwindow : endwindow
=======
	property alias lobby : lobby
>>>>>>> 7370b7f... Add a solution for change the name when a player change color , not a best solution for sure
	
	function getPlayer()
	{
		return players[rank]
	}

	function addMessage(player,timestamp, message) {
		messages.push({player:player, timestamp:timestamp, message:message})
    	messages = messages
	}
	
	Lobby {
		id : lobby
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
