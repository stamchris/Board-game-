import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Item {
	ColumnLayout {
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter

		Label {
			text: "Serveur"
		}
		TextField {
			width: 220
			id: serveurInput
		}

		Label {
			text: "Pseudo"
		}
		TextField {
			width: 220
			id: loginInput
		}

		Button {
			text: "Go"

			onClicked: socket.connect(serveurInput.text, loginInput.text)
		}

		Label {
			id: lStatus
		}

		Label {
			id: lMessage
		}

	}
}
