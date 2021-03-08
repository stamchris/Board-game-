import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
	ColumnLayout {
		anchors.fill:parent

		ListView {
			Layout.fillWidth: True
			Layout.fillHeight: True
			verticalLayoutDirection:ListView.BottomToTop
			model: game.messages
			delegate:Row {
				Label {
					text: modelData.player.name + ":" + modelData.message
				}
			}
		}



		TextInput {
			Layout.fillHeight: true
			text: "Juimor"
			onEditingFinished : {
				socket.send({type:"chatMessage",message:text})
			}
		}
	}
}
