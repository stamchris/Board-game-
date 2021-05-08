import QtQuick 2.10
import QtQuick.Controls 2.10

Rectangle {
	id: rowroot
	width: parent.width
	height: parent.height
	anchors.fill: parent
	color: "transparent"
	border.color: "#740912"
	border.width: 2
	
	property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL
	
	function updateVitesse(newVitesse) {
		cubeid.source = "../images/"+newVitesse+".png"
	}
	
	function updateRage(newRage) {
		let newBarColor = Qt.rgba((Math.min(5, newRage-1)*51)/255, (Math.min(5, 10-newRage)*51)/255, 0, 1);
		rageBarRepeater.color = newBarColor;
		rageBarRepeater.rageLevel = newRage;
	}
	
	function updateBar(players) {
		var colors = ["Cyan", "Orange", "Green", "White", "Pink", "Blue", "Red"]
		
		for (var i = 0; i < players.length; i++) {
			for (var j = 0; j < colors.length; j++){
				if ((players[i].colour == colors[j]) && (players[i].type == "aventurier")) {
					colors.splice(j, 1)
					break
				}
			}
		}

		let remaining = 10 - colors.length;
		for(let i = 0;i < remaining;i++){
			colors.push("");
		}
		rageBarRepeater.model = colors;
	}
	
	function addToBar(playerColor) {
		let model = rageBarRepeater.model;
		for(let i = 0;i < model.length;i++){
			if(model[i] === playerColor){
				// Le joueur est déjà sur la barre: On s'arrête
				return;
			}else if(model[i] === ""){
				// On a trouvé une place libre: On y place le
				// joueur
				model[i] = playerColor;
				break;
			}
		}
		rageBarRepeater.model = model;
	}
	
	Rectangle {
		id: cerbereBarId
		height: parent.height*90/100
		width: parent.width - parent.height*10/100
		color: "transparent"
		
		anchors {
			verticalCenter: parent.verticalCenter;
			horizontalCenter: parent.horizontalCenter;
		}
		
		Row {
			height : parent.height
			width : parent.width
			anchors.fill: parent
			
			Rectangle {
				id: iconeVitesse
				height: parent.height
				width: parent.height
				color: "transparent"
				
				Image {
					height: parent.height
					width: parent.width
					source: "../images/vitesse_icone.png"
					fillMode: Image.PreserveAspectFit
				}   
			}
			
			Rectangle {
				id: vitesseCerbere
				height: parent.height
				width: parent.height
				color: "transparent"
				
				Image {
					id:cubeid
					height: parent.height
					width: parent.width
					source: "../images/3.png"
					fillMode: Image.PreserveAspectFit
				}
			} 
			
			Rectangle{
				height: parent.height
				width: parent.height*0.5
				color: "transparent"
			}
			
			Rectangle {
				id: iconeRage
				height: parent.height
				width: parent.height
				color: "transparent"
				
				Image {
					height : parent.height
					width : parent.height
					source : "../images/colere_icone.png"
					fillMode: Image.PreserveAspectFit
				}
			}
			
			Row {
				id: rageBar
				height : parent.height*0.66
				width : parent.width - 3.5*parent.height
				anchors.verticalCenter: parent.verticalCenter
				
				Repeater {
					id: rageBarRepeater
					property string color: "#AA000000"
					property int rageLevel: 1
					model: ["", "", "", "", "", "", "", "", "", ""]
					delegate: Rectangle {
						height: parent.height
						width: parent.width/10
						color: index < rageBarRepeater.rageLevel ? rageBarRepeater.color : "#AA000000"
						border.color: "#740912"
						border.width: 1

						Text {
							visible: index === rageBarRepeater.rageLevel-1
							color: "Black"
							text: index+1
							anchors.centerIn: parent
						}

						Image {
							height: parent.height
							width: parent.height
							anchors.centerIn: parent
							source: modelData === "" ? "" : src+"images/" + modelData + "_pion.png"
							fillMode: Image.PreserveAspectFit
						}
					}
				}
			}
		}
	}
}
