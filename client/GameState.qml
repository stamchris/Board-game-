import QtQuick 2.10

Item{
    property string login: "login"
    property string color: "#000000"
    property int numberOfPlayers: 0
    property int difficulty: 0
    property int rage: 0
    property int vitesse: 0

    signal _loginChanged()
    signal _colorChanged()
    signal _numberOfPlayersChanged()
    signal _difficultyChanged()
    signal _rageChanged()
    signal _vitesseChanged()

    function changeLogin(newlogin){
        login = newlogin
        _loginChanged()
    }

    function changeColor(newcolor){
        color = newcolor
        _colorChanged()
    }

    function changeNumberOfPlayer(newNumberOfPlayers){
        numberOfPlayers = newNumberOfPlayers
        _numberOfPlayersChanged()
    }

    function changeDifficulty(newDifficulty){
        difficulty = newDifficulty
        _difficultyChanged()
    }

    function changeRage(newRage){
        rage = newRage
        _rageChanged()
    }

    function changeVitesse(newVitesse){
        vitesse = newVitesse()
        _vitesseChanged()
    }

    Component.onCompleted:{
        _loginChanged.connect(parent.board.playerInfo.updatePlayerInfo)
        _colorChanged.connect(parent.board.playerInfo.updatePlayerInfo)
    }
}