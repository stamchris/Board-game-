import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
import QtWebSockets 1.0
import "library"
import "library/cards.js" as Cards

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
	property alias popupChooseBarques: popupChooseBarques
	property alias popupChooseCardsToDiscard: popupChooseCardsToDiscard
	property alias popupChooseOppoEffect: popupChooseOppoEffect
	property alias popupFinish: popupFinish
	property alias popupSabotageWhatToDo : popupSabotageWhatToDo
	
	property string src: typeof ROOT_URL === "undefined" ? "" : ROOT_URL

	/* playCard est une fonction génératrice: Elle se met en "pause" à
	 * chaque yield, et peut reprendre quand on appelle sa méthode next. On
	 * peut lui passer des "messages" en mettant des arguments dans l'appel
	 * à next (en l'occurence, on lui passe les arguments de l'événement
	 * pour lequel la popup a été appelée).
	 */
	property var generator: null
	function* playCard(cardType, cardName, dictCardName, effect){
		let todolist = Cards.CARDS[dictCardName][effect];
		let args = [];
		for(let i = 0;i < todolist.length;i++){
			if(todolist[i].type === Cards.ArgsType.NOTHING){
				args.push([]);
			}else if(todolist[i].type === Cards.ArgsType.DRAW_OTHER){
				let choices = [];
				for(let j = 0;j < todolist[i].strength;j++){
					choices.push("Choisissez un joueur à faire piocher 1 carte");
				}
				choosePlayers(choices, parent.state.playerType);
				args.push(yield);
			}else if(todolist[i].type === Cards.ArgsType.MOVE_OTHER){
				let choices = [];
				for(let j = 0;j < todolist[i].strengths.length;j++){
					let strength = todolist[i].strengths[j];
					choices.push("Choisissez un joueur à faire "+(strength > 0 ? "avancer" : "reculer")+" de "+Math.abs(strength)+" cases.");
				}
				choosePlayers(choices, "aventurier");

				// choosePlayers nous a envoyé un tableau 1D
				// mais les déplacements sont des événements
				// différents, il faut le transformer en tableau
				// 2D.
				let playersArg = yield;
				for(let j = 0;j < playersArg.length;j++){
					args.push([playersArg[j]]);
				}
				// Il se peut que playersArg ne donne pas
				// suffisamment d'arguments. Exemple: On peut
				// déplacer 4 joueurs mais on en déplace que
				// deux, alors choosePlayers nous renvoie
				// ["J1", "J2"] mais il nous faut
				// [["J1"], ["J2"], [], []]. Il faut donc le
				// remplir.
				let restants = todolist[i].strengths.length - playersArg.length;
				for(let j = 0;j < restants;j++){
					args.push([]);
				}
			}else if(todolist[i].type === Cards.ArgsType.DISCARD_ME){
				chooseCardsToDiscard(cardName, todolist[i].strength);
				args.push(yield);
			}else if(todolist[i].type === Cards.ArgsType.BARKS){
				chooseBarquesEffect();
				args.push(yield);
			}else if(todolist[i].type == Cards.ArgsType.DISCARD_OTHER){
				let choices = [];
				for(let j = 0;j < todolist[i].strength;j++){
					choices.push("Choisissez un joueur à faire défausser 1 carte");
				}
				choosePlayers(choices, "aventurier");
				args.push(yield);
			}else{
				console.error("Type d'argument inconnu: "+todolist[i].type);
			}
		}

		window.parent.state.send({
			type: "play_"+cardType,
			effet: effect,
			carte: cardName,
			args
		});

		generator = null;
	}

	function* _askSabotage(effect){
		let args = [];
		if(effect === 0){ // Défaussage forcé
			chooseCardsToDiscard("", 1);
			let cards = yield;
			args[0] = cards[0]; // tableau -> scalaire
		}else if(effect === 1){ // Sabotage
			popupSabotageWhatToDo.open();
			args[0] = yield;
			if(args[0] === 1){
				chooseCardsToDiscard("", 1);

				// chooseCardsToDiscard nous a renvoyé un tableau de
				// carte, mais il nous faut un scalaire. On récupère
				// donc le premier élément.
				let cards = yield;
				args[1] = cards[0];
			}
		}else{
			console.error("Effet inconnu pour sabotage: "+effect);
		}

		args[0] = args[0].toString();
		window.parent.state.send({
			type: "answerSabotage",
			effect,
			args
		});

		generator = null;
	}
	function askSabotage(effect){
		generator = _askSabotage(effect);
		generator.next();
	}

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
		closePolicy:  Popup.CloseOnEscape | Popup.CloseOnPressOutside //default

		property alias finalstateplayer : finalstateplayer
		
		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}
		
		Text {
			id: finalstateplayer
			text : "O"
			height : parent.height/2
			width : parent.width/2
			x : 50
			horizontalAlignment: Text.AlignHCenter
			font.weight: Font.DemiBold
			fontSizeMode:Text.Fit
		}

		Button {
			width : parent.width/2
			height : parent.height/2
			x : parent.width/2
			y : parent.height/2
			Rectangle {
				anchors.fill : parent
				Text {
					anchors.centerIn : parent
					text : "Voir resultat final"
				}
			}

			onClicked : {
				popupFinish.close()
				window.parent.view = "Fin"
			}
		}

		onAboutToHide: {
			popupFinish.close()
			window.parent.view = "Fin"
		}
	}
	
	Timer {
		id: dummyPlayersTimer
		interval: 0
		onTriggered: generator.next([])
	}
	
	function choosePlayers(choices, playersType) {
		playersChoice.args = []
		playersChoice.msg.text = choices[0]
		playersChoice.playersType = playersType
		let choosablePlayers = [];
		window.parent.state.players.forEach(player => {
			// Si ce joueur a le type voulu et que ce n'est pas
			// nous, on peut le choisir.
			if(player.type === playersType
			   && player.colour !== window.parent.state.color){
				choosablePlayers.push(player.colour);
			}
		});
		if(choosablePlayers.length !== 0) {
			playersChoiceRepeater.model = choosablePlayers;
			playersChoice.choices = choices.slice(0, choosablePlayers.length);
			playersChoice.open();
		}else{
			// Aucun joueur ne peut être sélectionné: On renvoie une
			// liste d'arguments vide.
			// On ne peut pas utiliser generator.next() toute de
			// suite, car c'est lui qui nous a appelé et il n'est
			// pas encore dans le yield. Il faut temporiser l'appel.
			dummyPlayersTimer.start();
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
		property var args : []
		property var playersType : "aventurier"
		
		function choosePlayer(button_color) {
			args.push(button_color)
			if(choices.length == 1) {
				// Tous les choix ont été faits: on rend la main
				// à playCard
				playersChoice.close()
				generator.next(args);
			} else {
				// Il y a encore des choix à faire: On continue
				choices.shift()
				playersChoice.msg.text = choices[0]
				let choosablePlayers = [];
				window.parent.state.players.forEach(player => {
					// Si ce joueur a le type voulu, que ce
					// n'est pas nous ET qu'on ne l'a pas
					// déjà choisi, on peut le choisir
					if(player.type === playersType && !args.includes(player.colour)
					   && player.colour !== window.parent.state.color){
						choosablePlayers.push(player.colour);
					}
				});
				playersChoiceRepeater.model = choosablePlayers;
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
			
			Repeater {
				id: playersChoiceRepeater
				model: []
				delegate: RoundButton {
					icon.color: "transparent"
					icon.source: src+"images/"+modelData+"_pion.png"
					onClicked: playersChoice.choosePlayer(modelData)
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
				property string player: "Cyan"
				source: src + "images/"+player+"_pion.png"
			}
		}
		
		RowLayout {
			y: 150
			x:10
			spacing:2
			width: 200
			
			Repeater {
				model: [true, false]
				delegate: RoundButton {
					radius: 5
					Rectangle {
						height: 40
						width: 80
						anchors.centerIn: parent

						gradient: Gradient {
							GradientStop {
								position: 0
								color: modelData ? "#109a61" : "indianred"
							}

							GradientStop {
								position: 1
								color: modelData ? "#0a6d44" : "#740912"
							}
						}
						
						Text {
							anchors.centerIn: parent
							text: modelData ? "OUI" : "NON"
							font.family: "Stoneyard"
						}
					}
					
					onClicked: {
						if (window.parent.state.pont_queue.length === 1 || modelData) {
							// On a accepté quelqu'un ou il n'y a plus personne à accepter
							window.parent.state.send({
								type: "bridge_confirm",
								survivor: window.parent.state.pont_queue[0],
								used: modelData
							})
							window.parent.state.pont_queue = []
							popupBridge.close()

							if (window.parent.state.portal_queue.length != 0) {
								//popupPortal.imgPlayerPortal.source = src + "images/" + window.parent.state.portal_queue[0].colour + "_pion.png"
								popupPortal.imgPlayerPortal.player = window.parent.state.portal_queue[0].colour
								popupPortal.open()
							}
						} else {
							window.parent.state.pont_queue.shift()
							popupBridge.imgPlayerBridge.player = window.parent.state.pont_queue[0].colour;
						}
					}
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
			property string player: "Cyan"
			source: src + "images/"+player+"_pion.png"
		}
		
		RowLayout {
			y: 150
			
			Repeater {
				model: [true, false]
				delegate: Button {
					text: modelData ? "Oui" : "Non"
					onClicked: {
						if(modelData){
							popupPortal.queue.push(window.parent.state.portal_queue[0])
						}
						if (window.parent.state.portal_queue.length == 1) {
							window.parent.state.send({
								type: "portal_confirm",
								survivors: popupPortal.queue,
								used: popupPortal.queue.length !== 0
							})
							popupPortal.close()

							if (window.parent.state.pont_queue.length != 0) {
								popupBridge.imgPlayerBridge.player = window.parent.state.pont_queue[0].colour
								popupBridge.open()
							}
						} else {
							popupPortal.imgPlayerPortal.player = window.parent.state.portal_queue[1].colour;
						}
						window.parent.state.portal_queue.shift()
					}
				}
			}
		}
	}
	
	function chooseBarquesEffect() {
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
		property var args : []
		
		function openBarquesPopup(choice) {
			popupChooseBarques.chosenBarques = [];
			popupChooseBarques.effect = choice;
			popupChooseBarques.nbBarquesToChoose = choice+1;
			popupChooseBarques.repeater.model = [true, true, true];
			popupChooseBarques.open();
			popupChooseBarquesEffect.close();
		}
		
		Text {
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: "Quelle action effectuer ?"
		}
		
		RowLayout {
			y: 50
			
			Repeater {
				model: 2
				delegate: Button {
					onClicked: popupChooseBarquesEffect.openBarquesPopup(index)
					
					Rectangle {
						height: parent.height
						width: parent.width
						color: "#ffd194"
						
						Image {
							anchors.fill: parent
							source: src+"images/"+(index === 0 ? "regarder" : "echange")+"_barque_icone.png"
						}
					}
				}	
			}
		}
	}
	
	Popup {
		id: popupChooseBarques
		anchors.centerIn: parent
		width: 200
		height: 240
		modal: true
		closePolicy: Popup.CloseOnPressOutside
		
		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}
		property var chosenBarques : []
		property int effect: 0
		property int nbBarquesToChoose
		property alias repeater : chooseBarquesRepeater
		
		function chooseBarque(choice){
			chosenBarques.push(choice);
			
			if(chosenBarques.length < nbBarquesToChoose){
				// Il reste une barque à choisir: On rend la
				// barque choisie transparente et on continue
				let barques = chooseBarquesRepeater.model;
				barques[choice] = false;
				chooseBarquesRepeater.model = barques;
			}else{
				// Toutes les barques ont été choisies, on rend
				// la main à playCard.
				popupChooseBarques.close();
				let args = [effect.toString()];
				chosenBarques.forEach(barque => {
					args.push(barque.toString());
				});
				generator.next(args);
			}
		}
		
		Text {
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: popupChooseBarques.effect === 0 ? "Quelle barque consulter ?" : "Quelles barques echanger ?"
		}
		
		Row {
			y: 30
			spacing: 10
			anchors.horizontalCenter: parent.horizontalCenter
			
			Repeater {
				id: chooseBarquesRepeater
				model: [true, true, true]
				delegate: Image {
					width: 50
					fillMode: Image.PreserveAspectFit
					source: "images/barque_unknown.png"
					opacity: modelData ? 1 : 0.75
					
					MouseArea {
						anchors.fill: parent
						enabled: modelData

						onClicked: popupChooseBarques.chooseBarque(index)
					}
				}
			}
		}
	}
	
	function chooseCardsToDiscard(playedCard, amount) {
		popupChooseCardsToDiscard.amount = amount
		popupChooseCardsToDiscard.args = []

		let cards = bonusCardsHand.model;
		let nbBonus = 0;
		for(let i = 0;i < cards.length;i++){
			let nb = cards[i].nb;
			if(cards[i].name === playedCard){
				cards[i].nb -= 1;
				nb -= 1;
				if(cards[i].nb === 0){
					cards.splice(i, 1);
					i--;
				}
			}
			nbBonus += nb;
		}
		if (nbBonus >= amount) {
			popupChooseCardsToDiscard.rowBonus.model = cards;
			popupChooseCardsToDiscard.open()
		}else{
			showErrorMsg("Vous devez défausser "+amount+" cartes, mais vous n'en avez que "+nbBonus+" !");
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
		property var amount
		property var args : []
		
		function addCardToArgs(carteBonusName) {
			args.push(carteBonusName)
			
			if (args.length == popupChooseCardsToDiscard.amount) {
				// On a sélectionné suffisamment de carte: On
				// rend la main au générateur qui nous a appelé
				popupChooseCardsToDiscard.close()
				generator.next(args);
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
			generator = playCard("bonus", action_todo, action_todo, choice);
			generator.next();
			popupChooseOppoEffect.close()
		}
		
		Text {
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: "Voulez-vous utiliser l'effet AVANCER ou RECULER ?"
		}
		
		RowLayout {
			y: 50
			
			Repeater {
				model: ["Avancer", "Reculer"]
				delegate: Button {
					text: modelData
					onClicked: popupChooseOppoEffect.openPlayerChoice(3-index-1)
				}
			}
		}
	}
	
	Popup {
		id: popupSabotageWhatToDo
		anchors.centerIn: parent
		width: 400
		height: 150
		modal: true

		background: Rectangle {
			color: "#ffd194"
			radius: 3
		}

		Text {
			y: 0
			horizontalAlignment: Text.AlignHCenter
			text: "Vous vous êtes fait saboté ! Préfériez-vous reculer ou défausser une carte ?"
		}

		RowLayout {
			y: 50

			Repeater {
				model: ["Reculer", "Défausser une carte"]
				delegate: Button {
					text: modelData
					onClicked: popupSabotageWhatToDo.selectOption(index)
				}
			}
		}

		function selectOption(option) {
			generator.next(option);
			popupSabotageWhatToDo.close();
		}
	}

	Popup {
		id: popupErrorMsg
		anchors.centerIn: parent
		width: txtErrorMsg.width*1.125
		height: txtErrorMsg.height*2
		closePolicy: Popup.NoAutoClose
		property alias msg: txtErrorMsg.text

		background: Rectangle {
			color: "red"
			radius: 3
		}

		Text {
			id: txtErrorMsg
			color: "white"
			horizontalAlignment: Text.AlignHCenter
		}

		Timer {
			id: errorMsgTimer
			interval: 5000
			onTriggered: popupErrorMsg.close()
		}

		function restartTimer(){
			errorMsgTimer.restart();
		}
	}

	function showErrorMsg(msg){
		popupErrorMsg.msg = msg;
		popupErrorMsg.open();
		popupErrorMsg.restartTimer();
	}

	ImagePopUp {
		id: imgEffetDeCarteId
		source: "images/effetDeCarte.png"
		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter
		
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
		id: menuBarId
		height: 60
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

		Repeater {
			id: headerButtonRepeater
			property var callbacks: {
				"Effet\nCarte": () => {
					imgEffetDeCarteId.visible ^= true
				},
				"Règles": () => {
					var component = Qt.createComponent("library/ReglesDuJeu.qml")
					if(component.status == Component.Ready){
						var window = component.createObject("window2")
						window.show()
					}else if(component.status == Component.Error){
						console.error(component.errorString());
					}
				}
			}
			model: ["Son", "Effet\nCarte", "Règles"]
			delegate: Rectangle {
				width: 50
				height: 50
				color: "#e8e1cd"
				radius: 40
				border.color: "#740912"
				border.width: 2

				anchors {
					right: index === 0 ? parent.right : headerButtonRepeater.itemAt(index-1).left
					top: parent.top
					topMargin: 5
					rightMargin: 10
				}

				Text {
					text: qsTr(modelData)
					anchors.centerIn: parent
					font.pixelSize: 12
				}

				MouseArea {
					anchors.fill: parent

					onClicked: {
						if(headerButtonRepeater.callbacks[modelData] !== undefined){
							headerButtonRepeater.callbacks[modelData]();
						}
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
				color: "transparent"

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
		border.color: "#740912"
		border.width: 1

		anchors {
			top: plateauId.bottom;
			left:chatId.right;
		}

		Row {
			id: rowId
			layoutDirection: Qt.RightToLeft
			anchors.fill: parent
			spacing: 1

			Repeater {
				id: infoRepeater
				model: []
				delegate: Rectangle {
					width: 1/6*parent.width
					height: parent.height
					radius: 3
					color: modelData.adventurer ? modelData.color : "Black"
					border.color: "#740912"
					border.width: 1
					
					Row {
						id: infoRow
						width: parent.width - 4
						height: parent.height - 4
						anchors.centerIn: parent

						Rectangle {
							id: infoRect
							width: parent.width/5
							height: parent.height
							color: "transparent"

							Text {
								text: modelData.name
								anchors.centerIn: parent
								font.pixelSize: 15
								color: modelData.adventurer ? "Black" : "White"
							}
						}
						
						InfosJoueur {
							visible: !modelData.me
							adventurer: modelData.adventurer
							actions: modelData.actions
							bonusSize: modelData.bonusSize
							color: modelData.color
						}
					}
					
					Component.onCompleted: {
						if(modelData.me){
							width = infoRect.width;
							infoRect.width = width;
						}
					}
				}
			}
		}

		function updatePlayerInfo(players) {
			let model = [];
			for(let i = players.length-1;i > -1;i--){
				let adventurer;
				if(players[i].type === "aventurier"){
					adventurer = true;
				}else if(players[i].type === "cerbere"){
					adventurer = false;
				}else{
					// On n'affiche pas les joueurs morts:
					// Au suivant !
					continue;
				}
				model.push({
					adventurer,
					name: players[i].name,
					color: players[i].colour,
					me: (players[i].name === window.parent.state.login),
					actions: players[i].hand.action,
					bonusSize: players[i].hand.bonus_size
				});
			}
			infoRepeater.model = model;
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

		Repeater {
			id: actionCardRepeater
			property bool blocked: true
			property string color: "Cyan"
			model: [true, true, true, true]
			delegate: Rectangle {
				width: 1/8*parent.width
				height: parent.height
				anchors.left: index === 0 ? parent.left : actionCardRepeater.itemAt(index-1).right

				Image {
					anchors.fill: parent
					horizontalAlignment: Image.AlignHCenter
					z: 1
					fillMode: Image.Stretch
					source: src+"images/" + actionCardRepeater.color + (index+1) + ".png"

					CarteAction{
						blocked: actionCardRepeater.blocked || !modelData
						numCard: index+1
					}
				}
			}
		}

		Rectangle {
			clip: true
			height: parent.height
			width : parent.width/2
			color: "transparent"
			anchors.left: actionCardRepeater.itemAt(actionCardRepeater.count-1).right

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
								name: modelData.name
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
							actionCardRepeater.model = players[i].hand.action;
							actionCardRepeater.blocked = false;
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
			actionCardRepeater.blocked = true
		}

		function lockBonusCards() {
			bonusLocked = 1
			bonusCardsHand.blocked = true;
		}

		function loadActionCards(playerType) {
			if (playerType == "aventurier") {
				actionCardRepeater.color = window.parent.state.color
			} else if (playerType == "cerbere") {
				actionCardRepeater.color = "Cerbere"

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
