import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0


Rectangle {
	id: rowId
	anchors.fill: parent
	color: "transparent"
	property alias pionesId: pionesId
	property var nb_turn_show_barque : 0
	
	signal notifyPiones(string counter, string player)
	
	function receiveCounter(count, player) {
		notifyPiones(count, player)
	}
	
	function destroyPont() {
		casePontId.visible = false
	}
	
	function revealBarque(barqueNum) {
		caseBarque1Id.children[0].source = "../images/barque_"+barqueNum+"place.png"
		caseBarque2Id.visible = false
		caseBarque3Id.visible = false
	}

	function swapbarque(barqswaps) {
		var barqswap1 = barqswaps[0]
		var barqswap2 = barqswaps[1]
	
		imageflecheidorange.visible = true
		imageflecheidrouge.visible = true
		
		switch(barqswap1) {
			case "1": 
				if(barqswap2 == "2") {
					imageflecheidorange.width =  Qt.binding(function() { return imageflecheidorange.parent.width * 0.56 })
					imageflecheidrouge.width =  Qt.binding(function() { return imageflecheidrouge.parent.width * 0.56 })
					imageflecheidorange.x = 0
					imageflecheidrouge.x = 0
				} else if(barqswap2 == "3") {
					imageflecheidorange.width =  Qt.binding(function() { return imageflecheidorange.parent.width * 1.05})
					imageflecheidorange.x = 0
					imageflecheidrouge.width =  Qt.binding(function() { return imageflecheidrouge.parent.width * 1.05})
					imageflecheidrouge.x = 0
				}
				break
			case "2":
				if(barqswap2 == "1") {
					imageflecheidorange.width =  Qt.binding(function() { return imageflecheidorange.parent.width *0.56})
					imageflecheidrouge.width =  Qt.binding(function() { return imageflecheidrouge.parent.width *0.56})
					imageflecheidorange.x = 0
					imageflecheidrouge.x = 0

				} else if(barqswap2 == "3") {
					imageflecheidorange.width =  Qt.binding(function() { return imageflecheidorange.parent.width * 0.56 })
					imageflecheidrouge.width = Qt.binding(function() { return imageflecheidrouge.parent.width * 0.56 })
					imageflecheidorange.x =  Qt.binding(function() { return imageflecheidorange.parent.width * 6/15 })
					imageflecheidrouge.x =  Qt.binding(function() { return imageflecheidrouge.parent.width * 6/15 })
				}  
				
				break
			case "3":
				if(barqswap2 == "2") {
					imageflecheidorange.width =  Qt.binding(function() { return imageflecheidorange.parent.width * 0.56 })
					imageflecheidrouge.width = Qt.binding(function() { return imageflecheidrouge.parent.width * 0.56 })
					imageflecheidorange.x =  Qt.binding(function() { return imageflecheidorange.parent.width * 6/15 })
					imageflecheidrouge.x =  Qt.binding(function() { return imageflecheidrouge.parent.width * 6/15 })
				} else if(barqswap2 == "1") {
					imageflecheidorange.width =  Qt.binding(function() { return imageflecheidorange.parent.width *1.05})
					imageflecheidrouge.width =  Qt.binding(function() { return imageflecheidrouge.parent.width *1.05})
					imageflecheidorange.x = 0
					imageflecheidrouge.x = 0
				}
				break
		}
		imageflecheidorange.visible = true
		imageflecheidrouge.visible = true
		nb_turn_show_barque = 1
	}

	function hidebarque() {
		if(nb_turn_show_barque < 0) {
			imageflecheidorange.visible = false
			imageflecheidrouge.visible = false
		}
		nb_turn_show_barque -= 1
	}
		
	Rectangle {
		id: case0Id
		height: parent.height*0.2981
		width: parent.width*0.0319
		x: parent.width*0.0086
		y: parent.height*0.2981
		color: "transparent"
	}

	Rectangle {
		id: case1Id
		height: parent.height*0.2700
		width: parent.width*0.0325
		x: parent.width*0.0528
		y: parent.height*0.2592
		color: "transparent"

		ShowEffect {
			id: case1Msg
			anchors.bottom: parent.top
			msgText: "Checkpoint\nCerbère"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case1Msg.visible = true
				} else {
					case1Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: case2Id
		height: parent.height*0.3499
		width: parent.width*0.0344
		x: parent.width*0.0896
		y: parent.height*0.2959
		color: "transparent"
	}

	Rectangle {
		id: case3Id
		height: parent.height*0.3132
		width: parent.width*0.0282
		x: parent.width*0.1301
		y: parent.height*0.2311
		color: "transparent"

		ShowEffect {
			id: case3Msg
			anchors.bottom: parent.top
			msgText: "Cartes Survie\n+1"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case3Msg.visible = true
				} else {
					case3Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: case4Id
		height: parent.height*0.2700
		width: parent.width*0.0307
		x: parent.width*0.1736
		y: parent.height*0.4320
		color: "transparent"

		ShowEffect {
			id: case4Msg
			anchors.top: parent.bottom
			msgText: "Checkpoint\nCerbère"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case4Msg.visible = true
				} else {
					case4Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: case5Id
		height: parent.height*0.2851
		width: parent.width*0.0301
		x: parent.width*0.2178
		y: parent.height*0.2354
		color: "transparent"
	}

	Rectangle {
		id: case6Id
		height: parent.height*0.2505
		width: parent.width*0.0288
		x: parent.width*0.2583
		y: parent.height*0.4233
		color: "transparent"
	}

	Rectangle {
		id: case7Id
		height: parent.height*0.2246
		width: parent.width*0.0276
		x: parent.width*0.2988
		y: parent.height*0.4233
		color: "transparent"

		ShowEffect {
			id: case7Msg
			anchors.top: parent.bottom
			msgText: "Checkpoint\nCerbère"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case7Msg.visible = true
				} else {
					case7Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: case8Id
		height: parent.height*0.2225
		width: parent.width*0.0319
		x: parent.width*0.3405
		y: parent.height*0.5054
		color: "transparent"

		ShowEffect {
			id: case8Msg
			anchors.top: parent.bottom
			msgText: "Un seul joueur peut\n emprunter le pont"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true
		
			onHoveredChanged: {
				if (containsMouse == true) {
					case8Msg.visible = true
					case8Id.color = "#5500FFFF"
					case12Id.color = "#5500FFFF"
				} else {
					case8Msg.visible = false
					case8Id.color = "transparent"
					case12Id.color = "transparent"
				}
			}
		}
	}

	Rectangle {
		id: case9Id
		height: parent.height*0.2354
		width: parent.width*0.0264
		x: parent.width*0.3497
		y: parent.height*0.2311
		color: "transparent"
	}

	Rectangle {
		id: case10Id
		height: parent.height*0.2289
		width: parent.width*0.0252
		x: parent.width*0.3834
		y: parent.height*0.1253
		color: "transparent"

		ShowEffect {
			id: case10Msg
			anchors.bottom: parent.top
			msgText: "Checkpoint\nCerbère"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case10Msg.visible = true
				} else {
					case10Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: case11Id
		height: parent.height*0.2311
		width: parent.width*0.0294
		x: parent.width*0.4172
		y: parent.height*0.2181
		color: "transparent"
	}

	Rectangle {
		id: case12Id
		height: parent.height*0.2613
		width: parent.width*0.0319
		x: parent.width*0.4294
		y: parent.height*0.4989
		color: "transparent"

		ShowEffect {
			id: case12Msg
			anchors.top: parent.bottom
			msgText: "Un seul joueur peut\n emprunter le pont"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true
		
			onHoveredChanged: {
				if (containsMouse == true) {
					case12Msg.visible = true
					case8Id.color = "#5500FFFF"
					case12Id.color = "#5500FFFF"
				} else {
					case12Msg.visible = false
					case8Id.color = "transparent"
					case12Id.color = "transparent"
				}
			}
		}
	}

	Rectangle {
		id: case13Id
		height: parent.height*0.2829
		width: parent.width*0.0344
		x: parent.width*0.4773
		y: parent.height*0.3585
		color: "transparent"

		ShowEffect {
			id: case13Msg
			anchors.bottom: parent.top
			msgText: "Checkpoint\nCerbère"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case13Msg.visible = true
				} else {
					case13Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: case14Id
		height: parent.height*0.2635
		width: parent.width*0.0233
		x: parent.width*0.5337
		y: parent.height*0.3650
		color: "transparent"

		ShowEffect {
			id: case14Msg
			anchors.bottom: parent.top
			msgText: "Si un joueur est\n sur la stèle, le\nportail est disponible"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true
		
			onHoveredChanged: {
				if (containsMouse == true) {
					case14Msg.visible = true
					case14Id.color = "#5500FFFF"
					case16Id.color = "#5500FFFF"
					case17Id.color = "#5500FFFF"
				} else {
					case14Msg.visible = false
					case14Id.color = "transparent"
					case16Id.color = "transparent"
					case17Id.color = "transparent"
				}
			}
		}
	}

	Rectangle {
		id: case15Id
		height: parent.height*0.2117
		width: parent.width*0.0239
		x: parent.width*0.5460
		y: parent.height*0.6652
		color: "transparent"

		ShowEffect {
			id: case15Msg
			anchors.top: parent.bottom
			msgText: "Checkpoint\nCerbère"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case15Msg.visible = true
				} else {
					case15Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: case16Id
		height: parent.height*0.2073
		width: parent.width*0.0276
		x: parent.width*0.5767
		y: parent.height*0.6523
		color: "transparent"

		ShowEffect {
			id: case16Msg
			anchors.top: parent.bottom
			msgText: "Si un joueur est\n sur la stèle, le\nportail est disponible"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true
		
			onHoveredChanged: {
				if (containsMouse == true) {
					case16Msg.visible = true
					case14Id.color = "#5500FFFF"
					case16Id.color = "#5500FFFF"
					case17Id.color = "#5500FFFF"
				} else {
					case16Msg.visible = false
					case14Id.color = "transparent"
					case16Id.color = "transparent"
					case17Id.color = "transparent"
				}
			}
		}
	}

	Rectangle {
		id: case17Id
		height: parent.height*0.2635
		width: parent.width*0.0258
		x: parent.width*0.6025
		y: parent.height*0.3434
		color: "transparent"

		ShowEffect {
			id: case17Msg
			anchors.bottom: parent.top
			msgText: "Si un joueur est\n sur la stèle, le\nportail est disponible"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true
		
			onHoveredChanged: {
				if (containsMouse == true) {
					case17Msg.visible = true
					case14Id.color = "#5500FFFF"
					case16Id.color = "#5500FFFF"
					case17Id.color = "#5500FFFF"
				} else {
					case17Msg.visible = false
					case14Id.color = "transparent"
					case16Id.color = "transparent"
					case17Id.color = "transparent"
				}
			}
		}
	}

	Rectangle {
		id: case18Id
		height: parent.height*0.2333
		width: parent.width*0.0325
		x: parent.width*0.6699
		y: parent.height*0.3521
		color: "transparent"

		ShowEffect {
			id: case18Msg
			anchors.top: parent.bottom
			msgText: "Checkpoint\nCerbere"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case18Msg.visible = true
				} else {
					case18Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: case19Id
		height: parent.height*0.2441
		width: parent.width*0.0307
		x: parent.width*0.7104
		y: parent.height*0.2246
		color: "transparent"
	}

	Rectangle {
		id: case20Id
		height: parent.height*0.2268
		width: parent.width*0.0307
		x: parent.width*0.7515
		y: parent.height*0.3823
		color: "transparent"
	}

	Rectangle {
		id: case21Id
		height: parent.height*0.2246
		width: parent.width*0.0313
		x: parent.width*0.7908
		y: parent.height*0.2419
		color: "transparent"
	}

	Rectangle {
		id: case22Id
		height: parent.height*0.2203
		width: parent.width*0.0319
		x: parent.width*0.8301
		y: parent.height*0.3693
		color: "transparent"

		ShowEffect {
			id: case22Msg
			anchors.top: parent.bottom
			z: 1
			msgText: "Rage de Cerbere\n+1"
		}

		MouseArea{
			anchors.fill: parent
			hoverEnabled: true

			onHoveredChanged: {
				if (containsMouse == true) {
					case22Msg.visible = true
				} else {
					case22Msg.visible = false
				}
			}
		}
	}

	Rectangle {
		id: caseBarque1Id
		height: parent.height*0.3672
		width: parent.width*0.0374
		x: parent.width*0.8687
		y: parent.height*0.3045
		z: -1
		color: "transparent"
		
		Image {
			anchors.fill: parent
			source: "../images/barque_unknown.png"
		}
	}

	Rectangle {
		id: caseBarque2Id
		height: parent.height*0.3672
		width: parent.width*0.0374
		x: parent.width*0.9129
		y: parent.height*0.3045
		color: "transparent"
		
		Image {
			anchors.fill: parent
			source: "../images/barque_unknown.png"
		}
	}

	Rectangle {
		id: caseBarque3Id
		height: parent.height*0.3672
		width: parent.width*0.0374
		x: parent.width*0.9571
		y: parent.height*0.3045
		color: "transparent"
		
		Image {
			anchors.fill: parent
			source: "../images/barque_unknown.png"
		}
	}

	Rectangle {
		id: casePontId 
		height: parent.height*0.0950
		width: parent.width*0.0718
		x: parent.width*0.3730
		y: parent.height*0.5831
	
		Image {
			anchors.fill: parent
			source: "../images/pontv2.png"
		}
	}

	Piones {
		id: pionesId
	}

	Column {
		height: parent.height
		width: parent.width*0.1313
		x: parent.width*0.8687
		
		Rectangle {
			height: parent.height*30/100
			width: parent.width
			color: "transparent"

			Image {
				id: imageflecheidorange
				height: parent.height*50/100
				width: parent.width*56/100
				x: parent.width*1/15
				y: parent.height*50/100
				source: "../images/grande_fleche_orange.png"
				visible: false
			}
		}
		
		Rectangle {
			height: parent.height*40/100
			width: parent.width
			color: "transparent"
		}
	
		Rectangle {
			height: parent.height*30/100
			width: parent.width
			color: "transparent"

			Image {
				id: imageflecheidrouge
				height: parent.height*50/100
				width: parent.width*70/100
				x: 0
				source: "../images/grande_fleche_rouge.png"
				visible: false
			}
		}
	}

	Component.onCompleted: {
		notifyPiones.connect(pionesId.receiveCounterPiones)
	}
}
