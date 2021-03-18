import QtQuick 2.10

Item{
    property string login: "login"
    property string color: "#000000"
    property string difficulty: "0"
    property string rage: "0"
    property string vitesse: "0"
    property string posCerbere: "0"
    property string pont: "1"
    property variant players: []
    property string active_player : "0"
    property var pont_queue: []
    property var portal_queue: []

    signal _loginChanged()
    signal _colorChanged()
    signal _difficultyChanged()
    signal _rageChanged()
    signal _vitesseChanged()
    signal _playersChanged(variant players, string new_turn)
    signal _positionChanged(string newPosition, string color)
    signal _pontChanged()
    signal _showPlayerPieces(variant players)
    signal _newBonus(string new_bonus)

    function changeLogin(newlogin) {
        login = newlogin
        _loginChanged()
    }

    function changeColor(newcolor) {
        color = newcolor
        _colorChanged()
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

    function changePlayers(newPlayers, new_turn) {
        players = newPlayers
        active_player = new_turn
        _playersChanged(players, active_player)
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
        _newBonus("Carte_" + new_bonus + ".png")
    }

    function useBridge(new_queue) {
        pont_queue = new_queue
        parent.board.popupBridge.open()
    }

    function usePortal(new_queue) {
        portal_queue = new_queue
        parent.board.popupPortal.open()
    }

    function initGame(newPlayers, newDifficulty) {
        changePlayers(newPlayers, active_player)
        changeDifficulty(newDifficulty)
        changeRage(8 - newPlayers.length)
        changeVitesse(3 + newDifficulty)
        changePosCerbere("0")
        _showPlayerPieces(players)
    }
    
    Component.onCompleted: {
        _loginChanged.connect(parent.board.playerInfo.updateLogin)
        _colorChanged.connect(parent.board.playerInfo.updateColor)
        _positionChanged.connect(parent.board.boardId.receiveCounter)
        _playersChanged.connect(parent.board.infoJoueurId.updatePlayerInfo)
        _playersChanged.connect(parent.board.joueurId.updatePlayerAction)
        _showPlayerPieces.connect(parent.board.boardId.pionesId.children[0].unhideNonPlayerPieces)
        _pontChanged.connect(parent.board.boardId.changepont)
        _rageChanged.connect(parent.board.progressBar.updateRage)
        _vitesseChanged.connect(parent.board.progressBar.updateVitesse)
        _newBonus.connect(parent.board.rectGroupsId.receiveaddCard2)
    }
}
