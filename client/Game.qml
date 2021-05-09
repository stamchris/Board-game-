import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
	property var players:[]
	property var view:"Login"
	property var playerName: ""
	property var messages : []
	property alias board: window
	property alias lobby : lobby
	property alias endwindow : endwindow

	
	function getPlayer()
	{	
		console.log(playerName)
		return(players.find(player => player.name == playerName))
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
