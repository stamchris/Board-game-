import QtQuick 2.9
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import QtWebSockets 1.0

Row {
    id : rowinfos
    function changetype(player) {
        var good = -1
        var int_player = parseInt(player,10)

        good = ((int_player < 7) ? ((int_player > 0) ? good = int_player : good = -1) : good = -1)

        var source_player_choice = ""+ typejoueur.children[0].source
        var i = source_player_choice.length - 1
        var nb_slash = 0
        while(nb_slash < 2) {
            if(source_player_choice[i] == '/') 
                nb_slash += 1

            i -= 1
        }
        source_player_choice = ".."+source_player_choice.substring(i+1,source_player_choice.length)
        if ((good != -1) && (source_player_choice == "../images/aventurier_image.png")) {
            typejoueur.children[0].source = "../images/cerbere_pion.png"
            var i = 0
            while( i < 4) {
                //joueurId.children[0].children[i+4].visible = false 
                //remplacer la main du joueur (ça commence par les cartes bonus)
                //puis les cartes action ; niveau serveur c'est defausser_tout ou catch_survivor
                rowinfos.children[i+1].children[0].text = "S"
                i += 1
            }
            typejoueur.children[1].children[0].text = "0"
            
        }
        //else if(good != -1 && nb_joueur_restant <= 2) {//eliminer
            //typejoueur.children[0].source = ""
            //typejoueur.children[0].color = "black"
        //}   
    }

    width: 5/6*parent.width
    height: parent.height

    Rectangle {
        id : typejoueur
        width : parent.width/5
        height : parent.height
        color : "transparent"
        Image {
            anchors.fill : parent
            source : "../images/aventurier_image.png"

        }
        Rectangle {
            id: nb_bonus
            width : parent.width/2
            height : parent.height/2
            anchors.centerIn : parent
            border.width : 2
            border.color : "gold"
            color : "black"
            radius : 25
            Text {
                anchors.centerIn : parent
                id: nb_bonus_txt
                text : "0"
                color : "gold"
            }
        }
    }

    Rectangle {
        id:little_action1_usr
        height : parent.height
        width : parent.width/5 -2 
        border.color : "white"
        color  : "transparent"
        x : parent.width 
        Text {
            id : txt_la1_usr
            anchors.centerIn : parent
            text:"A"
            color : "white" 
        }
    }

    Rectangle {
        id:little_action2_usr
        height : parent.height
        width : parent.width/5 -2 
        border.color : "white"
        color  : "transparent"
        Text {
            id : txt_la2_usr
            anchors.centerIn : parent
            text:"A"
            color : "white" 
        }
    }

    Rectangle {
        id:little_action3_usr
        height : parent.height
        width : parent.width/5 -2 
        border.color : "white"
        color  : "transparent"
        Text {
            id : txt_la3_usr
            anchors.centerIn : parent
            text:"A"
            color : "white" 
        }
    }

    Rectangle {
        id:little_action4_usr
        height : parent.height
        width : parent.width/5 -2 
        border.color : "white"
        color  : "transparent"
        Text {
            id : txt_la4_usr
            anchors.centerIn : parent
            text:"A"
            color : "white" 
        }
    }
}

                        