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
				text: modelData.name + " est connecté"
				Layout.alignment: Qt.AlignHCenter
			}
		}
	}

	CheckBox {
		text : "Je suis prêt !"
		onClicked : {
			socket.send({type: "ready"})
		}
	}
}
