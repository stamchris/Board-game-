import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
import QtWebSockets 1.0
import "library"

Window {
    id: window
    width: 1600
    height: 720
    visible: true
    property alias plateauImageId: plateauImageId
    title: qsTr("Cerbere")
 
    ImagePopUp{
            id: imgEffetDeCarteId
            source:"images/effetDeCarte.jpg"
    }

    Rectangle {
        id: menuBarId
        height: 60
        color: "#0ba360"
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
        //border{color: "#e51111" ; width:2;}
        anchors { left: parent.left; right:parent.right; top: parent.top }


        Image {
            id: imglogoId
            width: 120
            height: 50
            anchors { bottom: parent.bottom; left:parent.left; top: parent.top; leftMargin: 8; topMargin: 5 }
            horizontalAlignment: Image.AlignHCenter
            source: "images/cerbere_logo.png"
            fillMode: Image.Stretch
        }

       Rectangle {
           id: loginId
           width: 50
           height: 50
           color: "#ffffff"
           radius: 40
           border.color: "#1143c8"
           border.width: 2
           anchors { right: parent.right ; top:parent.top; topMargin:5; rightMargin:10 }

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
            anchors { right: loginId.left; top: parent.top; topMargin: 5; rightMargin: 10 }

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
            anchors { right: sonId.left; top: parent.top; topMargin: 5; rightMargin: 10 }

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
            anchors { right: bugId.left; top: parent.top; topMargin: 5; rightMargin: 10 }

            Text {
                id: effetcarteTextId
                text: qsTr("Effet \nCarte")
                anchors.centerIn: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.FixedSize
            }

            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if (imgEffetDeCarteId.visible == false)
                        imgEffetDeCarteId.visible = true
                    else 
                        imgEffetDeCarteId.visible = false         
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
            anchors { right: bugId.left; top: parent.top; topMargin: 5; rightMargin: 66 }
            Text {
                id: regleTextId
                text: qsTr("Regles")
                anchors.centerIn: parent
                font.pixelSize: 12
                fontSizeMode: Text.FixedSize
            }
            MouseArea{
                visible: true
                anchors.fill: parent
                onClicked:{
                    var component = Qt.createComponent("library/ReglesDuJeu.qml")
                    var window    = component.createObject("window2")
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

        Rectangle {
            id: chronoId
            width: 1/10 * underBarId.width
            height: underBarId.height
            color: "#ffffff"
            border.color: "#3fe219"
            border.width: 2
            anchors { left: underBarId.left; top: underBarId.top; leftMargin:2}

            Image {
                id : img_chrono
                height : 80/100*parent.height 
                width : 50    
                anchors.verticalCenter : parent.verticalCenter 
                anchors {
                    left : parent.left ; leftMargin : 5; 
                    top : parent.top; topMargin : 10
                }
                source : "images/chrono.png"
            }

            Text {
                id: chronoTimeId
                anchors { left : img_chrono.right; leftMargin : 10; top : parent.top; topMargin : 10}
                anchors.verticalCenter : parent.verticalCenter
                verticalAlignment: Text.AlignVCenter
                width: 2*parent.width/3
                height: parent.height/5
                color: "#e51111"
                text: qsTr("01:00")
                font.pixelSize: 22
                font.bold: true
            }
        }

        Rectangle {
            id: progressBarId
            width: 6/10 * underBarId.width
            height: underBarId.height
            color: "#ffffff"
            border.color: "#f23f1e"
            border.width: 2
            anchors { top:underBarId.top; left: chronoId.right; leftMargin: 5}

            CerbereBar{}
        }

        Rectangle {
            id: actionId
            height: underBarId.height
            color: "#ffffff"
            border.color: "#3fe219"
            border.width: 2
            anchors { top: underBarId.top; left: progressBarId.right; leftMargin: 5; right: parent.right; rightMargin: 2 }
            Column {
                anchors.centerIn : parent
                Text {
                    anchors.horizontalCenter : parent.horizontalCenter
                    id : txt_player
                    text : "Player_X play ! "
                }
                Text {
                    anchors.horizontalCenter : parent.horizontalCenter
                    id : txt_timeout
                    text : "Temps restant : 5 m 36 s"
                }
            }
        }

    }

        Rectangle {
            id: chatId
            height:  34/100*parent.height
            width: 2/10 * parent.width
            color: "#ffffff"
            border.width: 2
            anchors {topMargin:0;bottom:parent.bottom;left: parent.left;leftMargin: 2; bottomMargin: 5}
        }

      

        Rectangle {
            id: plateauId
            width: parent.width
            color: "#ffffff"
            border.width: 3
            anchors {
                top: underBarId.bottom; bottom: chatId.top; right: parent.right; left: parent.left;
                topMargin: 5; bottomMargin: 2; rightMargin: 2; leftMargin: 2
            }
            Image {
                id: plateauImageId
                anchors.fill: parent
                horizontalAlignment: Image.AlignHCenter
                source: "images/plateauv3_2s.png"
                z: 1
                fillMode: Image.Stretch
            
                Plateau {
                    id: boardId
                    
                }

                Rectangle{
                    id:rectGroupsId
                    signal notifyPion ( string counter, string player) // Declare signal

                    signal notifyCard2 ( string source ) //Declare signal

                    function receiveaddCard2(source) {
                        //addCard
                        var i = 0
                        var source_string = ""
                        var found_same = - 1
                        while ((rowbonusid.children[i].visible != false) && (i< 4)) {
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
                        console.log("found_same :"+found_same)
                        if(found_same >= 0 ) {
                            //addcompteur and image
                            switch(i) {
                                case 0:
                                    var add = parseInt(txtcb1.text,10)
                                    if(add < 4) {
                                        txtcb1.text = ""+((parseInt(txtcb1.text,10)+1))
                                    }
                                    else {
                                        console.log("4 maximum")
                                    }
                                break
                                case 1:
                                    var add = parseInt(txtcb2.text,10)
                                    if(add < 4) {
                                        txtcb2.text = ""+((parseInt(txtcb2.text,10)+1))
                                    }
                                    else {
                                        console.log("4 maximum")
                                    }
                                break
                                case 2:
                                    var add = parseInt(txtcb3.text,10)
                                    if(add < 4) {
                                        txtcb3.text = ""+((parseInt(txtcb3.text,10)+1))
                                    }
                                    else {
                                        console.log("4 maximum")
                                    }   
                                break
                                case 3:
                                    var add = parseInt(txtcb4.text,10)
                                    if(add < 4) {
                                        txtcb4.text = ""+((parseInt(txtcb4.text,10)+1))
                                    }
                                    else {
                                        console.log("4 maximum")
                                    }
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

                    property int positionCounterPion1: -1
                    property int positionCounterPion2: -1
                    property int positionCounterPion3: -1
                    property int positionCounterPion4: -1
                    property int positionCounterPion5: -1
                    property int positionCounterPion6: -1
                    property int positionCounterPion7: -1

                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    height: 100
                    width: 150

                    Rectangle{
                        id:whiteId
                        color: "white"
                        height: parent.height /4
                        width: parent.width /4
                        anchors{top: parent.top;left: parent.left}
                        Text {
                            id: texxxxt
                            text: "+1"
                        }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            rectGroupsId.positionCounterPion1++
                            rectGroupsId.notifyPion(rectGroupsId.positionCounterPion1,"player1")

                        }
                    }

                    }
                    Rectangle{
                    id:blueId
                    color: "blue"
                    height: parent.height /4
                    width: parent.width /4
                    anchors{top: parent.top;left: whiteId.right}
                    Text {
                        id: texxxt
                        text: "+1"
                    }
                   MouseArea{
                       anchors.fill: parent
                    onClicked: {
                        rectGroupsId.positionCounterPion2++
                        rectGroupsId.notifyPion(rectGroupsId.positionCounterPion2,"player2")
                    }
                   }

                }
                    Rectangle{
                    id:redId
                    color: "red"
                    height: parent.height /4
                    width: parent.width /4
                    anchors{top: whiteId.bottom;left: parent.left}
                    Text {
                        id: texxt
                        text: "+1"
                    }
                   MouseArea{
                       anchors.fill: parent
                    onClicked: {
                        rectGroupsId.positionCounterPion3++
                        rectGroupsId.notifyPion(rectGroupsId.positionCounterPion3,"player3")

                    }
                   }

                }
                    Rectangle{
                        id:pinkId
                        color: "pink"
                        height: parent.height /4
                        width: parent.width /4
                        anchors{top: blueId.bottom;left: redId.right}
                        Text {
                            id: textt
                            text: "+1"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                rectGroupsId.positionCounterPion4++
                                rectGroupsId.notifyPion(rectGroupsId.positionCounterPion4,"player4")

                            }
                        }

                    }

                    Rectangle{
                        id:typechangeId
                        color: "yellow"
                        height: parent.height /4
                        width: parent.width /4
                        anchors{top: greenId.bottom;left: pinkId.right}
                        TextInput {
                                anchors.left : typechangeId.right
                                id : inputchangetype
                                text: "Plyr"
                                focus: true
                                cursorVisible: false
                                onAccepted: console.log("Accepted")
                            }

                        Text {
                            id: txtchangetype
                            color : "black"
                            text: "C/M"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {                       
                                var good = -1
                                var int_player = parseInt(inputchangetype.text,10)

                                good = ((int_player < 7) ? ((int_player > -1) ? good = int_player : good = -1) : good = -1)

                                if(good != -1) {
                                   if(good == 0) {//hand_player
                                    rectGroupsId.change_hand()
                                    }
                                    else 
                                        rowId.children[good-1].children[0].children[1].changetype(inputchangetype.text) 
                                }
                            }
                        }   
                    }


                    Rectangle{
                        id:greenId
                        color: "green"
                        height: parent.height /4
                        width: parent.width /4
                        anchors{top: parent.top;left: blueId.right}
                        Text {
                            id: texttt
                            text: "+1"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                rectGroupsId.positionCounterPion5++
                                rectGroupsId.notifyPion(rectGroupsId.positionCounterPion5,"player5")
                            }
                        }

                    }
                    Rectangle{
                        id:addCardBid
                        color: "black"
                        height: parent.height /4
                        width: parent.width /4
                        anchors.top: redId.bottom
                        TextInput {
                            anchors.left : txtaddCard.right
                            id : inputaddcard
                            text: "Image source"
                            focus: true
                            cursorVisible: false
                            onAccepted: console.log("Accepted")
                        }

                        Text {
                            id: txtaddCard
                            color : "white"
                            text: "+1CB"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                //mise en place de la liaison reseau ici pour changer 
                                // le nom de la carte à ajouter
                                rectGroupsId.notifyCard2(inputaddcard.text)
                            }
                        }

                    }
                    Rectangle{
                        id:ptid
                        color: "purple"
                        height: parent.height /4
                        width: parent.width /4
                        anchors{top: addCardBid.bottom;left: parent.left}
                        Text {
                            id: texxxtp
                            text: "Pont"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                boardId.changepont("true")    
                            }
                        }
                    }

                    Rectangle{
                        id:rbid
                        color: "orange"
                        height: parent.height /4
                        width: parent.width /4
                        anchors{top: addCardBid.bottom;left: ptid.right}
                        Text {
                            id: texxxtrb
                            text: "RB"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                boardId.revealbarque("2") //test
                            }
                        }
                    }

                    Rectangle{
                        id:sbid
                        color: "orange"
                        height: parent.height /4
                        width: parent.width /4
                        anchors{top: addCardBid.bottom;left: rbid.right}
                        Text {
                            id: texxxtsb
                            text: "SB"
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                    boardId.swapbarque("1","2")                        
                                }
                        }
                    }

                    Component.onCompleted: {
                       rectGroupsId.notifyPion.connect(boardId.receiveCounter) //connect button to Pion
                       rectGroupsId.notifyCard2.connect(receiveaddCard2) //connect button to Card
                    }
                }
            }
        }
    
    Rectangle {
        id: infoJoueurId
        width: 8/10 * parent.width
        height: 40
        color: "#ffffff"
        anchors { top: plateauId.bottom;left:chatId.right;topMargin:2;rightMargin: 2;leftMargin: 3}
        Row {
            id: rowId
            anchors.fill: parent
            spacing : (width - (rowId.children[0].width*rowId.children.length)) / (rowId.children.length - 1) - 1

            Rectangle{
                id: user1InfoId
                width: 1/6*parent.width
                height:parent.height
                radius: 3
                color: "Blue"
                x : 30
                

                Row {
                    width : parent.width
                    height : parent.height
                    Rectangle {
                        width : parent.width/5
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
                        id: news_usr_1
                    }
                }

                Component.onCompleted : {
                    news_usr_1.update_color("Blue")
                }
                
            }

            Rectangle{
                id: user2InfoId
                width:  1/6* parent.width
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
                Component.onCompleted : {
                    news_usr_2.update_color("White")
                }
            }

            Rectangle{
                id:user3InfoId
                width:1/6*  parent.width
                height: parent.height
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
                Component.onCompleted : {
                    news_usr_3.update_color("Orange")
                }
            }

            Rectangle{
                id:user4InfoId
                width:1/6*  parent.width
                height: parent.height
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
                Component.onCompleted : {
                    news_usr_4.update_color("Green")
                }
            }

            Rectangle{
                id:user5InfoId
                width:1/6* parent.width
                height:  parent.height
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
                Component.onCompleted : {
                    news_usr_5.update_color("Red")
                }
            }

            Rectangle{
                id:user6InfoId
                width: 1/6* parent.width
                height: parent.height
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
                Component.onCompleted : {
                    news_usr_6.update_color("Pink")
                }
            }
        }
    }


    Rectangle {
        id: joueurId
        width: 8/10 * parent.width
        height: 210
        color: "#ffffff"
        border.color: "#e51111"
        border.width: 2
        anchors {
            bottom: parent.bottom; left: chatId.right; right: parent.right;
            bottomMargin: 5; leftMargin: 2; rightMargin: 2
        }
        Rectangle{
            id: carte_Action1Id
            width: 1/8*parent.width
            height : parent.height
            anchors.left:parent.left
            border.color: "#000000"
            border.width: 2

            Image{
                id:imgCAction1
                anchors.fill: parent
                anchors.leftMargin:0
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source:"images/Carte1.png"
                CarteAction{}
            }
        }

        Rectangle{
            id: carte_Action2Id
            width: 1/8*parent.width
            height : parent.height
            anchors.left:carte_Action1Id.right
            border.color: "#000000"
            border.width: 2
            Image{
                id:imgCAction2
                anchors.fill: parent
                anchors.leftMargin:5
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source:"images/Carte2.png"
                CarteAction{ }
            }
        }
        Rectangle{
            id: carte_Action3Id
            width: 1/8*parent.width
            height : parent.height
            anchors.left:carte_Action2Id.right
            border.color: "#000000"
            border.width: 2
            Image{
                id : imgCAction3
                anchors.fill: parent
                anchors.leftMargin:5
                horizontalAlignment: Image.AlignHCenter
                z: 1
                fillMode: Image.Stretch
                source:"images/Carte3.png"
                CarteAction{}
            }
        }
        Rectangle{
            id: carte_Action4Id
            width: 1/8*parent.width
            height : parent.height
            anchors.left:carte_Action3Id.right
            border.color: "#000000"
            border.width: 2
            Image{
                id: imgCAction4
                anchors.fill: parent
                horizontalAlignment: Image.AlignHCenter
                z: 1
                anchors.leftMargin:5
                fillMode: Image.Stretch
                source:"images/Carte4.png"
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
            Rectangle{
                id: carte_Bonus4Id
                width: 1/8*parent.width
                height : parent.height
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

