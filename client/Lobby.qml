import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12
import QtWebSockets 1.12

Item {
	property string src: typeof ROOT_URL === "undefined" ? "" : ROOT_URL

	property string username: "Not Connected"

	function getPlayerName(scolor){
		for (var i = 0; i < game.players.length; i++) {
			if (game.players[i].colour === scolor)
			{
				username = game.players[i].name
				return (typeof username === "undefined"? " ": game.players[i].name)
			}
			else{
				return (typeof username === "undefined"? " ": "Not Connected")
			}
		}
		return " "
	}

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
		visible: game.getPlayer().owner
		anchors.top:wrap_container.top
		anchors.right:wrap_container.right
		text: "Configuration"
		onClicked: loader.push(configScreen)
	}
	
	Component {
		id: configScreen
		
		GameCreation {
			anchors.fill: parent
		}
	}

	ColumnLayout {
		anchors{bottom: wrap_container.bottom;right: wrap_container.right;bottomMargin: 5;rightMargin: 5}
		height: 200
		width: 200

		ListView {
			id:listView
			Layout.fillWidth: true
			Layout.fillHeight: true
			model: game.players
			verticalLayoutDirection: ListView.BottomToTop

			delegate:

			Rectangle {
				id: rectaId
				width: listView.width
				height: userText.implicitHeight + 10
				color: "#D7BDE2"
				opacity: 0.6
				radius:1

				Text {
					id:userText
					width: parent.width
					horizontalAlignment: Text.AlignHCenter
					color:if (modelData.colour === "Cyan")
						userText.color = "#5DADE2"
						else
						userText.color = modelData.colour
					text: modelData.name + " est connecté"
					font.pointSize: 12
					font.family: "Stoneyard"
				}
			}
		}
	}


	GridLayout {
		id:gridLayout
		height: parent.height*0.7
		width: parent.width *0.8
		anchors{horizontalCenter: wrap_container.horizontalCenter;top: wrap_container.top}
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

		Text {
			id: cyanText
			text:getPlayerName("Cyan")
			Layout.alignment: Qt.AlignCenter
			onStateChanged: cyanText.text=getPlayerName("Cyan")
		}
		Text {
			id: blueText
			text: getPlayerName("Blue")
			Layout.alignment: Qt.AlignCenter
			onStateChanged: blueText.text=getPlayerName("Blue")
		}
		Text {
			id: roseText
			text:getPlayerName("Pink")
			Layout.alignment: Qt.AlignCenter
			onStateChanged: roseText.text=getPlayerName("Pink")
		}
		Text {
			id: greenText
			text: getPlayerName("Green")
			Layout.alignment: Qt.AlignCenter
			onStateChanged: greenText.text=getPlayerName("Green")
		}
		Text {
			id: whiteText
			text: getPlayerName("White")
			Layout.alignment: Qt.AlignCenter
		}
		Text {
			id: redText
			text: getPlayerName("Red")
			Layout.alignment: Qt.AlignCenter
		}
		Text {
			id: orangeText
			text: getPlayerName("Orange")
			Layout.alignment: Qt.AlignCenter
		}


		// Players Icons
		Repeater{
			model: ["images/cyan_icone.png","images/bleu_icone.png",
				"images/rose_icone.png","images/vert_icone.png", "images/blanc_icone.png",
				"images/rouge_icone.png", "images/orange_icone.png"]

			delegate: BorderImage {
				width: 100
				height: width
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.maximumWidth: 150
				Layout.maximumHeight: 150
				Layout.alignment: Qt.AlignCenter
				source: modelData
			}
		}


//        Repeater{
//            ListModel {
//                           id:listmodel

//                           ListElement{source:"images/cyan_pion.png"; distance:1.5; scol:"Cyan"}
//                           ListElement{source:"images/bleu_pion.png"; distance:1.5; scol:"Blue"}
//                           ListElement{source:"images/rose_pion.png"; distance:1.5; scol:"Pink"}
//                           ListElement{source:"images/vert_pion.png"; distance:1.5; scol:"Green"}
//                           ListElement{source:"images/blanc_pion.png"; distance:1.5; scol:"White"}
//                           ListElement{source:"images/rouge_pion.png"; distance:1.5; scol:"Red"}
//                           ListElement{source:"images/orange_pion.png"; distance:1.2; scol:"Orange"}
//                       }

//            model:listmodel

//            delegate:buttonIcon

//                Component{
//                id:buttonIcon

//                Button {
//                width: 100
//                height: width
//                Layout.fillWidth: true
//                Layout.fillHeight: true
//                Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {80}else{90}
//                Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {80}else{90}
//                Layout.alignment: Qt.AlignCenter
//                Layout.topMargin: 20
//                background:

//                Rectangle{
//                    height: parent.height*1.5
//                    width: parent.width*1.5
//                    anchors{centerIn: parent}
//                    radius:80
//                    color: "transparent"

//                    BorderImage {
//                        anchors.centerIn: parent
//                        height: parent.height/modelData.distance
//                        width: parent.width/modelData.distance
//                        source: src+modelData.source
//                        rotation: -90
//                    }

//                    MouseArea{
//                        id:modelData
//                        anchors.fill:parent
//                        hoverEnabled: true
//                        onHoveredChanged: {
//                        if (hoverEnabled == true) {
//                            if (containsMouse == true) {
//                                rec1.color = "#f0f0d3"
//                            } else {
//                            rec1.color = "transparent"
//                            }
//                        }
//                        }
//                        onClicked: {
//                            socket.send({type:"change_colour",colour:modelData.scol});
//                           console.log(MouseArea.id);
//                        }
//                    }
//                }
//            }
//            }


		Button {
			width: 100
			height: width
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {80}else{90}
			Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {80}else{90}
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 20
			background:

			Rectangle{
				id:rec1
				height: parent.height*1.5
				width: parent.width*1.5
				anchors{centerIn: parent}
				radius:80
				color: "transparent"

				BorderImage {
					anchors.centerIn: parent
					height: parent.height/1.5
					width: parent.width/1.5
					source: src+"images/cyan_pion.png"
					rotation: -90
				}


				MouseArea{
					id : m1
					anchors.fill:parent
					hoverEnabled: true
					onHoveredChanged: {
					if (hoverEnabled == true) {
						if (containsMouse == true) {
							rec1.color = "#f0f0d3"
						} else {
						rec1.color = "transparent"
						}
					}
					}
					onClicked: {
						socket.send({type:"change_colour",colour:"Cyan"});
					}
				}
			}
		}

		Button {
			width: 100
			height: width
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {80}else{90}
			Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {80}else{90}
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 20

			background:

			Rectangle{
				id:rec2
				height: parent.height*1.5
				width: parent.width*1.5
				anchors{centerIn: parent}
				radius:80
				color: "transparent"


				BorderImage {
					anchors.centerIn: parent
					height: parent.height/1.5
					width: parent.width/1.5
					source: src+"images/bleu_pion.png"
					rotation: -90
				}


				MouseArea{
					id : m2
					anchors.fill:parent
					hoverEnabled: true
					onHoveredChanged: {
						if (hoverEnabled == true) {
						if (containsMouse == true) {
							rec2.color = "#f0f0d3"
						} else {
							rec2.color = "transparent"
						}
						}
					}
					onClicked: {
						socket.send({type:"change_colour",colour:"Blue"})
					}
				}
			}
		}





		Button {
			width: 100
			height: width
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {80}else{90}
			Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {80}else{90}
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 20

			background:

			Rectangle{
				id:rec3
				height: parent.height*1.5
				width: parent.width*1.5
				anchors{centerIn: parent}
				radius:80
				color: "transparent"

				BorderImage {
					anchors.centerIn: parent
					height: parent.height/1.5
					width: parent.width/1.5
					source: src+"images/rose_pion.png"
					rotation: -87
				}
				MouseArea{
					id : m3
					anchors.fill:parent
					hoverEnabled: true
					onHoveredChanged: {
						if (hoverEnabled == true) {
						if (containsMouse == true) {
							rec3.color = "#f0f0d3"

						} else {
							rec3.color = "transparent"
						}
						}
					}
					onClicked: {
						socket.send({type:"change_colour",colour:"Pink"})
					}
				}
			}
		}

		Button {
			width: 100
			height: width
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {80}else{90}
			Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {80}else{90}
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 20

			background:

			Rectangle{
				id:rec4
				height: parent.height*1.5
				width: parent.width*1.5
				anchors{centerIn: parent}
				radius:80
				color: "transparent"

				BorderImage {
					anchors.centerIn: parent
					height: parent.height/1.5
					width: parent.width/1.5
					source: src+"images/vert_pion.png"
					rotation: -90
				}


				MouseArea{
					id : m4
					anchors.fill:parent
					hoverEnabled: true
					onHoveredChanged: {
						if (hoverEnabled == true) {
						if (containsMouse == true) {
							rec4.color = "#f0f0d3"

						} else {
							rec4.color = "transparent"
						}
						}
					}
					onClicked: {
						socket.send({type:"change_colour",colour:"Green"})
					}
				}
			}

		}

		Button {
			width: 100
			height: width
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {80}else{90}
			Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {80}else{90}
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 20

			background:

			Rectangle{
				id:rec5
				height: parent.height*1.5
				width: parent.width*1.5
				anchors{centerIn: parent}
				radius:80
				color: "transparent"

				BorderImage {
					anchors.centerIn: parent
					height: parent.height/1.5
					width: parent.width/1.5
					source: src+"images/blanc_pion.png"
					rotation: -90
				}


				MouseArea{
					id : m5
					anchors.fill:parent
					hoverEnabled: true
					onHoveredChanged: {
						if (hoverEnabled == true) {
						if (containsMouse == true) {
							rec5.color = "#f0f0d3"

						} else {
							rec5.color = "transparent"
						}
						}
					}
					onClicked: {
						socket.send({type:"change_colour",colour:"White"})
					}
				}
			}

		}

		Button {
			width: 100
			height: width
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {80}else{90}
			Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {80}else{90}
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 20

			background:

			Rectangle{
				id:rec6
				height: parent.height*1.5
				width: parent.width*1.5
				anchors{centerIn: parent}
				radius:80
				color: "transparent"

				BorderImage {
					anchors.centerIn: parent
					height: parent.height/1.5
					width: parent.width/1.5
					source: src+"images/rouge_pion.png"
					rotation: -90
				}


				MouseArea{
					id : m6
					anchors.fill:parent
					hoverEnabled: true
					onHoveredChanged: {
						if (hoverEnabled == true) {
						if (containsMouse == true) {
							rec6.color = "#f0f0d3"
						} else {
							rec6.color = "transparent"
						}
						}
					}
					onClicked: {
						socket.send({type:"change_colour",colour:"Red"})
					}
				}
			}

		}
		Button {
			width: 100
			height: width
			Layout.fillWidth: true
			Layout.fillHeight: true
			Layout.maximumWidth:if(gridLayout.width<950 ||gridLayout.height<650) {80}else{90}
			Layout.maximumHeight:if(gridLayout.width<950 || gridLayout.height<650) {80}else{90}
			Layout.alignment: Qt.AlignCenter
			Layout.topMargin: 20

			background:

			Rectangle{
				id:rec7
				height: parent.height*1.5
				width: parent.width*1.5
				anchors{centerIn: parent}
				radius:80
				color: "transparent"

				BorderImage {
					anchors.centerIn: parent
					height: parent.height/1.4
					width: parent.width/1.2
					source: src+"images/orange_pion.png"
				}


				MouseArea{
					id : m7
					anchors.fill:parent
					hoverEnabled: true
					onHoveredChanged: {
						if (hoverEnabled == true) {
						if (containsMouse == true) {
							rec7.color = "#f0f0d3"

						} else {
							rec7.color = "transparent"
						}
						}
					}
					onClicked: {
						socket.send({type:"change_colour",colour:"Orange"})
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
		width: wrap_container.width/4
		height: wrap_container.height*0.25
		anchors{bottom: wrap_container.bottom;left: wrap_container.left}
	}

}





