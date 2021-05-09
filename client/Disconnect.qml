import QtQuick.Controls 2.14

Button {
	text: "Déconnexion"
	onClicked: socket.send({type:"warnDisconnect"})
}
