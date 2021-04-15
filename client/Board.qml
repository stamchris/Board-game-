import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
import QtWebSockets 1.0
import "library"

Item {
	id: window
	property alias actionId: actionId
	property alias progressBar: underBarId.progressBar
	property alias boardId: boardId
	property alias infoJoueurId: infoJoueurId
	property alias joueurId: joueurId
	property alias popupBridge: popupBridge
	property alias popupPortal: popupPortal
	property alias chronoId: chronoId
	property alias playersChoice: playersChoice
	property alias popupChooseBarquesEffect: popupChooseBarquesEffect
	property alias popupSwapBarques: popupSwapBarques
	property alias popupSeeBarques: popupSeeBarques
	property alias popupChooseCardsToDiscard: popupChooseCardsToDiscard
	property alias popupChooseOppoEffect: popupChooseOppoEffect
	property alias popupFinish: popupFinish
	
	property string src: typeof ROOT_URL === "undefined" ? "" : ROOT_URL

	BorderImage {
		id: background1
		source: src+"images/background_image.jpg"
		anchors.fill:parent
	}

	
	Popup {
		id : popupFinish
		anchors.centerIn: parent
		width: 400
		height: 100
		modal: true
		closePolicy: Popup.CloseOnPressOutside
		
		property alias finalstateplayer : finalstateplayer
		
		background: Rectangle {
			color: "#ffd194"
			opacity: 0.3
			radius: 3
		}
		
		Text {
			id: finalstateplayer
			text : "O"
			height : parent.height/2
			width : parent.width/2
			horizontalAlignment: Text.AlignHCenter
			font.weight: Font.DemiBold
			fontSizeMode:Text.Fit
		}
				
	}
	
	
	function choosePlayers(choices, action_todo, effect, requestType, playersType, previousArgs) {
		playersChoice.action_todo = action_todo
		playersChoice.effect = effect
		playersChoice.requestType = requestType
		playersChoice.args = previousArgs
		playersChoice.msg.text = choices[0]
		playersChoice.playersType = playersType
		var plyr
		var nb_choices = 0
		for (var i = 0; i < 7; i++) {
			playersChoice.rowPlayers.children[i].visible = false
			for (var j = 0; j < window.parent.state.players.length; j++) {
				plyr = window.parent.state.players[j]
				if (plyr.type == playersType && playersChoice.rowPlayers.children[i].icon.source.toString().includes(plyr.colour) && plyr.colour != window.parent.state.color) {
					playersChoice.rowPlayers.children[i].visible = true
					nb_choices++
					break
				}
			}
		}
		if (nb_choices != 0) {
			playersChoice.choices = choices.slice(0, Math.min(nb_choices, choices.length))
			playersChoice.open()
		}
	}
	
	Popup {
		id: playersChoice
		anchors.centerIn: parent
		width: 400
		height: 100
		modal: true
		closePolicy: Popup.CloseOnPressOutside
		background: Rectangle {
			color: "#ffd194"
			opacity: 0.3
			radius: 3
		}
		property alias msg: msg
		property alias rowPlayers: rowPlayers
		property var choices : []
		property var action_todo : ""
		property var effect
		property var requestType : ""
		property var args : []
		property var playersType : "aventurier"
		
		function choosePlayer(button_color) {
			if(choices.length == 1) {
				args.push(button_color)
				window.parent.state.send({
					type: requestType,
				effet: effect,
				carte: action_todo,
				args: args
				})
				playersChoice.close()
			} else {
				choices.shift()
				args.push(button_color)
				playersChoice.msg.text = choices[0]
				var plyr
				for (var i = 0; i < 7; i++) {
					playersChoice.rowPlayers.children[i].visible = false
					for (var j = 0; j < window.parent.state.players.length; j++) {
						plyr = window.parent.state.players[j]
						if (plyr.type == playersType && playersChoice.rowPlayers.children[i].icon.source.toString().includes(plyr.colour) && !args.includes(plyr.colour) && plyr.colour != window.parent.state.color) {
							playersChoice.rowPlayers.children[i].visible = true
							break
						}
					}
				}
			}
		}
		
		Text {
			id: msg
			anchors{top: parent.top;topMargin: 2}
			horizontalAlignment: Text.AlignHCenter
			font.weight: Font.DemiBold
			fontSizeMode:Text.Fit
			text: "Choisissez un joueur"
		}
		
		RowLayout {
			id: rowPlayers
			spacing:5
			anchors{top: msg.bottom;topMargin:5}
			height: 20
			
			RoundButton {
				visible: false
				icon.color: "transparent"
				icon.source: src+"images/Red_pion.png"
				onClicked: {
					playersChoice.choosePlayer("Red")
				}
			}
			
			RoundButton {
				visible: false
				icon.color: "transparent"
				icon.source: src+"images/Cyan_pion.png"
				onClicked: {
					playersChoice.choosePlayer("Cyan")
				}
			}
			
			RoundButton {
				visible: false
				icon.color: "transparent"
				icon.source: src+"images/Green_pion.png"
				onClicked: {
					playersChoice.choosePlayer("Green")
				}
			}
			
			RoundButton {
				visible: false
				icon.color: "transparent"
				icon.source: src+"images/Blue_pion.png"
				onClicked: {
					playersChoice.choosePlayer("Blue")
				}
			}
			
			RoundButton {
				visible: false
				icon.color: "transparent"
				icon.source: src+"images/White_pion.png"
				onClicked: {
					playersChoice.choosePlayer("White")
				}
			}
			
			RoundButton {
				visible: false
				icon.color: "transparent"
				icon.source: src+"images/Pink_pion.png"
				onClicked: {
					playersChoice.choosePlayer("Pink")
				}
			}
			
			RoundButton {
				visible: false
				icon.color: "transparent"
				icon.source: src+"images/Orange_pion.png"
				onClicked: {
					playersChoice.choosePlayer("Orange")
				}
			}
		}
	}
	
	Popup {
		id: popupBridge
		anchors.centerIn: parent
		width: 190
		height: 150
		modal: true
		closePolicy: Popup.NoAutoClose
		background: Rectangle {
			color: "#ffd194"
			opacity: 0.3
			radius: 3
		}
		property alias imgPlayerBridge: imgPlayerBridge
		
		Text {
			y: 100
			horizontalAlignment: Text.AlignHCenter
			text: "Prendre le pont ?"
			font.pointSize: 12
			font.weight: Font.DemiBold
			
		}
		
		Rectangle{
			width: 80
			height: 70
			anchors.centerIn: parent
			radius: 40
			opacity: 0.8
			color: "#F6DDCC"
			Image {
				id: imgPlayerBridge
				width: 50
				height: 50
				anchors.centerIn: parent
				source: src + "images/Cyan_pion.png"
			}
		}
		
		RowLayout {
			y: 150
			x:10
			spacing:2
			width: 200
			
			RoundButton {
				radius:5
				id: yesButton
				Rectangle {
					height: 40
					width: 80
					anchors.centerIn: parent
					
					gradient: Gradient {
						GradientStop {
							position: 0
							color: "#109a61"
						}
						
						GradientStop {
							position: 1
							color: "#0a6d44"
						}
					}
					
					
					Text{
						anchors.centerIn: parent
						text: "OUI"
						font.family: "Stoneyard"
					}
				}
				
				onClicked: {
					window.parent.state.send({
						type: "bridge_confirm",
					survivor: window.parent.state.pont_queue[0],
					used: true
					})
					window.parent.state.pont_queue = []
					popupBridge.close()

					if (window.parent.state.portal_queue.length != 0) {
						popupPortal.imgPlayerPortal.source = src + "images/" + window.parent.state.portal_queue[0].colour + "_pion.png"
						popupPortal.open()
					}
				}
			}
			
			
			RoundButton {
				radius:5
				id: noButton
				
				Rectangle {
					height: 40
					width: 80
					anchors.centerIn: parent
					
					gradient: Gradient {
						GradientStop {
							position: 0
							color : "indianred"
						}
						
						GradientStop {
							position: 1
							color : "#740912"
						}
					}
					
					Text{
						anchors.centerIn: parent
						text: "NON"
						font.family: "Stoneyard"
					}
				}
				
				onClicked: {
					if (window.parent.state.pont_queue.length == 1) {
						window.parent.state.send({
							type: "bridge_confirm",
					survivor: window.parent.state.pont_queue[0],
					used: false
						})
						popupBridge.close()

						if (window.parent.state.portal_queue.length != 0) {
							popupPortal.imgPlayerPortal.source = src + "images/" + window.parent.state.portal_queue[0].colour + "_pion.png"
							popupPortal.open()
						}
					} else {
						popupBridge.imgPlayerBridge.source = src + "images/" + window.parent.state.pont_queue[1].colour + "_pion.png"
					}
					window.parent.state.pont_queue.shift()
				}
			}
		}
	}
	
	Popup {
		id: popupPortal
		anchors.centerIn: parent
		width: 200
		height: 150
		modal: true
		closePolicy: Popup.NoAutoClose
		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}
		property var queue : []
		property alias imgPlayerPortal: imgPlayerPortal
		
		Text {
			y: 100
			horizontalAlignment: Text.AlignHCenter
			text: "Prendre le portail ?"
		}
		
		Image {
			id: imgPlayerPortal
			width: 50
			height: 50
			y: 30
			horizontalAlignment: Image.AlignHCenter
			source: src + "images/Cyan_pion.png"
		}
		
		RowLayout {
			y: 150
			Button {
				text: "Oui"
				onClicked: {
					popupPortal.queue.push(window.parent.state.portal_queue[0])
					if (window.parent.state.portal_queue.length == 1) {
						window.parent.state.send({
							type: "portal_confirm",
					survivors: popupPortal.queue,
					used: true
						})
						window.parent.state.portal_queue = []
						popupPortal.close()

						if (window.parent.state.pont_queue.length != 0) {
							popupBridge.imgPlayerBridge.source = src + "images/" + window.parent.state.pont_queue[0].colour + "_pion.png"
							popupBridge.open()
						}
					} else {
						popupPortal.imgPlayerPortal.source = src + "images/" + window.parent.state.portal_queue[1].colour + "_pion.png"
					}
					window.parent.state.portal_queue.shift()
				}
			}
			
			Button {
				text: "Non"
				onClicked: {
					if (window.parent.state.portal_queue.length == 1) {
						window.parent.state.send({
							type: "portal_confirm",
					survivors: window.parent.state.portal_queue,
					used: false
						})
						popupPortal.close()

						if (window.parent.state.pont_queue.length != 0) {
							popupBridge.imgPlayerBridge.source = src + "images/" + window.parent.state.pont_queue[0].colour + "_pion.png"
							popupBridge.open()
						}
					} else {
						popupPortal.imgPlayerPortal.source = src + "images/" + window.parent.state.portal_queue[1].colour + "_pion.png"
					}
					window.parent.state.portal_queue.shift()
				}
			}
		}
	}
	
	function chooseBarquesEffect(action_todo, effect, requestType) {
		popupChooseBarquesEffect.action_todo = action_todo
		popupChooseBarquesEffect.effect = effect
		popupChooseBarquesEffect.requestType = requestType
		popupChooseBarquesEffect.args = []

		if (!window.parent.state.barque_revealed) {
			popupChooseBarquesEffect.open()
		}
	}
	
	Popup {
		id: popupChooseBarquesEffect
		anchors.centerIn: parent
		width: 230
		height: 150
		modal: true
		closePolicy: Popup.CloseOnPressOutside
		
		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}
		
		property var action_todo : ""
		property var effect
		property var requestType : ""
		property var args : []
		
		function openBarquesPopup(choice) {
			if (choice == 0) {    
				popupSeeBarques.action_todo = action_todo
				popupSeeBarques.effect = effect
				popupSeeBarques.requestType = requestType
				popupSeeBarques.args = ["0"]
				popupSeeBarques.open()
			} else {
				popupSwapBarques.action_todo = action_todo
				popupSwapBarques.effect = effect
				popupSwapBarques.requestType = requestType
				popupSwapBarques.args = ["1"]
				for (var i = 0; i < 3; i++) {
					popupSwapBarques.rowImgSwapBarque.children[choice].enabled = true
					popupSwapBarques.rowImgSwapBarque.children[i].opacity = 1
				}
				popupSwapBarques.open()
			}
			popupChooseBarquesEffect.close()
		}
		
		Text {
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: "Quelle action effectuer ?"
		}
		
		RowLayout {
			y: 50
			Button {
				text: "Voir\n1 barque"
				onClicked: {
					popupChooseBarquesEffect.openBarquesPopup(0)
				}
			}
			
			Button {
				text: "Echanger\n2 barques"
				onClicked: {
					popupChooseBarquesEffect.openBarquesPopup(1)
				}
			}
		}
	}
	
	Popup {
		id: popupSwapBarques
		anchors.centerIn: parent
		width: 200
		height: 240
		modal: true
		closePolicy: Popup.CloseOnPressOutside
		
		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}
		
		property var action_todo : ""
		property var effect
		property var requestType : ""
		property var args : []
		property alias rowImgSwapBarque: rowImgSwapBarque
		
		function swapBarques(choice) {
			args.push(choice)
			
			if (args.length < 3) {
				rowImgSwapBarque.children[choice].enabled = false
				rowImgSwapBarque.children[choice].opacity = 0.75
			} else {
				window.parent.state.send({
					type: requestType,
					effet: effect,
					carte: action_todo,
					args: args
				})
				popupSwapBarques.close()
			}
		}
		
		Text {
			id: questionSwapBarques
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: "Quelles barques echanger ?"
		}
		
		Row {
			id: rowImgSwapBarque
			y: 30
			spacing:10
			anchors.horizontalCenter: parent.horizontalCenter
			
			Image {
				id: imgSwapBarque1
				width: 50
				fillMode: Image.PreserveAspectFit
				source: "images/barque_unknown.png"
				
				MouseArea {
					anchors.fill: parent
					enabled: true
					
					onClicked: {
						popupSwapBarques.swapBarques("0")
					}
				}
			}
			
			Image {
				id: imgSwapBarque2
				width: 50
				fillMode: Image.PreserveAspectFit
				source: "images/barque_unknown.png"
				
				MouseArea {
					anchors.fill: parent
					enabled: true
					
					onClicked: {
						popupSwapBarques.swapBarques("1")
					}
				}
			}
			
			Image {
				id: imgSwapBarque3
				width: 50
				fillMode: Image.PreserveAspectFit
				source: "images/barque_unknown.png"
				
				MouseArea {
					anchors.fill: parent
					enabled: true
					
					onClicked: {
						popupSwapBarques.swapBarques("2")
					}
				}
			}
		}
	}
	
	Popup {
		id: popupSeeBarques
		anchors.centerIn: parent
		width: 200
		height: 240
		modal: true
		closePolicy: Popup.CloseOnPressOutside
		
		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}
		
		property var action_todo : ""
		property var effect
		property var requestType : ""
		property var args : []
		
		function seeBarques(choice) {
			args.push(choice)
			window.parent.state.send({
				type: requestType,
				effet: effect,
				carte: action_todo,
				args: args
			})
			popupSeeBarques.close()
		}
		
		Text {
			id: questionSeeBarques
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: "Quelle barque consulter ?"
		}
		
		Row {
			y: 30
			spacing:10
			anchors.horizontalCenter: parent.horizontalCenter
			
			Image {
				id: imgSeeBarque1
				width: 50
				fillMode: Image.PreserveAspectFit
				source: "images/barque_unknown.png"
				
				MouseArea {
					anchors.fill: parent
					
					onClicked: {
						popupSeeBarques.seeBarques("0")
					}
				}
			}
			
			Image {
				id: imgSeeBarque2
				width: 50
				fillMode: Image.PreserveAspectFit
				source: "images/barque_unknown.png"
				
				MouseArea {
					anchors.fill: parent
					
					onClicked: {
						popupSeeBarques.seeBarques("1")
					}
				}
			}
			
			Image {
				id: imgSeeBarque3
				width: 50
				fillMode: Image.PreserveAspectFit
				source: "images/barque_unknown.png"
				
				MouseArea {
					anchors.fill: parent
					
					onClicked: {
						popupSeeBarques.seeBarques("2")
					} 
				}
			}
		}
	}
	
	function chooseCardsToDiscard(action_todo, effect, amount, requestType) {
		popupChooseCardsToDiscard.action_todo = action_todo
		popupChooseCardsToDiscard.effect = effect
		popupChooseCardsToDiscard.amount = amount
		popupChooseCardsToDiscard.requestType = requestType
		popupChooseCardsToDiscard.args = []

		var nb_bonus = 0
		for (let plyr of window.parent.state.players) {
			if (plyr.colour == window.parent.state.color) {
				nb_bonus = plyr.hand.bonus_size
			}
		}
		if (requestType == "play_action" && nb_bonus >= amount || requestType == "play_bonus" && nb_bonus > amount) {
			let cards = bonusCardsHand.model;
			for(let i = 0;i < cards.length;i++){
				if(cards[i].name === action_todo){
					cards[i].nb -= 1;
					if(cards[i].nb === 0){
						cards.splice(i, 1);
					}
					break;
				}
			}
			popupChooseCardsToDiscard.rowBonus.model = cards;
			popupChooseCardsToDiscard.open()
		}
	}
	
	Popup {
		id: popupChooseCardsToDiscard
		anchors.centerIn: parent
		width: 780
		height: 190
		modal: true
		closePolicy: Popup.CloseOnPressOutside
		
		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}
		
		property alias rowBonus: rowBonus
		property var action_todo : ""
		property var effect
		property var amount
		property var requestType : ""
		property var args : []
		
		function addCardToArgs(carteBonusName) {
			args.push(carteBonusName)
			
			if (args.length == popupChooseCardsToDiscard.amount) {
				popupChooseCardsToDiscard.close()
				
				if (action_todo == '4' && effect == 1) {
					choosePlayers(["Choisissez un joueur à faire avancer de 2 cases"], action_todo, effect, "play_action", "aventurier", args)
				} else if (action_todo == 'Arro' && effect == 1) {
					choosePlayers(["Choisissez un joueur à faire avancer de 3 cases"], action_todo, effect, "play_bonus", "aventurier", args)
				} else if (action_todo == 'Fav' && effect == 1) {
					choosePlayers(["Choisissez un joueur à faire avancer de 2 cases", "Choisissez un joueur à faire avancer de 1 cases"], action_todo, effect, "play_bonus", "aventurier", args)
				} else if (action_todo == 'Oppo' && effect == 1) {
					chooseOppoEffect(action_todo, effect, requestType, args)
				} else if (action_todo == 'Sac' && effect == 1) {
					choosePlayers(["Choisissez un joueur à faire reculer de 2 cases"], action_todo, effect, "play_bonus", "aventurier", args)
				} else {
					window.parent.state.send({
						type: requestType,
					effet: effect,
					carte: action_todo,
					args: args
					}) 
				}
			}
		}
		
		Text {
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: "Choisissez " + popupChooseCardsToDiscard.amount + " carte(s) à défausser ?"
		}
		
		Row {
			y: 30
			spacing: 10
			anchors.horizontalCenter: parent.horizontalCenter
			
			Repeater {
				id: rowBonus
				model: []
				delegate: Image {
					id: selectBonusImg
					width: 100
					fillMode: Image.PreserveAspectFit
					source: "images/Carte_"+modelData.name+".png"
					
					MouseArea {
						anchors.fill: parent

						onClicked: {
							// Ces propriétés de contexte doivent être sauvegardées,
							// elles n'existeront plus si l'objet disparait.
							let repeater = rowBonus;
							let popup = popupChooseCardsToDiscard;
							let name = modelData.name;

							let cards = repeater.model;
							cards[index].nb -= 1;
							if (cards[index].nb === 0) {
								cards.splice(index, 1);
							}
							repeater.model = cards;
							popup.addCardToArgs(name);
						}
					}
				}
			}
		}
	}
	
	function chooseOppoEffect(action_todo, effect, requestType, args) {
		popupChooseOppoEffect.action_todo = action_todo
		popupChooseOppoEffect.effect = effect
		popupChooseOppoEffect.requestType = requestType
		popupChooseOppoEffect.args = args
		popupChooseOppoEffect.open()
	}
	
	Popup {
		id: popupChooseOppoEffect
		anchors.centerIn: parent
		width: 400
		height: 150
		modal: true
		closePolicy: Popup.CloseOnPressOutside
		
		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}
		
		property var action_todo : ""
		property var effect
		property var requestType : ""
		property var args : []
		
		function openPlayerChoice(choice) {
			if (choice == 1) {    
				choosePlayers(["Choisissez un joueur à faire reculer de 2 cases"], action_todo, 1, "play_bonus", "aventurier", args)
			} else {
				choosePlayers(["Choisissez un joueur à faire avancer de 2 cases"], action_todo, 2, "play_bonus", "aventurier", args)
			}
			popupChooseOppoEffect.close()
		}
		
		Text {
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: "Voulez-vous utiliser l'effet AVANCER ou RECULER ?"
		}
		
		RowLayout {
			y: 50
			Button {
				text: "Avancer"
				onClicked: {
					popupChooseOppoEffect.openPlayerChoice(2)
				}
			}
			
			Button {
				text: "Reculer"
				onClicked: {
					popupChooseOppoEffect.openPlayerChoice(1)
				}
			}
		}
	}
	
	ImagePopUp {
		id: imgEffetDeCarteId
		source: "images/effetDeCarte.jpg"
	}
	
	Rectangle {
		id: menuBarId
		height: 60
		color: "transparent"
		anchors { 
			left: parent.left;
			right: parent.right;
			top: parent.top
		}
		
		gradient: Gradient {
			GradientStop {
				position: 0
				color : "indianred"
			}
			
			GradientStop {
				position: 1
				color : "#740912"
			}
		}
		
		Image {
			id: imglogoId
			width: 120
			height: 50
			horizontalAlignment: Image.AlignHCenter
			source: "images/cerbere_logo.png"
			fillMode: Image.PreserveAspectFit
			
			anchors {
				bottom: parent.bottom;
				left: parent.left;
				top: parent.top;
				leftMargin: 8;
				topMargin: 5 
			}
		}
		
		Rectangle {
			id: loginId
			width: 50
			height: 50
			color: "#e8e1cd"
			radius: 40
			border.color: "#740912"
			border.width: 2
			
			anchors {
				right: parent.right;
				top: parent.top;
				topMargin: 5;
				rightMargin: 10
			}
			
			Text {
				id: loginTextId
				text: qsTr("Button")
				anchors.centerIn: parent
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
			}
		}
		
		Rectangle {
			id: sonId
			width: 50
			height: 50
			color: "#e8e1cd"
			radius: 40
			border.color: "#740912"
			border.width: 2
			
			anchors {
				right: loginId.left;
				top: parent.top;
				topMargin: 5;
				rightMargin: 10
			}
			
			Text {
				id: sonTextId
				text: qsTr("Son")
				anchors.centerIn: parent
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
			}
		}
		
		Rectangle {
			id: bugId
			width: 50
			height: 50
			color: "#e8e1cd"
			radius: 40
			border.color: "#740912"
			border.width: 2
			
			anchors {
				right: sonId.left;
				top: parent.top;
				topMargin: 5;
				rightMargin: 10
			}
			
			Text {
				id: bugTextId
				text: qsTr("Bug")
				anchors.centerIn: parent
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
			}
		}
		
		Rectangle {
			id: effetcarteId
			width: 50
			height: 50
			color: "#e8e1cd"
			radius: 40
			border.color: "#740912"
			border.width: 2
			
			anchors {
				right: bugId.left;
				top: parent.top;
				topMargin: 5;
				rightMargin: 10
			}
			
			Text {
				id: effetcarteTextId
				text: qsTr("Effet \nCarte")
				anchors.centerIn: parent
				font.pixelSize: 12
				horizontalAlignment: Text.AlignHCenter
				fontSizeMode: Text.FixedSize
			}
			
			MouseArea {
				anchors.fill: parent
				
				onClicked: {
					if (imgEffetDeCarteId.visible == false) {
						imgEffetDeCarteId.visible = true
					} else {
						imgEffetDeCarteId.visible = false
					}
				}
			}
		}
		
		Rectangle {
			id: regleId
			width: 50
			height: 50
			color: "#e8e1cd"
			radius: 40
			border.color: "#740912"
			border.width: 2
			
			anchors {
				right: bugId.left;
				top: parent.top;
				topMargin: 5;
				rightMargin: 66
			}
			
			Text {
				id: regleTextId
				text: qsTr("Regles")
				anchors.centerIn: parent
				font.pixelSize: 12
				fontSizeMode: Text.FixedSize
			}
			
			MouseArea {
				visible: true
				anchors.fill: parent
				
				onClicked: {
					var component = Qt.createComponent("library/ReglesDuJeu.qml")
					if(component.status == Component.Ready){
						var window = component.createObject("window2")
						window.show()
					}else if(component.status == Component.Error){
						console.error(component.errorString());
					}
				}
			}
		}
	}
	
	Rectangle {
		id: underBarId
		height: 68
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.top: menuBarId.bottom
		property alias actionId: actionId
		property alias progressBar: progressBarId
		property alias chronoId: chronoId
		color: "transparent"
		
		Rectangle {
			id: chronoId
			width: underBarId.width*1/10
			height: underBarId.height
			border.color: "#740912"
			border.width: 2
			color: "transparent"
			
			anchors {
				left: underBarId.left;
				top: underBarId.top;
			}
			
			function updateTime(newMinutes, newSeconds){
				var newTime = newMinutes + " : " + newSeconds
				if (newSeconds < 10) {
					newTime = newMinutes + " : 0" + newSeconds
				} else {
					newTime = newMinutes + " : " + newSeconds
				}
				chronoTimeId.text = newTime
			}
			
			Image {
				id: img_chrono
				width: parent.height - 8
				source : "images/chrono.png"
				fillMode: Image.PreserveAspectFit
				
				anchors {
					verticalCenter: parent.verticalCenter
					left: parent.left; 
					leftMargin : 4; 
					top: parent.top;
				}
			}
			
			Rectangle {
				height: parent.height - 4
				width: parent.width - parent.height - 4
				color: "transparent"
				
				anchors {
					left : img_chrono.right;
					leftMargin: 4
					verticalCenter: parent.verticalCenter
				}
				
				Text {
					id: chronoTimeId
					verticalAlignment: Text.AlignVCenter
					color: "#740912"
					text: "0 : 00"
					font.pixelSize: 22
					font.bold: true
					anchors.centerIn: parent
				}
			}
		}
		
		Rectangle {
			id: progressBarId
			width: underBarId.width*7/10
			height: underBarId.height
			color: "transparent"
			
			anchors {
				top:underBarId.top;
				left: chronoId.right;
			}
			
			CerbereBar{
				id: cerbereBar
			}
			
			function updateVitesse() {
				cerbereBar.updateVitesse(window.parent.state.vitesse)
			}
			
			function updateRage() {
				cerbereBar.updateRage(window.parent.state.rage)
			}
			
			function updateBar() {
				cerbereBar.updateBar(window.parent.state.players)
			}
			
			function addToBar(player_color) {
				cerbereBar.addToBar(player_color)
			}
		}
		
		Rectangle {
			id: actionId
			height: underBarId.height
			width: underBarId.width*2/10
			border.color: "#740912"
			border.width: 2
			property var currentPlayerTimer: 60
			color: "transparent"
			
			anchors {
				top: underBarId.top;
				left: progressBarId.right;
			}
			
			Rectangle {
				height: parent.height - 4
				width: parent.width - 4
				anchors.centerIn: parent
				
				Rectangle {
					height: parent.height/2
					width:  parent.width - parent.height
					color: "transparent"
					
					anchors {
						top: parent.top
						left: parent.left
					}
					
					Text {
						id: currentPlayerId
						text: ""
						color: "Black"
						font.pixelSize: 22
						font.bold: true

						anchors {
							verticalCenter: parent.verticalCenter
							horizontalCenter: parent.horizontalCenter
						}
					}
				}

				Rectangle {
					height: parent.height/2
					width: parent.width - parent.height
					color: "transparent"

					anchors {
						bottom: parent.bottom
						left: parent.left
					}

					Text {
						text: "est en train de jouer"
						color: "Black"

						anchors {
							verticalCenter: parent.verticalCenter
							horizontalCenter: parent.horizontalCenter
						}
					}
				}

				Rectangle {
					height: parent.height
					width: parent.height
					color: "transparent"

					anchors {
						bottom: parent.bottom
						right: parent.right
					}

					Text {
						id: currentPlayerTimerId
						text: "60"
						color: "Green"
						font.pixelSize: 22
						font.bold: true

						anchors {
							verticalCenter: parent.verticalCenter
							horizontalCenter: parent.horizontalCenter
						}
					}
				}
			}

			function updateCurrentPlayer(newCurrentPlayer, newCurrentPlayerColor) {
				if (window.parent.state.currentPlayer != newCurrentPlayer) {
					currentPlayerId.text = newCurrentPlayer    
					currentPlayerId.color = newCurrentPlayerColor
					currentPlayerTimer = 61
					updateCurrentPlayerTimer()
					window.parent.state.currentPlayer = newCurrentPlayer
					window.parent.state.currentPlayerColor = newCurrentPlayerColor
				}
			}

			function updateCurrentPlayerTimer() {
				currentPlayerTimer += -1

				currentPlayerTimerId.text = currentPlayerTimer

				if (currentPlayerTimer < 10) {
					currentPlayerTimerId.color = "Red"
				} else if (currentPlayerTimer < 15) {
					currentPlayerTimerId.color = "Orange"
				} else {
					currentPlayerTimerId.color = "Green" 
				}
			}
		}
	}

	Rectangle {
		id: chatId
		height: parent.height*34/100
		width: parent.width*2/10
		color: "transparent"
		border.color: "#740912"
		border.width: 2

		anchors {
			bottom: parent.bottom;
			left: parent.left;
		}

		Chat{
			id: chatIn
			height: parent.height - 6
			width: parent.width - 6
			anchors.centerIn: parent
		}
	}

	Rectangle {
		id: plateauId
		width: parent.width

		anchors {
			top: underBarId.bottom;
			bottom: chatId.top;
		}
		
		Image {
			id: plateauImageId
			anchors.fill: parent
			horizontalAlignment: Image.AlignHCenter
			source: src+"images/plateauv3_2s.png"
			fillMode: Image.Stretch
			property alias boardId: boardId
			
			Plateau {
				id: boardId
			}     
		}
	}
					
	Rectangle {
		id: infoJoueurId
		width: parent.width*8/10
		height: 40
		color: "transparent"

		anchors {
			top: plateauId.bottom;
			left:chatId.right;
		}

		Row {
			id: rowId
			layoutDirection: Qt.RightToLeft
			anchors.fill: parent
			spacing: 1

			Rectangle {
				id: user1InfoId
				width: 1/6*parent.width
				height:parent.height
				visible: false
				radius: 3
				color: "Blue"
				border.color: "#740912"
				border.width: 1
				property alias name: text1.text
				property alias textColor: text1.color
				property alias infos: news_usr_1
				property alias rect: rect1

				Row {
					width : parent.width - 4
					height : parent.height - 4
					anchors.centerIn: parent

					Rectangle {
						id: rect1
						width : parent.width/5
						height : parent.height
						color : "transparent"
						Text {
							id: text1
							text: qsTr("USER1")
							anchors.centerIn : parent
							font.pixelSize: 15
						}
					}
					
					InfosJoueur {
						id: news_usr_1
						visible: true
					}
				}
			}

			Rectangle{
				id: user2InfoId
				width:  1/6* parent.width
				visible: false
				radius: 3
				height: parent.height
				color: "Cyan"
				border.color: "#740912"
				border.width: 1
				property alias name: text2.text
				property alias textColor: text2.color
				property alias infos: news_usr_2
				property alias rect: rect2
				
				Row {
					width : parent.width - 4
					height : parent.height - 4
					anchors.centerIn: parent
				
					Rectangle {
						id: rect2
						width : parent.width/5
						height : parent.height
						color : "transparent"

						Text {
							id: text2
							text: qsTr("USER2")
							anchors.centerIn : parent
							font.pixelSize: 15
						}
					}

					InfosJoueur {
						id: news_usr_2
						visible: true
					}
				}
			}

			Rectangle{
				id:user3InfoId
				width:1/6*  parent.width
				height: parent.height
				visible: false
				radius: 3
				color: "Orange"
				border.color: "#740912"
				border.width: 1
				property alias name: text3.text
				property alias textColor: text3.color
				property alias infos: news_usr_3
				property alias rect: rect3

				Row {
					width : parent.width - 4
					height : parent.height - 4
					anchors.centerIn: parent
					
					Rectangle {
						id: rect3
						width : parent.width/5
						height : parent.height
						color : "transparent"
						Text {
							id: text3
							text: qsTr("USER3")
							anchors.centerIn : parent
							font.pixelSize: 15
						}
					}

					InfosJoueur {
						id: news_usr_3
						visible: true
					}
				}
			}

			Rectangle{
				id:user4InfoId
				width:1/6*  parent.width
				height: parent.height
				visible: false
				radius: 3
				color: "Green"
				border.color: "#740912"
				border.width: 1
				property alias name: text4.text
				property alias textColor: text4.color
				property alias infos: news_usr_4
				property alias rect: rect4

				Row {
					width : parent.width - 4
					height : parent.height - 4
					anchors.centerIn: parent
				
					Rectangle {
						id: rect4
						width : parent.width/5
						height : parent.height
						color : "transparent"
				
						Text {
							id: text4
							text: qsTr("USER4")
							anchors.centerIn : parent
							font.pixelSize: 15               
						}
					}

					InfosJoueur {
						id: news_usr_4
						visible: true
					}
				}
			}

			Rectangle{
				id:user5InfoId
				width:1/6* parent.width
				height:  parent.height
				visible: false
				radius: 3
				color: "Red"
				border.color: "#740912"
				border.width: 1
				property alias name: text5.text
				property alias textColor: text5.color
				property alias infos: news_usr_5
				property alias rect: rect5
				
				Row {
					width : parent.width - 4
					height : parent.height - 4
					anchors.centerIn: parent
				
					Rectangle {
						id: rect5
						width : parent.width/5
						height : parent.height
						color : "transparent"
						
						Text {
							id: text5
							text: qsTr("USER5")
							anchors.centerIn : parent
							font.pixelSize: 15  
						}
					}

					InfosJoueur {
						id: news_usr_5
						visible: true
					}
				}
			}

			Rectangle{
				id:user6InfoId
				width: 1/6* parent.width
				height: parent.height
				visible: false
				radius: 3
				color: "Pink"
				border.color: "#740912"
				border.width: 1
				property alias name: text6.text
				property alias textColor: text6.color
				property alias infos: news_usr_6
				property alias rect: rect6
			
				Row {
					width : parent.width - 4
					height : parent.height - 4
					anchors.centerIn: parent
					
					Rectangle {
						id: rect6
						width : parent.width/5
						height : parent.height
						color : "transparent"
			
						Text {
							id: text6
							text: qsTr("USER6")
							anchors.centerIn : parent
							font.pixelSize: 15   
						}
					}

					InfosJoueur {
						id: news_usr_6
						visible: true
					}
				}
			}

			Rectangle{
				id:user7InfoId
				width: 1/6* parent.width
				height: parent.height
				visible: false
				radius: 3
				color: "White"
				border.color: "#740912"
				border.width: 1
				property alias name: text7.text
				property alias textColor: text7.color
				property alias infos: news_usr_7
				property alias rect: rect7
			
				Row {
					width : parent.width - 4
					height : parent.height - 4
					anchors.centerIn: parent

					Rectangle {
						id: rect7
						width : parent.width/5
						height : parent.height
						color : "transparent"
			
						Text {
							id: text7
							text: qsTr("USER7")
							anchors.centerIn : parent
							font.pixelSize: 15   
						}
					}

					InfosJoueur {
						id: news_usr_7
						visible: true
					}
				}
			}
		}

		function updatePlayerInfo(players) {
			var k

			for (var i = 0; i < players.length; i++){
				rowId.children[7-i-1].visible = true
				rowId.children[7-i-1].name = players[i].name

				if (players[i].type == "aventurier") {
					rowId.children[7-i-1].color = players[i].colour
				} else if (players[i].type == "cerbere") {
					rowId.children[7-i-1].color = "Black"
					rowId.children[7-i-1].textColor = "White"
				} else {
					rowId.children[7-i-1].visible = false
				}

				if(players[i].name != window.parent.state.login) {
					for (var j = 0; j < 4; j++) {
						k = j + 1

						if (players[i].hand.action[j] == true && players[i].type != "mort") {
							if (players[i].type == "aventurier") {
								rowId.children[7-i-1].infos.children[j+1].source = src+"images/"+players[i].colour+k+".png"
							} else {
								rowId.children[7-i-1].infos.children[j+1].source = src+"images/Cerbere"+k+".png"
							}
						} else {
							rowId.children[7-i-1].infos.children[j+1].source = src+"images/verso.png"
						}
					}
					rowId.children[7-i-1].infos.bonusSize = "" + players[i].hand.bonus_size
				} else {
					rowId.children[7-i-1].width = rowId.children[7-i-1].rect.width
					rowId.children[7-i-1].rect.width = rowId.children[7-i-1].width
					rowId.children[7-i-1].infos.visible = false
				}
			}
		}
	}

	Rectangle {
		id: joueurId
		width: parent.width*8/10
		height: parent.height*34/100 - 40
		color: "transparent"
		property var actionLocked: 0
		property var bonusLocked: 0

		anchors {
			bottom: parent.bottom;
			right: parent.right;
		}

		Rectangle {
			id: carte_Action1Id
			width: 1/8*parent.width
			height: parent.height
			anchors.left: parent.left
			property alias card: card1
			property alias source: imgCAction1.source

			Image {
				id:imgCAction1
				anchors.fill: parent
				horizontalAlignment: Image.AlignHCenter
				z: 1
				fillMode: Image.Stretch
				source: ""

				CarteAction{
					id: card1
				}
			}
		}

		Rectangle {
			id: carte_Action2Id
			width: 1/8*parent.width
			height: parent.height
			anchors.left: carte_Action1Id.right
			property alias card: card2
			property alias source: imgCAction2.source
			
			Image {
				id:imgCAction2
				anchors.fill: parent
				horizontalAlignment: Image.AlignHCenter
				z: 1
				fillMode: Image.Stretch
				source: ""

				CarteAction{
					id: card2
				}
			}
		}

		Rectangle {
			id: carte_Action3Id
			width: 1/8*parent.width
			height: parent.height
			anchors.left: carte_Action2Id.right
			property alias card: card3
			property alias source: imgCAction3.source
			
			Image {
				id: imgCAction3
				anchors.fill: parent
				horizontalAlignment: Image.AlignHCenter
				z: 1
				fillMode: Image.Stretch
				source: ""

				CarteAction{
					id: card3
				}
			}
		}

		Rectangle {
			id: carte_Action4Id
			width: 1/8*parent.width
			height: parent.height
			anchors.left: carte_Action3Id.right
			property alias card: card4
			property alias source: imgCAction4.source
			
			Image {
				id: imgCAction4
				anchors.fill: parent
				horizontalAlignment: Image.AlignHCenter
				z: 1
				fillMode: Image.Stretch
				source: ""

				CarteAction{
					id: card4
				}
			}
		}

		Rectangle {
			clip: true
			height: parent.height
			width : parent.width/2
			color: "#e8e1cd"
			anchors.left: carte_Action4Id.right

			ScrollBar{
				id: scrollBarBonus
				policy: ScrollBar.AlwaysOn
				hoverEnabled: true
				active: hovered || pressed
				orientation: Qt.Horizontal
				size: parent.width/rowbonusid.width
				anchors.left: parent.left
				anchors.right: parent.right
				anchors.bottom: parent.bottom
				z: 10
				height: parent.height/20
			}
			
			BorderImage {
				id: background2
				source: src+"images/background_image.jpg"
				anchors.fill:parent
			}

			Row {
				id : rowbonusid
				height: parent.height
				width : joueurId.width/8*7
				x: -scrollBarBonus.position*width
				
				Repeater {
					id: bonusCardsHand
					model: []
					property bool blocked: true
					delegate: Rectangle {
						id: bonusCard
						width: parent.width/7
						height: parent.height
						property alias blockableBonusCard: blockableBonusCard

						Image {
							id: imgBonus
							anchors.fill: parent
							horizontalAlignment: Image.AlignHCenter
							z: 1
							fillMode: Image.Stretch
							source: "images/Carte_"+modelData.name+".png"
							
							CarteBonus {
								id: blockableBonusCard
								blocked: bonusCardsHand.blocked
							}
							
							Rectangle {
								id: boxNumber_cb
								height : 30
								width : 30
								border.color : "white"
								color  : "transparent"
								x : parent.width - (width + 3)

								Text {
									id : txtcb1
									anchors.centerIn : parent
									text: modelData.nb
									color : "white"
								}
							}
						}
					}
				}
			}
		}

		Rectangle {
			id: skipTurnId
			height: parent.height
			width: parent.width/2
			color: "transparent"
			visible: false

			anchors {
				bottom: parent.bottom
				left: parent.left
			}

			Rectangle {
				id: skipTurnButtonId
				height: parent.height/4
				width: parent.width/4
				radius: 20
				anchors.centerIn: parent

				gradient: Gradient {
					GradientStop {
						position: 0
						color : "indianred"
					}

					GradientStop {
						position: 1
						color : "#740912"
					}
				}

				Text {
					text: "Passer mon tour"
					font.bold: true
					anchors.centerIn: parent
				}

				MouseArea {
					anchors.fill: parent

					onClicked: {
						window.parent.state.send({
							type: "skip_turn"
						})
					}  
				}
			}
		}

		function updatePlayerCards(players, active_player) {
			for(var i = 0; i < players.length; i++){
				if (players[i].name == window.parent.state.login) {
					if (i == active_player) {
						if (actionLocked == 0) {
							for (var j = 0; j < 4; j++) {
								if (players[i].hand.action[j] == true) {
									joueurId.children[j].card.unblockCard()
								}
							}
						} else {
							skipTurnId.visible = true
						}

						if (bonusLocked == 0) {
							bonusCardsHand.blocked = false;
						}
						break
					} else {
						lockActionCards()
						skipTurnId.visible = false
						lockBonusCards()
						actionLocked = 0
						bonusLocked = 0
						break
					}
				}
			}
		}

		function lockActionCards() {
			actionLocked = 1
			for (var j = 0; j < 4; j++) {
				joueurId.children[j].card.blockCard()
			}
		}

		function lockBonusCards() {
			bonusLocked = 1
			bonusCardsHand.blocked = true;
		}

		function loadActionCards(playerType) {
			if (playerType == "aventurier") {
				for (var j = 0; j < 4; j++){
					joueurId.children[j].source = src+"images/" + window.parent.state.color + (j+1) + ".png"
				}
			} else if (playerType == "cerbere") {
				for (var j = 0; j < 4; j++){
					joueurId.children[j].source = src+"images/Cerbere" + (j+1) + ".png"
				}

				bonusCardsHand.model = [];
			}
		}

		function updateBonusCard(source, type) {
			let alreadyHere = -1;
			for(let i = 0;i < bonusCardsHand.model.length;i++){
				if(bonusCardsHand.model[i].name === source){
					alreadyHere = i;
					break;
				}
			}
			if(alreadyHere === -1){
				if(type === "add"){
					let cards = bonusCardsHand.model;
					cards.push({name: source, nb: 1});
					bonusCardsHand.model = cards;
				}else if(type === "remove"){
					console.error("Impossible de retirer la carte "+source+" qui n'est pas dans la main du joueur !");
				}
			}else{
				let increment;
				if(type === "add"){
					increment = 1;
				}else if(type == "remove"){
					increment = -1;
				}
				let cards = bonusCardsHand.model;
				cards[alreadyHere].nb += increment;
				if(cards[alreadyHere].nb <= 0){
					cards.splice(alreadyHere, 1);
				}
				bonusCardsHand.model = cards;
			}
		}
	}
}
