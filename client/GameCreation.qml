import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14
import QtQuick 2.14

Item {
	property int difficulty: 3
	property int maxPlayers: 3
	property string boardType: "default"
	property bool teamChat: false // not bound in its widget, careful
	
	Rectangle {
		id: wrap_container
		anchors.fill: parent
		
		BorderImage {
			id: background
			source: "images/background_image.jpg"
			anchors.fill:parent
		}
	}
	
	Button {
			anchors{top: wrap_container.top;left: wrap_container.left;topMargin: 10;leftMargin: 10}
			background:
				Rectangle{
				id:retButton
				radius:40
				height: 80
				width: 100
				color: "#F0B27A"

				Text {
					id:textRetour
					text: ("Retour")
					font.pointSize: 15
					color: "black"
					font.family: "Stoneyard"
					anchors.centerIn: parent
				}
				MouseArea{
				anchors.fill:parent
				enabled: true
				hoverEnabled: true

				onHoveredChanged: if(hoverEnabled == true)
						{if (containsMouse == true)
							{
								textRetour.color="white"
								textRetour.font.pointSize = 18
							}
						else{
								textRetour.color="black"
								textRetour.font.pointSize = 15
							}
				}
				onClicked: loader.pop()
				}
			}
		}

	
	Rectangle{
		id:backgroundRect
		height: 0.6*parent.height
		width:0.7*parent.width
		anchors.centerIn: parent
		opacity: 0.5
		color: "#F0B27A"
		radius:20
	}
	
	GridLayout {
		id: leftColumn
		height: 0.5*parent.height
		width:0.6*parent.width
		anchors.centerIn: parent
		columns: 2
		columnSpacing:5
		rowSpacing:5
		
		LobbyOption {
			label: "Difficulté"
			
			Layout.fillWidth: true
			Layout.maximumHeight: 190
			Layout.maximumWidth: 190
			Layout.minimumHeight: 190
			Layout.minimumWidth: 190
			Layout.alignment: Qt.AlignLeft
			
			Row {
				id: buttonRow
				spacing: 10
				
				Repeater {
					model: [3, 4, 5, 6]
					delegate: Button {
						id: difficultyButton
						width:120
						height: 120
						flat:false
						background: Rectangle {
							anchors.fill: parent
							color: difficultyButton.focus ? "#58D68D" : "#FEF5E7"
							radius: 60
							
							Text {
								text: '*'.repeat(modelData - 2)
								anchors.centerIn: parent
								font.pointSize: 15
								font.family: "Noto Emoji"
							}
						}
						checked: difficulty === modelData
						onClicked: difficulty = modelData
					}
				}
			}
		}
		UsersView {
			Layout.fillWidth: true
			Layout.maximumHeight: 250
			Layout.maximumWidth: 300
			Layout.minimumHeight: 250
			Layout.minimumWidth: 300
			Layout.alignment: Qt.AlignRight
			users: game.players
			showKickButtons: true
			gameOwnerLogin: "???"

			onKickClicked: console.log("unimplemented: kick clicked for " + user.login)
		}
		
		LobbyOption {
			label: "Nombre des Joueurs"
			
			Layout.fillWidth: true
			Layout.maximumHeight: 100
			Layout.maximumWidth: 150
			Layout.minimumHeight: 100
			Layout.minimumWidth: 150
			Layout.alignment: Qt.AlignLeft
			Layout.columnSpan: 2
			
			SpinBox {
				id:spinBox
				value: maxPlayers
				from: 3
				to: 7
				
				onValueChanged: maxPlayers = value
				Layout.fillWidth: true
			}
		}
		
//		LobbyOption {
//			label: "Team Chat"
			
//			Layout.fillWidth: true
//			Layout.fillHeight: true
//			Layout.maximumHeight: 100
//			Layout.maximumWidth: 150
//			Layout.alignment: Qt.AlignLeft
			
//			Button {
//				text: if (teamChat) "v"
//				      else "x"
//				checkable: true
//				onCheckedChanged: teamChat = checked
//			}
//		}
		
		Rectangle{
			id: submitButton
			Layout.alignment: Qt.AlignRight
			Layout.fillWidth: true
			Layout.maximumHeight: 100
			Layout.maximumWidth:180
			Layout.minimumHeight: 80
			Layout.minimumWidth:90
			color: "white"
			radius:20
			Layout.columnSpan: 2
			
			Text {
				id: textSubmit
				text: "Configurer"
				font.pointSize: 15
				font.family: "Stoneyard"
				anchors.centerIn: parent
			}
			MouseArea{
				anchors.fill:parent
				enabled: true
				hoverEnabled: true
				
				onHoveredChanged: {
					if(hoverEnabled){
						if (containsMouse){
							submitButton.color="#27AE60"
							textSubmit.color="white"
							textSubmit.font.pointSize = 18
						}else{
							submitButton.color="white"
							textSubmit.color="black"
							textSubmit.font.pointSize = 15
						}
					}
				}
				onClicked: socket.send({type: "game_config", difficulty:difficulty, maxPlayers:maxPlayers})
			}
		}
	}
		

}
