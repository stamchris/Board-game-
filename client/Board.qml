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
    property alias rectGroupsId: rectGroupsId
    property alias popupBridge: popupBridge
    property alias popupPortal: popupPortal
    property alias chronoId: chronoId
    property alias playersChoice: playersChoice

    function choosePlayers(choices, action_todo, effect) {
        playersChoice.choices = choices
        playersChoice.action_todo = action_todo
        playersChoice.effect = effect
        playersChoice.args = []
        playersChoice.msg.text = choices[0]
        var plyr
        for (var i = 0; i < 7; i++) {
            playersChoice.rowPlayers.children[i].visible = false
            for (var j = 0; j < window.parent.state.players.length; j++) {
                plyr = window.parent.state.players[j]
                if (plyr.type == "aventurier" && playersChoice.rowPlayers.children[i].icon.source.toString().includes(plyr.colour) && plyr.colour != window.parent.state.color) {
                    playersChoice.rowPlayers.children[i].visible = true
                    break
                }
            }
        }
        playersChoice.open()
    }

    Popup {
        id: playersChoice
        anchors.centerIn: parent
        width: 350
        height: 50
        modal: true
        closePolicy: Popup.NoAutoClose
        background: Rectangle {
            color: "#ffd194"
            radius: 3
        }
        property alias msg: msg
        property alias rowPlayers: rowPlayers
        property var choices : []
        property var action_todo : ""
        property var effect
        property var args : []

        function choosePlayer(button_color) {
            if(choices.length == 1) {
                args.push(button_color)
                window.parent.state.send({
                    type: "play_action",
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
                        if (plyr.type == "aventurier" && playersChoice.rowPlayers.children[i].icon.source.toString().includes(plyr.colour) && !args.includes(plyr.colour) && plyr.colour != window.parent.state.color) {
                            playersChoice.rowPlayers.children[i].visible = true
                            break
                        }
                    }
                }
            }
        }

        Text {
            id: msg
            y: 10
            horizontalAlignment: Text.AlignHCenter
            text: "Choisissez un joueur"
        }

        RowLayout {
            id: rowPlayers
            y: 50

            Button {
                visible: false
                icon.color: "transparent"
                icon.source: "images/Red_pion.png"
                onClicked: {
                    playersChoice.choosePlayer("Red")
                }
            }

            Button {
                visible: false
                icon.color: "transparent"
                icon.source: "images/Cyan_pion.png"
                onClicked: {
                    playersChoice.choosePlayer("Cyan")
                }
            }

            Button {
                visible: false
                icon.color: "transparent"
                icon.source: "images/Green_pion.png"
                onClicked: {
                    playersChoice.choosePlayer("Green")
                }
            }

            Button {
                visible: false
                icon.color: "transparent"
                icon.source: "images/Blue_pion.png"
                onClicked: {
                    playersChoice.choosePlayer("Blue")
                }
            }

            Button {
                visible: false
                icon.color: "transparent"
                icon.source: "images/White_pion.png"
                onClicked: {
                    playersChoice.choosePlayer("White")
                }
            }

            Button {
                visible: false
                icon.color: "transparent"
                icon.source: "images/Pink_pion.png"
                onClicked: {
                    playersChoice.choosePlayer("Pink")
                }
            }

            Button {
                visible: false
                icon.color: "transparent"
                icon.source: "images/Orange_pion.png"
                onClicked: {
                    playersChoice.choosePlayer("Orange")
                }
            }
        }
    }

    Popup {
        id: popupBridge
        anchors.centerIn: parent
        width: 200
        height: 150
        modal: true
        closePolicy: Popup.NoAutoClose
        background: Rectangle {
            color: "#ffd194"
            radius: 3
        }
        property alias imgPlayerBridge: imgPlayerBridge

        Text {
            y: 100
            horizontalAlignment: Text.AlignHCenter
            text: "Prendre le pont ?"
        }

        Image {
            id: imgPlayerBridge
            width: 50
            height: 50
            y: 30
            horizontalAlignment: Image.AlignHCenter
            source: "images/Cyan_pion.png"
        }

        RowLayout {
            y: 150
            Button {
                text: "Oui"
                onClicked: {
                    window.parent.state.send({
                        type: "bridge_confirm",
                        survivor: window.parent.state.pont_queue[0],
                        used: true
                    })
                    window.parent.state.pont_queue = []
                    popupBridge.close()
                }
            }

            Button {
                text: "Non"
                onClicked: {
                    if (window.parent.state.pont_queue.length == 1) {
                        window.parent.state.send({
                            type: "bridge_confirm",
                            survivor: window.parent.state.pont_queue[0],
                            used: false
                        })
                        popupBridge.close()
                    } else {
                        popupBridge.imgPlayerBridge.source = "images/" + window.parent.state.pont_queue[1].colour + "_pion.png"
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
            source: "images/Cyan_pion.png"
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
                    } else {
                        popupPortal.imgPlayerPortal.source = "images/" + window.parent.state.portal_queue[1].colour + "_pion.png"
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
                    } else {
                        popupPortal.imgPlayerPortal.source = "images/" + window.parent.state.portal_queue[1].colour + "_pion.png"
                    }
                    window.parent.state.portal_queue.shift()
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
                    var window = component.createObject("window2")
                    window.show()
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

        Rectangle {
            id: chronoId
            width: underBarId.width*1/10
            height: underBarId.height
            border.color: "#740912"
            border.width: 2
            color: "#e8e1cd"

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
                color: "#e8e1cd"

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

            anchors {
                top:underBarId.top;
                left: chronoId.right;
            }

            CerbereBar{}

            function updateVitesse() {
                progressBarId.children[0].updateVitesse(window.parent.state.vitesse)
            }

            function updateRage() {
                progressBarId.children[0].updateRage(window.parent.state.rage)
            }

            function updateBar() {
                progressBarId.children[0].updateBar(window.parent.state.players)
            }
        }

        Rectangle {
            id: actionId
            height: underBarId.height
            width: underBarId.width*2/10
            border.color: "#740912"
            border.width: 2
            property var currentPlayerTimer: 30

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
                    color: "#e8e1cd"

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
                    color: "#e8e1cd"

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
                    color: "#e8e1cd"

                    anchors {
                        bottom: parent.bottom
                        right: parent.right
                    }

                    Text {
                        id: currentPlayerTimerId
                        text: "30"
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
                currentPlayerId.text = newCurrentPlayer    
                currentPlayerId.color = newCurrentPlayerColor
                currentPlayerTimer = 31
                updateCurrentPlayerTimer()
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
        color: "#e8e1cd"
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
        property alias rectGroupsId: rectGroupsId

        anchors {
            top: underBarId.bottom;
            bottom: chatId.top;
        }
        
        Image {
            id: plateauImageId
            anchors.fill: parent
            horizontalAlignment: Image.AlignHCenter
            source: "images/plateauv3_2s.png"
            fillMode: Image.Stretch
            property alias boardId: boardId
            
            Plateau {
                id: boardId
            }
            
            Rectangle{
                id:rectGroupsId
                height: 100
                width: 150

                anchors.bottom: parent.bottom
                anchors.right: parent.right

                signal notifyCard2(string source)

                function receiveaddCard2(source) {
                    //addCard
                    var i = 0
                    var source_string = ""
                    var found_same = - 1
                    
                    while ((rowbonusid.children[i].visible != false) && (i< 7)) {
                        if(rowbonusid.children[i].children.length > 0) {
                            source_string = source_string + rowbonusid.children[i].children[0].source
                            var length2 = source_string.length
                            while(source_string[length2-1] != '/'  && length2 > 0) {
                                length2 -=1
                            }
                            var subsource_string = source_string.substring(length2,source_string.length)
                            if(subsource_string == source) {
                                found_same = i
                                break
                            }
                        }
                        i += 1
                    }

                    var new_source = "images/" + source

                    if(found_same >= 0 ) {
                        //addcompteur and image
                        switch(i) {
                            case 0:
                                var add = parseInt(txtcb1.text,10)
                                txtcb1.text = ""+((parseInt(txtcb1.text,10)+1))
                                break
                            case 1:
                                var add = parseInt(txtcb2.text,10)
                                txtcb2.text = ""+((parseInt(txtcb2.text,10)+1))
                                break
                            case 2:
                                var add = parseInt(txtcb3.text,10)
                                txtcb3.text = ""+((parseInt(txtcb3.text,10)+1))
                                break
                            case 3:
                                var add = parseInt(txtcb4.text,10)
                                txtcb4.text = ""+((parseInt(txtcb4.text,10)+1))
                                break
                            case 4:
                                var add = parseInt(txtcb4.text,10)
                                txtcb5.text = ""+((parseInt(txtcb5.text,10)+1))
                                break
                            case 5:
                                var add = parseInt(txtcb4.text,10)
                                txtcb6.text = ""+((parseInt(txtcb6.text,10)+1))
                                break
                            case 6:
                                var add = parseInt(txtcb4.text,10)
                                txtcb7.text = ""+((parseInt(txtcb7.text,10)+1))
                                break
                        }
                    }
                    else {
                        //creation 
                        rowbonusid.children[i].visible = true
                        rowbonusid.children[i].children[0].source = new_source
                    } 
                }

                function change_hand() {
                    var i = 1
                    while (i < 5) {
                        joueurId.children[i-1].children[0].source = "images/Cerbere"+i+".png"
                        i += 1
                    }
                    var i = 0
                    while (i < 4) {
                        rowbonusid.children[i].visible = false
                        rowbonusid.children[i].children[0].source = ""
                        i += 1
                    }
                }

                Rectangle {
                    id: addCardBid
                    color: "black"
                    height: 50
                    width: 50

                    anchors {
                        top: parent.top
                        left: parent.left
                    }

                    TextInput {
                        anchors.left: addCardBid.right
                        id: inputaddcard
                        text: "Image source"
                        focus: true
                        cursorVisible: false
                    }

                    Text {
                        id: txtaddCard
                        color: "white"
                        text: "+1CB"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            //mise en place de la liaison reseau ici pour changer 
                            // le nom de la carte à ajouter
                            window.playersChoice.open()
                            rectGroupsId.notifyCard2(inputaddcard.text)
                        }
                    }
                }

                Rectangle {
                    id: ptid
                    color: "purple"
                    height: 50
                    width: 50

                    anchors {
                        top: addCardBid.bottom;
                        left: parent.left
                    }

                    Text {
                        id: texxxtp
                        text: "Pont"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            boardId.changepont("true")    
                        }
                    }
                }

                Rectangle {
                    id: rbid
                    color: "orange"
                    height: 50
                    width: 50
                    anchors {
                        left: ptid.right
                        verticalCenter: ptid.verticalCenter
                    }

                    Text {
                        id: texxxtrb
                        text: "RB"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            boardId.revealbarque("2")
                        }
                    }
                }

                Rectangle {
                    id: plusOne
                    height: 50
                    width: 50
                    color: "Yellow"

                    anchors {
                        bottom: parent.bottom;
                        left: parent.left
                    }

                    Text {
                        text: "+1"

                        anchors {
                            verticalCenter: parent.verticalCenter
                            horizontalCenter: parent.horizontalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        
                        onClicked: {
                            window.parent.state.send({
                                type: "change_position",
                                change: 1,
                                login: window.parent.state.login
                            })
                        }
                    }
                }

                Rectangle {
                    id: plusTwo
                    height: 50
                    width: 50
                    color: "Orange"
                
                    anchors {
                        bottom: parent.bottom;
                        left: plusOne.right
                    }

                    Text {
                        text: "+2"

                        anchors {
                            verticalCenter: parent.verticalCenter
                            horizontalCenter: parent.horizontalCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        
                        onClicked: {
                            window.parent.state.send({
                                type: "change_position",
                                change: 2,
                                login: window.parent.state.login
                            })
                        }
                    }
                }

                Rectangle {
                    id: plusThree
                    height: 50
                    width: 50
                    color: "Red"
                
                    anchors {
                        bottom: parent.bottom;
                        left: plusTwo.right
                    }

                    Text {
                        text: "+3"

                        anchors {
                            verticalCenter: parent.verticalCenter
                            horizontalCenter: parent.horizontalCenter
                        }

                        MouseArea {
                            anchors.fill: parent
                        
                            onClicked: {
                                window.parent.state.send({
                                    type: "change_position",
                                    change: 3,
                                    login: window.parent.state.login
                                })
                            }
                        } 
                    }
                }

                Rectangle{
                    id: sbid
                    color: "orange"
                    height: parent.height /4
                    width: parent.width /4

                    anchors {
                        top: addCardBid.bottom;
                        left: rbid.right
                    }

                    Text {
                        id: texxxtsb
                        text: "SB"
                    }

                    MouseArea {
                        anchors.fill: parent

                        onClicked: {
                            boardId.swapbarque("1","2")                        
                        }
                    }
                }
        
                Component.onCompleted: {
                    rectGroupsId.notifyCard2.connect(receiveaddCard2)
                }
            }       
        }
    }
                    
    Rectangle {
        id: infoJoueurId
        width: parent.width*8/10
        height: 40
        color: "#e8e1cd"

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

                Row {
                    width : parent.width - 4
                    height : parent.height - 4
                    anchors.centerIn: parent

                    Rectangle {
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
                
                Row {
                    width : parent.width - 4
                    height : parent.height - 4
                    anchors.centerIn: parent
        
                    Rectangle {
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

                Row {
                    width : parent.width - 4
                    height : parent.height - 4
                    anchors.centerIn: parent
                
                    Rectangle {
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

                Row {
                    width : parent.width - 4
                    height : parent.height - 4
                    anchors.centerIn: parent
            
                    Rectangle {
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
                
                Row {
                    width : parent.width - 4
                    height : parent.height - 4
                    anchors.centerIn: parent
        
                    Rectangle {
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
            
                Row {
                    width : parent.width - 4
                    height : parent.height - 4
                    anchors.centerIn: parent
                    
                    Rectangle {
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
            
                Row {
                    width : parent.width - 4
                    height : parent.height - 4
                    anchors.centerIn: parent

                    Rectangle {
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
                rowId.children[7-i-1].color = players[i].colour
                rowId.children[7-i-1].visible = true
                rowId.children[7-i-1].children[0].children[0].children[0].text = players[i].name

                if(players[i].name != window.parent.state.login) {
                    for (var j = 0; j < 4; j++) {
                        k = j + 1

                        if (players[i].hand.action[j] == true) {
                            rowId.children[7-i-1].children[0].children[1].children[j+1].children[0].source = "images/"+players[i].colour+k+".png"
                        } else {
                            rowId.children[7-i-1].children[0].children[1].children[j+1].children[0].source = "images/verso.png"
                        }
                    }
                    rowId.children[7-i-1].children[0].children[1].children[0].children[1].children[0].text = "" + players[i].hand.bonus_size
                } else {
                    rowId.children[7-i-1].width = rowId.children[7-i-1].children[0].children[0].width
                    rowId.children[7-i-1].children[0].children[0].width = rowId.children[7-i-1].width
                    rowId.children[7-i-1].children[0].children[1].visible = false
                }
            }
        }
    }

    Rectangle {
        id: joueurId
        width: parent.width*8/10
        height: parent.height*34/100 - 40
        color: "#e8e1cd"

        anchors {
            bottom: parent.bottom;
            right: parent.right;
        }

        Rectangle {
            id: carte_Action1Id
            width: 1/8*parent.width
            height: parent.height
            anchors.left: parent.left

            Image {
                id:imgCAction1
                anchors.fill: parent
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source: "images/Cyan1.png"

                CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action2Id
            width: 1/8*parent.width
            height: parent.height
            anchors.left: carte_Action1Id.right
            
            Image {
                id:imgCAction2
                anchors.fill: parent
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source: "images/Cyan2.png"

                CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action3Id
            width: 1/8*parent.width
            height: parent.height
            anchors.left: carte_Action2Id.right
        
            Image {
               id: imgCAction3
               anchors.fill: parent
               horizontalAlignment: Image.AlignHCenter
               z: 1
               fillMode: Image.Stretch
               source: "images/Cyan3.png"

               CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action4Id
            width: 1/8*parent.width
            height: parent.height
            anchors.left: carte_Action3Id.right
        
            Image {
                id: imgCAction4
                anchors.fill: parent
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source: "images/Cyan4.png"

                CarteAction{}
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
            
            Row {
                id : rowbonusid
                height: parent.height
                width : joueurId.width/8*7
                x: -scrollBarBonus.position*width

                Rectangle {
                    id : carte_Bonus1Id
                    width: parent.width/7
                    height : parent.height
                    visible : false

                    Image {
                        id: imgCBonus1
                        anchors.fill: parent
                        horizontalAlignment: Image.AlignHCenter
                        z: 1
                        fillMode: Image.Stretch
                        source:"images/Carte_Ego.png"

                        CarteBonus {}
                                                            
                        Rectangle {
                            id:boxNumber_cb
                            height : 30
                            width : 30
                            border.color : "white"
                            color  : "transparent"
                            x : parent.width - (width + 3)
                            Text {
                                id : txtcb1
                                anchors.centerIn : parent
                                text:"1"
                                color : "white" 
                            }
                        }
                    }   
                }
                    
                Rectangle{
                    id: carte_Bonus2Id
                    width: parent.width/7
                    height : parent.height
                    visible : false

                    Image {
                        id: imgCBonus2
                        anchors.fill: parent
                        horizontalAlignment: Image.AlignHCenter
                        z: 1
                        fillMode: Image.Stretch
                        source:"images/Carte_Ego.png"
                        CarteBonus {}
                                                            
                        Rectangle {
                            id:boxNumber_cb2
                            height : 30
                            width : 30
                            border.color : "white"
                            color  : "transparent"
                            x : parent.width - (width + 3)
                            Text {
                                id : txtcb2
                                anchors.centerIn : parent
                                text:"1"
                                color : "white" 
                            }
                        }
                    }    
                }

                Rectangle{
                    id: carte_Bonus3Id
                    width: parent.width/7
                    height : parent.height
                    visible : false

                    Image {
                        id: imgCBonus3
                        anchors.fill: parent
                        horizontalAlignment: Image.AlignHCenter
                        z: 1
                        fillMode: Image.Stretch
                        source:"images/Carte_Ego.png"
                        CarteBonus {}
                                                            
                        Rectangle {
                            id:boxNumber_cb3
                            height : 30
                            width : 30
                            border.color : "white"
                            color  : "transparent"
                            x : parent.width - (width + 3)
                            Text {
                                id : txtcb3
                                anchors.centerIn : parent
                                text:"1"
                                color : "white" 
                            }
                        }
                    }  
                }

                Rectangle {
                    id: carte_Bonus4Id
                    width: parent.width/7
                    height: parent.height
                    visible : false
                    Image {
                        id: imgCBonus4
                        anchors.fill: parent
                        horizontalAlignment: Image.AlignHCenter
                        z: 1
                        fillMode: Image.Stretch
                        source:"images/Carte_Ego.png"
                        CarteBonus {}
                                                            
                        Rectangle {
                            id:boxNumber_cb4
                            height : 30
                            width : 30
                            border.color : "white"
                            color  : "transparent"
                            x : parent.width - (width + 3)
                            
                            Text {
                                id : txtcb4
                                anchors.centerIn : parent
                                text:"1"
                                color : "white" 
                            }
                        }
                    }    
                }

                Rectangle {
                    id: carte_Bonus5Id
                    width: parent.width/7
                    height: parent.height
                    visible : false
                    Image {
                        id: imgCBonus5
                        anchors.fill: parent
                        horizontalAlignment: Image.AlignHCenter
                        z: 1
                        fillMode: Image.Stretch
                        source:"images/Carte_Ego.png"
                        CarteBonus {}
                                                            
                        Rectangle {
                            id:boxNumber_cb5
                            height : 30
                            width : 30
                            border.color : "white"
                            color  : "transparent"
                            x : parent.width - (width + 3)
                            
                            Text {
                                id : txtcb5
                                anchors.centerIn : parent
                                text:"1"
                                color : "white" 
                            }
                        }
                    }
                }
                    
                Rectangle {
                    id: carte_Bonus6Id
                    width: parent.width/7
                    height: parent.height
                    visible : false
                    Image {
                        id: imgCBonus6
                        anchors.fill: parent
                        horizontalAlignment: Image.AlignHCenter
                        z: 1
                        fillMode: Image.Stretch
                        source:"images/Carte_Ego.png"
                        CarteBonus {}
                                                            
                        Rectangle {
                            id:boxNumber_cb6
                            height : 30
                            width : 30
                            border.color : "white"
                            color  : "transparent"
                            x : parent.width - (width + 3)
                            
                            Text {
                                id : txtcb6
                                anchors.centerIn : parent
                                text:"1"
                                color : "white" 
                            }
                        }
                    }    
                }

                Rectangle {
                    id: carte_Bonus7Id
                    width: parent.width/7
                    height: parent.height
                    visible : false
                    Image {
                        id: imgCBonus7
                        anchors.fill: parent
                        horizontalAlignment: Image.AlignHCenter
                        z: 1
                        fillMode: Image.Stretch
                        source:"images/Carte_Ego.png"
                        CarteBonus {}
                                                            
                        Rectangle {
                            id:boxNumber_cb7
                            height : 30
                            width : 30
                            border.color : "white"
                            color  : "transparent"
                            x : parent.width - (width + 3)
                            
                            Text {
                                id : txtcb7
                                anchors.centerIn : parent
                                text:"1"
                                color : "white" 
                            }
                        }
                    }    
                }
            }
        }

        function updatePlayerCards(players, active_player) {
            for(var i = 0; i < players.length; i++){
                if ((players[i].name == window.parent.state.login) && (i == active_player)) {
                    for (var j = 0; j < 4; j++) {
                        if (players[i].hand.action[j] == true) {
                            joueurId.children[j].children[0].children[0].unblockCard()
                        }
                    }

                    for (var j = 0; j < 7; j++) {
                        joueurId.children[4].children[1].children[j].children[0].children[0].unblockCard()
                    }
                    break
                } else {
                    for (var j = 0; j < 4; j++) {
                        joueurId.children[j].children[0].children[0].blockCard()
                    }

                    for (var j = 0; j < 7; j++) {
                        joueurId.children[4].children[1].children[j].children[0].children[0].blockCard()
                    }
                }
            }
        }
    }
}

