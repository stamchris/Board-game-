import QtQuick 2.10

Item{
	property string login: "login"
	property string color: "#000000"
	property string playerType: "aventurier"
	property string difficulty: "0"
	property string rage: "0"
	property string vitesse: "0"
	property string posCerbere: "0"
	property string pont: "1"
	property variant players: []
	property string currentPlayer : "0"
	property string currentPlayerColor : ""
	property var showfinish_player: []
	property var pont_queue: []
	property var portal_queue: []
	property var barque_revealed: false

	property string src: typeof ROOT_URL === "undefined" ? "" : ROOT_URL


	signal _currentPlayerChanged(string newCurrentPlayer, string newCurrentPlayerColor)
	signal _difficultyChanged()
	signal _rageChanged()
	signal _vitesseChanged()
	signal _playersChanged(variant players, string newTurn)
	signal _positionChanged(string newPosition, string color)
	signal _pontChanged()
	signal _showPlayerPieces(variant players)
	signal _updatePlayersOnBar(variant players)
	signal _newBonus(string newBonus, string type)
	signal _discardBonus(string discardedBonus, string type)
	signal _showSwapBarque(string barques)
	signal _showRevealBarque(string barque)
	signal _hideSwapBarque()
	signal _updateActionCards(string playerType)
	signal _lockAction()
	signal _lockBonus()
	signal _addToBar(string player_color)
	signal _secondPassed(var minutes, var seconds)
	signal _cardPlayed(string playerName, string playerColor, string cardType, string cardName, var cardEffect)

	Timer {
		id: globalTimer
		property var seconds: 0
		property var minutes: 0

		interval: 1000
		repeat: true
		running: false

		onTriggered: {
			seconds += 1

			if(seconds == 60){
				seconds = 0
				minutes += 1
			}
			
			_secondPassed(minutes, seconds)
		}
	}

	function changeDifficulty(newDifficulty) {
		difficulty = newDifficulty
		_difficultyChanged()
	}

	function changeRage(newRage) {
		rage = newRage
		_rageChanged()
	}

	function changeVitesse(newVitesse) {
		vitesse = newVitesse
		_vitesseChanged()
	}

	function changePosCerbere(newPosCerbere) {
		posCerbere = newPosCerbere
		_positionChanged(posCerbere, "Black")
	}

	function changePlayers(newPlayers, newCurrentPlayer) {
		for (var i = 0; i < newPlayers.length; i++) {
			if (newPlayers[i].type != players[i].type) {
				_addToBar(newPlayers[i].colour)
			}
		}

		players = newPlayers

		if (players[newCurrentPlayer].type == "aventurier") {
			_currentPlayerChanged(players[newCurrentPlayer].name, players[newCurrentPlayer].colour)
		} else if (players[newCurrentPlayer].type == "cerbere") {
			_currentPlayerChanged(players[newCurrentPlayer].name, "Black")   
		}
		_playersChanged(players, newCurrentPlayer)
	}

	function changeType(new_type) {
		playerType = new_type
		_updateActionCards(playerType)
	}

	function changePosition(color, newPosition) {
		for (var i = 0; i < players.length; i++) {
			if (players[i].colour == color) {
				players[i].position = newPosition
				_positionChanged(newPosition, players[i].colour)
			}
		}
	}

	function changePont(msg_pont) {
		if (pont == 1 && msg_pont == 0) { 
			pont = 0
			_pontChanged()
		}
	}

	function newBonus(new_bonus) {
		_newBonus(new_bonus, "add")
	}

	function discardBonus(discardedBonus) {
		_discardBonus(discardedBonus, "remove")
	}

	function showSwapBarque(choices) {
		_showSwapBarque(choices)
	}

	function showRevealBarque(barque) {
		barque_revealed = true
		_showRevealBarque(barque)
	}

	function hideSwapBarque() {
		_hideSwapBarque()
	}

	function showAWinner(player,pop,french_color) {
		if(pop == 1) {
			parent.board.popupFinish.finalstateplayer.color = player[0].colour
			parent.board.popupFinish.finalstateplayer.text = ""+ player[0].name + " tu as gagné jeune aventurier courageux !"
		}
		var component = Qt.createComponent("../library/StatutFin.qml")
		if(component.status == Component.Ready){
			var window = component.createObject("imageStatusid")
			console.log(window.width)
			window.parent = parent.endwindow.winnerscolumn
			window.imagestatut.source = src + "images/aventurier_image.png"
			window.imagestatut.width = Qt.binding(function() { return window.imagestatut.parent.width/2.2})
			window.imagestatut.height = Qt.binding(function() { return window.imagestatut.parent.height/1.5})
			window.imagesicone.source = src + "images/"+french_color+"_icone.png"
		}else if(component.status == Component.Error){
			console.error(component.errorString());
		}
		window.textname.text =  ""+player[0].name
		
		parent.board.popupFinish.open()
	}
	
	function showSWinner(player,pop,french_color) {
		if(pop == 1) {
			parent.board.popupFinish.finalstateplayer.color = player[0].colour
			parent.board.popupFinish.finalstateplayer.text = ""+ player[0].name + " tu as gagné jeune survivant malicieux ! "
		}
		
		var component = Qt.createComponent("../library/StatutFin.qml")
		if(component.status == Component.Ready){
			var window = component.createObject("imageStatusid")
			console.log(window.width)
			window.parent = parent.endwindow.winnerscolumn
			window.imagestatut.source = src + "images/cerbere_finaly.png"
			window.imagesicone.source = src + "images/"+french_color+"_icone.png"
		}else if(component.status == Component.Error){
			console.error(component.errorString());
		}
		window.textname.text =  ""+player[0].name
		parent.board.popupFinish.open()
		
	}
	
	function showSLoser(player,pop,french_color) {
		if(pop == 1) {
			parent.board.popupFinish.finalstateplayer.color = player[0].colour
			parent.board.popupFinish.finalstateplayer.text = ""+ player[0].name + " tu as perdu jeune survivant !"
		}
		
		var component = Qt.createComponent("../library/StatutFin.qml")
		if(component.status == Component.Ready){
			var window = component.createObject("imageStatusid")
			console.log(window.width)
			window.parent = parent.endwindow.loserscolumn
			window.imagestatut.source = src + "images/cerbere_finaly.png"
			window.imagesicone.source = src + "images/"+french_color+"_icone.png"
		}else if(component.status == Component.Error){
			console.error(component.errorString());
		}
		window.textname.text =  ""+player[0].name 
		parent.board.popupFinish.open()
		
	}
	
	function showEliminate(player,pop,french_color) {
		if(pop == 1) {
			parent.board.popupFinish.finalstateplayer.color = player[0].colour
			parent.board.popupFinish.finalstateplayer.text = ""+ player[0].name + " tu as été eliminé !"
		}
		var component = Qt.createComponent("../library/StatutFin.qml")
		if(component.status == Component.Ready){
			var window = component.createObject("imageStatusid")
			console.log(window.width)
			window.parent = parent.endwindow.loserscolumn
			window.imagestatut.source = src + "images/tombe.png"
			window.imagestatut.width = Qt.binding(function() { return window.imagestatut.parent.width/2})
			window.imagestatut.height = Qt.binding(function() { return window.imagestatut.parent.height/1.5})
			window.imagesicone.source = src + "images/"+french_color+"_icone.png"
		}else if(component.status == Component.Error){
			console.error(component.errorString());
		}
		window.textname.text =  ""+player[0].name
		parent.board.popupFinish.open()
	}
	
	
	
	function showPlayersEnd(newPlayers, status,player) {
		//status[0] cerbere_status , status[1] survivants_status
		// 0 win aventuriers, 1 win cerbere
		if(status[0] == 0) {
			parent.endwindow.titleend.text += "a perdu !"
		}else if(status[0] == 1) {
			parent.endwindow.titleend.text += "a gagné !"
		}
		
		var pop = 0
		for (var i = 0; i < newPlayers.length; i++) {
			if(newPlayers[i].colour == player.colour)
				pop = 1 //on ouvre le popup
				
				var color_player = translateColor(newPlayers[i].colour)
				if (newPlayers[i].type == "aventurier") {
					if(status[i+1] == 0){ //gagner aventurier
						showAWinner([newPlayers[i]],pop,color_player) 
					}else {
						showEliminate([newPlayers[i]],pop,color_player)
					}		
				}
				else if (newPlayers[i].type == "cerbere") {
					if(status[i+1] == 1){ //gagner cerbere
						showSWinner([newPlayers[i]],pop,color_player) 
					}else {
						showSLoser([newPlayers[i]],pop,color_player)
					}
				}
				else {
					showEliminate([newPlayers[i]],pop,color_player)
				}
				
				pop = 0  
		}
	}

	function translateColor(color) {
		var french_color = ""
		switch(color) {
			case "Green":
				french_color = "vert"
				break
			case "Orange":
				french_color = "orange"
				break
			case "Blue":
				french_color = "bleu"
				break
			case "Cyan":
				french_color = "cyan"
				break
			case "Red":
				french_color = "rouge"
				break
			case "Pink":
				french_color = "rose"
				break
			case "White":
				french_color = "blanc"
				break
		}
		return french_color
	}



	function useBridge(new_queue) {
		pont_queue = new_queue
		parent.board.popupBridge.imgPlayerBridge.source = src + "images/" + pont_queue[0].colour + "_pion.png"
		parent.board.popupBridge.open()
	}

	function usePortal(new_queue) {
		portal_queue = new_queue
		parent.board.popupPortal.imgPlayerPortal.source = src + "images/" + portal_queue[0].colour + "_pion.png"
		parent.board.popupPortal.open()
	}

	function lockCards(type) {
		if (type == "action") {
			_lockAction()
		} else if (type == "bonus") {
		_lockBonus()
		}
	}

	function askSabotage(effect) {
		parent.board.askSabotage(effect);
	}

	function showPlayedCard(playerName, playerColor, cardType, cardName, cardEffect) {
		_cardPlayed(playerName, playerColor, cardType, cardName, cardEffect)
	}
	
	function initGame(newPlayers, newDifficulty) {
		players = newPlayers
		changePlayers(newPlayers, 0)
		changeDifficulty(newDifficulty)
		changeRage(8 - newPlayers.length)
		changeVitesse(3 + newDifficulty)
		changePosCerbere("1") //old "0", ne change rien au jeu et ne fait plus bug la place de cerbere sur case 0
		_showPlayerPieces(players)
		_updatePlayersOnBar(players)
		_updateActionCards("aventurier")
		globalTimer.start()
	}
	
	Component.onCompleted: {
		_currentPlayerChanged.connect(parent.board.actionId.updateCurrentPlayer)
		_positionChanged.connect(parent.board.boardId.receiveCounter)
		_playersChanged.connect(parent.board.infoJoueurId.updatePlayerInfo)
		_playersChanged.connect(parent.board.joueurId.updatePlayerCards)
		_showPlayerPieces.connect(parent.board.boardId.pionesId.unhideNonPlayerPieces)
		_pontChanged.connect(parent.board.boardId.changepont)
		_rageChanged.connect(parent.board.progressBar.updateRage)
		_vitesseChanged.connect(parent.board.progressBar.updateVitesse)
		_updatePlayersOnBar.connect(parent.board.progressBar.updateBar)
		_newBonus.connect(parent.board.joueurId.updateBonusCard)
		_discardBonus.connect(parent.board.joueurId.updateBonusCard)
		_showSwapBarque.connect(parent.board.boardId.swapbarque)
		_showRevealBarque.connect(parent.board.boardId.revealbarque)
		_hideSwapBarque.connect(parent.board.boardId.hidebarque)
		_addToBar.connect(parent.board.progressBar.addToBar)
		_addToBar.connect(parent.board.boardId.pionesId.hidePlayerPiece)
		_updateActionCards.connect(parent.board.joueurId.loadActionCards)
		_secondPassed.connect(parent.board.chronoId.updateTime)
		_secondPassed.connect(parent.board.actionId.updateCurrentPlayerTimer)
		_lockAction.connect(parent.board.joueurId.lockActionCards)
		_lockBonus.connect(parent.board.joueurId.lockBonusCards)
		_cardPlayed.connect(parent.board.playedCardId.displayCard)
	}
}
