import QtQuick 2.10

Rectangle {
	id: cardPlayedId
	height: parent.height*0.15
	width: parent.width*0.15
	color: "#AA000000"
	x: -parent.width*0.20
	y: parent.height*0.51
	z: 50
	property alias imgPlayerId: imgPlayerId
	property alias imgCardPlayedId: imgCardPlayedId
	property alias showPlayedCardId: showPlayedCardId

	property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL

	function displayCard(playerName, playerColor, cardType, cardName, cardEffect) {
		showPlayedCardId.complete()
		imgPlayerId.source = src+"images/" + playerColor + "_pion.png"

		for (var i = 0; i < 4; i++)
			imgCardPlayedId.children[i].opacity = 0    

		if (cardType == "action") {
			imgCardPlayedId.source = src+"images/" + playerColor + cardName + ".png"
			imgCardPlayedId.children[cardEffect].opacity = 0.85
		} else {
			imgCardPlayedId.source = src+"images/Carte_" + cardName + ".png"
			imgCardPlayedId.children[cardEffect + 2].opacity = 0.85
		}

		showPlayedCardId.start()
	}

	Image {
		id: imgPlayerId
		width: parent.width/2 - parent.height*0.10
		height: parent.height - parent.height*0.10
		source: ""
		fillMode: Image.PreserveAspectFit

		anchors {
			left: parent.left
			leftMargin: parent.height*0.05
			bottom: parent.bottom
			bottomMargin: parent.height*0.05
		}
	}

	Image {
		id: imgCardPlayedId
		width: parent.width/2 - parent.height*0.05
		height: parent.height - parent.height*0.10
		source: ""
		fillMode: Image.PreserveAspectFit

		anchors {
			right: parent.right
			rightMargin: parent.height*0.05
			bottom: parent.bottom
			bottomMargin: parent.height*0.05
		}

		Rectangle {
			id: playedActionUpId
			width: parent.paintedWidth+3
			height: parent.paintedHeight/2
			anchors.bottom: parent.bottom
			anchors.horizontalCenter: parent.horizontalCenter
			color: "Black"
			opacity: 0
		}

		Rectangle {
			id: playedActionBottomId
			width: parent.paintedWidth+3
			height: parent.paintedHeight/2
			anchors.top: parent.top
			anchors.horizontalCenter: parent.horizontalCenter
			color: "Black"
			opacity: 0
		}

		Rectangle {
			id: playedBonusTopId
			width: parent.paintedWidth+3
			height: parent.paintedHeight/5
			anchors.horizontalCenter: parent.horizontalCenter
			y: parent.paintedHeight*4/5
			color: "Black"
			opacity: 0
		}

		Rectangle {
			id: playedBonusBottomId
			width: parent.paintedWidth+3
			height: parent.paintedHeight/5
			anchors.horizontalCenter: parent.horizontalCenter
			y: parent.paintedHeight*3/5
			color: "Black"
			opacity: 0
		}

		MouseArea {
			anchors.fill: parent
			
			onClicked: {
				showPlayedCardId.complete()
			}
		} 
	}

	SequentialAnimation {
		id: showPlayedCardId
		running: false

		XAnimator {
			target: cardPlayedId
			from: -parent.width*0.20
			to: 0
			duration: 750
			easing.type: Easing.OutQuad
		}

		PauseAnimation {
			duration: 3500
		}
		
		XAnimator {
			target: cardPlayedId
			from: 0
			to: -parent.width*0.20
			duration: 750
			easing.type: Easing.InQuad
		}
	}
}
