import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
import QtWebSockets 1.0
import "library"

Item {
    id: window
    property alias playerInfo: underBarId.playerInfo
    property alias boardId: boardId
    property alias infoJoueurId: infoJoueurId

    ImagePopUp {
        id: imgEffetDeCarteId
        source: "images/effetDeCarte.jpg"
    }

    Rectangle {
        id: menuBarId
        height: 60
        color: "#0ba360"
        
        anchors { 
            left: parent.left;
            right: parent.right;
            top: parent.top
        }

        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#30cfd0"
            }

            GradientStop {
                position: 1
                color: "#330867"
            }
        }

        Image {
            id: imglogoId
            width: 120
            height: 50
            horizontalAlignment: Image.AlignHCenter
            source: "images/cerbere_logo.png"
            fillMode: Image.Stretch

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
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
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
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
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
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
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
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
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
            color: "#ffffff"
            radius: 40
            border.color: "#1143c8"
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
        color: "#ffffff"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: menuBarId.bottom
        anchors.topMargin: 5
        property alias playerInfo: actionId.playerInfo

        Rectangle {
            id: chronoId
            width: underBarId.width*1/10
            height: underBarId.height
            color: "#ffffff"
            border.color: "#3fe219"
            border.width: 2

            anchors {
                left: underBarId.left;
                top: underBarId.top;
                leftMargin:2
            }

            Text {
                id: chronoTimeId
                width: 95
                height: 17
                color: "#e51111"
                text: qsTr("01:00")
                font.pixelSize: 22
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
            }
        }

        Rectangle {
            id: progressBarId
            width: underBarId.width*6/10
            height: underBarId.height
            color: "#ffffff"
            border.color: "#f23f1e"
            border.width: 2

            anchors {
                top:underBarId.top;
                left: chronoId.right;
                leftMargin: 5
            }

            CerbereBar{}
        }

        Rectangle {
            id: actionId
            height: underBarId.height
            color: "#ffffff"
            border.color: "#3fe219"
            border.width: 2
            property alias playerInfo: playerInfoId

            anchors {
                top: underBarId.top;
                left: progressBarId.right;
                right: parent.right;
                leftMargin: 5;
                rightMargin: 2
            }

            Text {
                id: playerInfoId
                text: window.parent.state.login
                color: window.parent.state.color 

                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                function updateLogin() {
                    text: window.parent.state.login
                }

                function updateColor() {
                    color: window.parent.state.color
                }
            }
        }
    }

    Rectangle {
        id: chatId
        height: 250
        width: parent.width*2/10
        color: "#ffffff"
        border.width: 2

        anchors {
            topMargin: 0;
            bottom: parent.bottom;
            left: parent.left;
            leftMargin: 2;
            bottomMargin: 5
        }
    }

    Rectangle {
        id: plateauId
        width: parent.width
        color: "#ffffff"
        border.width: 3

        anchors {
            top: underBarId.bottom;
            bottom: chatId.top;
            right: parent.right;
            left: parent.left;
            topMargin: 5;
            bottomMargin: 2;
            rightMargin: 2;
            leftMargin: 2
        }
        
        Image {
            id: plateauImageId
            anchors.fill: parent
            horizontalAlignment: Image.AlignHCenter
            source: "images/plateauv2.jpg"
            fillMode: Image.Stretch
            property alias boardId: boardId
            
            Plateau {
                id: boardId
            }
        }

        Rectangle {
            id: rectGroupsId
            height: 200
            width: 150
            anchors.bottom: parent.bottom
            anchors.right: parent.right

            signal notifyCard2 (string source)

            function receiveaddCard2(source) {
                var i = 0
                var source_string = ""
                var found_same = - 1

                while((rowbonusid.children[i].visible != false) && (i< 4)) {
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
                    switch(i) {
                        case 0:
                            var add = parseInt(txtcb1.text, 10)

                            if(add < 4)
                                txtcb1.text = "" + ((parseInt(txtcb1.text, 10) + 1))
                            break
                        case 1:
                            var add = parseInt(txtcb2.text, 10)

                            if(add < 4)
                                txtcb2.text = "" + ((parseInt(txtcb2.text, 10) + 1))
                            break
                        case 2:
                            var add = parseInt(txtcb3.text, 10)

                            if(add < 4)
                                txtcb3.text = "" + ((parseInt(txtcb3.text, 10) + 1))
                            break
                        case 3:
                            var add = parseInt(txtcb4.text, 10)

                            if(add < 4)
                                txtcb4.text = "" + ((parseInt(txtcb4.text, 10) + 1))
                            break
                    }
                } else {
                    rowbonusid.children[i].visible = true
                    rowbonusid.children[i].children[0].source = new_source
                }
            }

            Rectangle {
                id: typechangeId
                color: "yellow"
                height: 50
                width: 50

                anchors {
                    top: parent.top;
                    left: parent.left
                }

                TextInput {  
                    id : inputchangetype
                    text: "Plyr"
                    focus: true
                    cursorVisible: false
                    anchors.left: typechangeId.right

                    onAccepted: console.log("Accepted")
                }

                Text {
                    id: txtchangetype
                    color: "black"
                    text: "C/M"
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {                       
                        var good = -1
                        var int_player = parseInt(inputchangetype.text, 10)

                        good = ((int_player < 7) ? ((int_player > 0) ? good = int_player : good = -1) : good = -1)

                        if(good != -1)
                            rowId.children[good-1].children[0].children[1].changetype(inputchangetype.text) 
                    }
                }   
            }

            Rectangle {
                id: addCardBid
                color: "black"
                height: 50
                width: 50

                anchors {
                    top: typechangeId.bottom
                    left: parent.left
                }

                TextInput {
                    anchors.left: addCardBid.right
                    id: inputaddcard
                    text: "Image source"
                    focus: true
                    cursorVisible: false

                    onAccepted: console.log("Accepted")
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
            
            Component.onCompleted: {
                rectGroupsId.notifyCard2.connect(receiveaddCard2)
            }
        }
    }
                    
    Rectangle {
        id: infoJoueurId
        width: parent.width*8/10
        height: 40
        color: "#ffffff"

        anchors {
            top: plateauId.bottom;
            left:chatId.right;
            topMargin:2;
            rightMargin: 2;
            leftMargin: 3
        }

        Row {
            id: rowId
            anchors.fill: parent

            Rectangle {
                id: user1InfoId
                width: 1/6*parent.width
                height:parent.height
                visible: false
                radius: 3
                color: "Blue"
                x : 30
                

                Row {
                    width : parent.width
                    height : parent.height
                    Rectangle {
                        width : parent.width/6
                        height : parent.height
                        color : "transparent"
                        Text {
                            //anchors.fill : parent
                            id: text1
                            text: qsTr("USER1")
                            anchors.centerIn : parent
                            font.pixelSize: 15
                        }
                    }
                    
                    InfosJoueur {
                        anchors.leftMargin : 10
                        id: news_usr_1
                    }
                }
            }

            Rectangle{
                id: user2InfoId
                width:  1/6* parent.width
                visible: false
                radius: 3
                height:parent.height
                color: "Cyan"
                
                Row {
                    width : parent.width
                    height : parent.height
        
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

                Row {
                    width : parent.width
                    height : parent.height
                
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

                Row {
                    width : parent.width
                    height : parent.height
            
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
                
                Row {
                    width : parent.width
                    height : parent.height
        
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
            
                Row {
                    width : parent.width
                    height : parent.height
                    
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
                    }
                }
            }
        }

        function updatePlayerInfo(players) {
            var order = 0
            for(var i = (6 - players.length); i < 6; i++){
                if(players[order].name != window.parent.state.login) {
                    switch(i) {
                        case 0:
                            user1InfoId.color = players[order].colour
                            user1InfoId.visible = true
                            user1InfoId.children[0].children[0].text1.text = players[order].name
                            break
                        case 1:
                            user2InfoId.color = players[order].colour
                            user2InfoId.visible = true
                            user2InfoId.children[0].children[0].text2.text = players[order].name
                            break
                        case 2:
                            user3InfoId.color = players[order].colour
                            user3InfoId.visible = true
                            user3InfoId.children[0].children[0].text3.text = players[order].name
                            break
                        case 3:
                            user4InfoId.color = players[order].colour
                            user4InfoId.visible = true
                            user4InfoId.children[0].children[0].text4.text = players[order].name
                            break
                        case 4:
                            user5InfoId.color = players[order].colour
                            user5InfoId.visible = true
                            user5InfoId.children[0].children[0].text5.text = players[order].name
                            break
                        case 5:
                            user6InfoId.color = players[order].colour
                            user6InfoId.visible = true
                            user6InfoId.children[0].children[0].text6.text = players[order].name
                            break
                        default:
                            break
                    }
                    
                    order++
                }
            }
        }
    }

    Rectangle {
        id: joueurId
        width: parent.width*8/10
        height: 210
        color: "#ffffff"
        border.color: "#e51111"
        border.width: 2

        anchors {
            bottom: parent.bottom;
            right: parent.right;
            bottomMargin: 5;
            leftMargin: 2;
            rightMargin: 2
        }

        Rectangle {
            id: carte_Action1Id
            width: 1/8*parent.width
            height: 210
            anchors.left: parent.left
            border.color: "#000000"
            border.width: 2

            Image {
                id:imgCAction1
                anchors.fill: parent
                anchors.leftMargin: 0
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source: "images/Carte1.png"

                CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action2Id
            width: 1/8*parent.width
            height: 210
            anchors.left: carte_Action1Id.right
            border.color: "#000000"
            border.width: 2
            
            Image {
                id:imgCAction2
                anchors.fill: parent
                anchors.leftMargin: 5
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source: "images/Carte2.png"

                CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action3Id
            width: 1/8*parent.width
            height: 210
            anchors.left: carte_Action2Id.right
            border.color: "#000000"
            border.width: 2
        
            Image {
               id: imgCAction3
               anchors.fill: parent
               anchors.leftMargin: 5
               horizontalAlignment: Image.AlignHCenter
               z: 1
               fillMode: Image.Stretch
               source: "images/Carte3.png"

               CarteAction{}
            }
        }

        Rectangle {
            id: carte_Action4Id
            width: 1/8*parent.width
            height: 210
            anchors.left: carte_Action3Id.right
            border.color: "#000000"
            border.width: 2
        
            Image {
                id: imgCAction4
                anchors.fill: parent
                horizontalAlignment: Image.AlignHCenter
                z: 1
                anchors.leftMargin: 5
                fillMode: Image.Stretch
                source: "images/Carte4.png"

                CarteAction{}
            }
        }

        Row {
            id : rowbonusid
            anchors.left:carte_Action4Id.right
            width : parent.width
            height : parent.height
            Rectangle {
                id : carte_Bonus1Id
                width: 1/8*parent.width
                height : parent.height
                border.color: "#000000"
                border.width: 2
                visible : false

                Image {
                    id: imgCBonus1
                    anchors.fill: parent
                    horizontalAlignment: Image.AlignHCenter
                    z: 1
                    anchors.leftMargin:5
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
                width: 1/8*parent.width
                height : parent.height
                border.color: "#000000"
                border.width: 2
                visible : false

                Image {
                    id: imgCBonus2
                    anchors.fill: parent
                    horizontalAlignment: Image.AlignHCenter
                    z: 1
                    anchors.leftMargin:5
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
                width: 1/8*parent.width
                height : parent.height
                border.color: "#000000"
                border.width: 2
                visible : false

                Image {
                    id: imgCBonus3
                    anchors.fill: parent
                    horizontalAlignment: Image.AlignHCenter
                    z: 1
                    anchors.leftMargin:5
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
                width: 1/8*parent.width
                height: parent.height
                border.color: "#000000"
                border.width: 2
                visible : false
                Image {
                    id: imgCBonus4
                    anchors.fill: parent
                    horizontalAlignment: Image.AlignHCenter
                    z: 1
                    anchors.leftMargin:5
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
        }   
    }
}

