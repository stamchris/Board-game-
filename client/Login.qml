import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

Item {

	Column {
		spacing: 10
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter

		BorderImage {
			width: 270 * 2
			height: 115 * 2
			source: "images/cerbere_logo.png"
			anchors.horizontalCenter: parent.horizontalCenter
		}

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			text: "Serveur :"
			font.pointSize: 12
			font.family: "Stoneyard"

		}
		TextField {
			anchors.horizontalCenter: parent.horizontalCenter
			width: 220
			id: serveurInput
			text: "localhost:3000"
		}

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			text: "Pseudo :"
			font.pointSize: 12
			font.family: "Stoneyard"
		}

		TextField {
			anchors.horizontalCenter: parent.horizontalCenter
			width: 220
			id: loginInput
		}
		
		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			text: "Mot de passe :"
			font.pointSize: 12
			font.family: "Stoneyard"
		}

		TextField {
			anchors.horizontalCenter: parent.horizontalCenter
			width: 220
			id: pwdInput
			echoMode: TextInput.Password
		}

		RoundButton {
			id: boutton_rond
			anchors.horizontalCenter: parent.horizontalCenter
			text: "     Go     "
			font.family: "Stoneyard"
			radius: 5

			onHoverEnabledChanged: boutton_rond.background.color = "grey"
			onClicked: {
				popupErrorMsgLogin.close()
				socket.connect(serveurInput.text, loginInput.text, pwdInput.text)
			}
		}

		Label {
			id: lStatus
			visible: true
		}

		Label {
			id: lMessage
			visible: false
		}
	}

	Popup {
		id: popupErrorMsgLogin
		anchors.centerIn: parent
		width: txtErrorMsgLogin.width*1.125
		height: txtErrorMsgLogin.height*2
		closePolicy: Popup.NoAutoClose
		property alias msg: txtErrorMsgLogin.text

		background: Rectangle {
			color: "red"
			radius: 3
		}

		Text {
			id: txtErrorMsgLogin
			color: "white"
			font.pointSize: 16
			anchors.horizontalCenter : parent.horizontalCenter
		}

		Timer {
			id: errorMsgTimerLogin
			interval: 5000
			onTriggered: popupErrorMsgLogin.close()
		}

		function restartTimer(){
			errorMsgTimerLogin.restart();
		}
	}

	function showErrorMsgLogin(msg){
		popupErrorMsgLogin.msg = msg;
		popupErrorMsgLogin.open();
		popupErrorMsgLogin.restartTimer();
	}
}