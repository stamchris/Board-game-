import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
	id: game
	property var state: "lobby"
	property var players: []
	Lobby {
		anchors.fill: parent

		visible: game.state == "lobby"
	}
	
	Label {
		text: "Le jeu est ici !"
		visible: game.state == "start"
	}
}
