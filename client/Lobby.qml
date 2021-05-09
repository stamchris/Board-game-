import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

Item {
	id : lobby
	property string src: typeof ROOT_URL === "undefined" ? "" : ROOT_URL
	
	Button{
		visible: game.getPlayer().owner
		anchors{top:parent.top;right: parent.right;topMargin: 10;rightMargin: 170}
		background: Rectangle {
			id:retButton
			radius:5
			height: 40
			width: textConfi.width + 40
			color: configMA.hoverEnabled && configMA.containsMouse ? "#27AE60" : "white"

			Text {
				id:textConfi
				text: ("Configuration")
				font.pointSize: 14
				color: configMA.hoverEnabled && configMA.containsMouse ? "white" : "black"
				font.family: "Stoneyard"
				anchors.centerIn: parent
			}

			MouseArea{
				id:configMA
				anchors.fill:parent
				enabled: true
				hoverEnabled: true
				onClicked: loader.push(configScreen)
			}
		}
	}										
	
	Disconnect {
		anchors.top: parent.top
		anchors.left: parent.left
	}
	
	
	Component {
		id: configScreen
		
		GameCreation {}
	}

	GridLayout {
		id:gridLayout
		height: parent.height*0.7
		width: parent.width *0.8
		anchors{horizontalCenter: parent.horizontalCenter;top: parent.top}
		columns: 7
		columnSpacing: 10
		rowSpacing: 10

		BorderImage {
			id:logo
			width: 300
			height: width/2
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth: if(gridLayout.height<650||gridLayout.width<950){350} else{450}
			Layout.maximumHeight: if(gridLayout.height<650||gridLayout.width<950){200} else{300}
			source: "images/cerbere_logo.png"
			Layout.columnSpan: 7
			Layout.alignment: Qt.AlignCenter
			Layout.leftMargin: 200
			Layout.rightMargin: 200
		}
		Rectangle{
			id:empty1
			Layout.fillWidth: true
			Layout.maximumHeight: 30
			Layout.rightMargin: -50
			Layout.columnSpan: 3
			color: "transparent"
		}

		Text{
			id:bigText
			text : "Choix des joueurs :"
			font.pointSize: 24
			font.family: "Stoneyard"
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth: 40
			Layout.maximumHeight: 30
			Layout.columnSpan: 2
			Layout.alignment: Qt.AlignLeft
			Layout.leftMargin: -60

		}

		Rectangle{
			id:empty2
			Layout.fillWidth: true
			Layout.columnSpan: 2
			Layout.maximumHeight: 30
			Layout.leftMargin: 30
			color: "transparent"
		}
		
		Repeater {
			model: [
				{name: "Cyan", color: "#21ACBA"},
				{name: "Blue", color: "#2C4DD6"},
				{name: "Pink", color: "#F2549E"},
				{name: "Green", color: "#3D9519"},
				{name: "White", color: "black"},
				{name: "Red", color: "#D3443B"},
				{name: "Orange", color: "#BF6B00"}
			]
			delegate: Rectangle {
				height: 20
				width: 100
				color: "transparent"
				Text {
					anchors.centerIn: parent
					width: parent.width
					text: {
						let player = game.players.find(player => player.colour === modelData.name);
						if(player){
							player.name;
						}else{
							" ";
						}
					}
					font.pointSize: 15
					font.family: "Stoneyard"
					style: Text.Outline
					color: "#FFF8E4"
					styleColor: modelData.color
					elide: Text.ElideRight
					horizontalAlignment: Text.AlignHCenter
				}
				Layout.alignment: Qt.AlignCenter
			}
		}

		// Players Icons
		Repeater{
			model: ["cyan", "bleu", "rose", "vert", "blanc",
				"rouge", "orange"]

			delegate: BorderImage {
				width: 100
				height: width
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.maximumWidth: 150
				Layout.maximumHeight: 150
				Layout.alignment: Qt.AlignCenter
				source: "images/"+modelData+"_icone.png"
			}
		}
		
		Repeater {
			model: [
				{img: "cyan", color: "Cyan"},
				{img: "bleu", color: "Blue"},
				{img: "rose", color: "Pink"},
				{img: "vert", color: "Green"},
				{img: "blanc", color: "White"},
				{img: "rouge", color: "Red"},
				{img: "orange", color: "Orange"}
			]
			delegate: Button {
				width: 100
				height: width
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.maximumWidth: gridLayout.width < 950 || gridLayout.height<650 ?  80 : 90
				Layout.maximumHeight: gridLayout.width < 950 || gridLayout.height<650 ?  80 : 90
				Layout.alignment: Qt.AlignCenter
				Layout.topMargin: 20
				background: Rectangle {
					height: parent.height*1.5
					width: parent.width*1.5
					anchors.centerIn: parent
					radius:80
					color: pawnMA.hoverEnabled && pawnMA.containsMouse ? "#f0f0d3" : "transparent"

					BorderImage {
						anchors.centerIn: parent
						height: parent.height/1.5
						width: parent.width/1.5
						source: src+"images/"+modelData.img+"_pion.png"
					}


					MouseArea{
						id: pawnMA
						anchors.fill: parent
						hoverEnabled: true
						
						onClicked: {
							socket.send({type:"change_colour",colour: modelData.color});
						}
					}
				}
			}
		}
	}



	CheckBox {
		anchors{horizontalCenter: parent.horizontalCenter;top:gridLayout.bottom;topMargin: 20}
		text : "Je suis prêt !"
		font.pointSize: 20
		font.family: "Stoneyard"
		onClicked : {
			socket.send({type: "ready"})
		}
	}


	Chat {
		width: parent.width/4
		height: parent.height*0.25
		anchors{bottom: parent.bottom;left: parent.left}
	}

}
