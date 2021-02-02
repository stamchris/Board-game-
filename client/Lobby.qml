import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

ColumnLayout {
	id: lobby

	ScrollView {
		Layout.fillHeight:true
		Layout.alignment: Qt.AlignHCenter
		ListView {
			model:game.players
			delegate:Text {
				text: modelData.name + " est un joueur"
				Layout.alignment: Qt.AlignHCenter
			}
		}
	}

	Button {
		text: "Add un truc, KEK"
		onClicked: {
			socket.switchMessage({type:"newPlayer",name:"KAPPA"})
		}
	}
}
