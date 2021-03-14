import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

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
