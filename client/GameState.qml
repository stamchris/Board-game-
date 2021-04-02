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
    property var pont_queue: []
    property var portal_queue: []

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
    signal _updateActionCards(string playerType)
    signal _lockAction()
    signal _lockBonus()
    signal _addToBar(string player_color)
    signal _secondPassed(var minutes, var seconds)

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
                players[i].position == newPosition
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
        _newBonus("Carte_" + new_bonus + ".png", "add")
    }

    function discardBonus(discardedBonus) {
        _discardBonus("Carte_" + discardedBonus + ".png", "remove")
    }

    function showSwapBarque(choices) {
        _showSwapBarque(choices)
    }

    function showRevealBarque(barque) {
        _showRevealBarque(barque)
    }

    function useBridge(new_queue) {
        pont_queue = new_queue
        parent.board.popupBridge.imgPlayerBridge.source = "images/" + pont_queue[0].colour + "_pion.png"
        parent.board.popupBridge.open()
    }

    function usePortal(new_queue) {
        portal_queue = new_queue
        parent.board.popupPortal.imgPlayerPortal.source = "images/" + portal_queue[0].colour + "_pion.png"
        parent.board.popupPortal.open()
    }

    function lockCards(type) {
        if (type == "action") {
            _lockAction()
        } else if (type == "bonus") {
            _lockBonus()
        }
    }

    function initGame(newPlayers, newDifficulty) {
        players = newPlayers
        changePlayers(newPlayers, 0)
        changeDifficulty(newDifficulty)
        changeRage(8 - newPlayers.length)
        changeVitesse(3 + newDifficulty)
        changePosCerbere("0")
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
        _showPlayerPieces.connect(parent.board.boardId.pionesId.children[0].unhideNonPlayerPieces)
        _pontChanged.connect(parent.board.boardId.changepont)
        _rageChanged.connect(parent.board.progressBar.updateRage)
        _vitesseChanged.connect(parent.board.progressBar.updateVitesse)
        _updatePlayersOnBar.connect(parent.board.progressBar.updateBar)
        _newBonus.connect(parent.board.joueurId.updateBonusCard)
        _discardBonus.connect(parent.board.joueurId.updateBonusCard)
        _showSwapBarque.connect(parent.board.boardId.swapbarque)
        _showRevealBarque.connect(parent.board.boardId.revealbarque)
        _addToBar.connect(parent.board.progressBar.addToBar)
        _addToBar.connect(parent.board.boardId.pionesId.children[0].hidePlayerPiece)
        _updateActionCards.connect(parent.board.joueurId.loadActionCards)
        _secondPassed.connect(parent.board.chronoId.updateTime)
        _secondPassed.connect(parent.board.actionId.updateCurrentPlayerTimer)
        _lockAction.connect(parent.board.joueurId.lockActionCards)
        _lockBonus.connect(parent.board.joueurId.lockBonusCards)
    }
}
