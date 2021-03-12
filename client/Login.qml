import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10

Item {
	ColumnLayout {
		anchors.horizontalCenter: parent.horizontalCenter

		Label {
			text: "Serveur"
		}
		TextField {
			width: 220
			id: serveurInput
			text: "localhost:3000"
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
