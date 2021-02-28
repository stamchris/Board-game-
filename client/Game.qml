import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.10

Item {
	property var players:[]
	property var view:"Login"
	
	Lobby {
		anchors.fill:parent
		visible:view=="Login"
	}
	
	Board {
		anchors.fill:parent
		visible:view=="Board"
	}
}
