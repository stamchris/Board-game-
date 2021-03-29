import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
	property var players:[]
	property var view:"Login"
	property var rank: -1
	
	function getPlayer()
	{
		return players[rank]
	}

	Lobby {
		anchors.fill:parent
		visible:view=="Login"
	}
	
	Board {
		visible:view=="Board"
	}
}
