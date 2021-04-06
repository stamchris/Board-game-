import QtQuick 2.10
import QtQuick.Controls 2.10

Rectangle {
    id: rowroot
    width: parent.width
    height: parent.height
    anchors.fill: parent
    color: "#e8e1cd"
    border.color: "#740912"
    border.width: 2

	property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL

    function updateVitesse(newVitesse) {
        cubeid.source = "../images/"+newVitesse+".png"
    }

    function updateRage(newRage) {
        var newBarColor = "#00ff00";

        switch(newRage) {
            case "1":
                newBarColor = "#00ff00";
                break;
            case "2":
                newBarColor = "#33ff00";
                break;
            case "3":
                newBarColor = "#66ff00";
                break;
            case "4":
                newBarColor = "#99ff00";
                break;
            case "5":
                newBarColor = "#ccff00";
                break;
            case "6":
                newBarColor = "#ffcc00";
                break;
            case "7":
                newBarColor = "#ff9900";
                break;
            case "8":
                newBarColor = "#ff6600";
                break;
            case "9":
                newBarColor = "#ff3300";
                break;
            case "10":
                newBarColor = "#ff0000";
                break;    
            default:
                break;
        }

        for (var i = 0; i < 10; i++) {
            if (i < newRage) {
                rageBar.children[i].color = newBarColor
            } else {
                rageBar.children[i].color = "indianred"
            }

            rageBar.children[i].children[0].visible = false

            if (i == newRage - 1) {
                rageBar.children[i].children[0].visible = true 
            }
        }
    }

    function updateBar(players) {
        var colors = ["Cyan", "Orange", "Green", "White", "Pink", "Blue", "Red"]

        for (var i = 0; i < players.length; i++) {
            for (var j = 0; j < colors.length; j++){
                if ((players[i].colour == colors[j]) && (players[i].type == "aventurier")) {
                    colors.splice(j, 1)
                    break
                }
            }
        }
        
        for (var k = 0; k < colors.length; k++) {
            rageBar.children[k].children[1].source = src+"images/" + colors[k] + "_pion.png"
        }
    }

    function addToBar(player_color) {
        var i = window.parent.state.players.length
        while (rageBar.children[i].children[1].source != "") {
            if (rageBar.children[i].children[1].source.toString().includes(player_color)) {
                return
            }
            i++
        }
        rageBar.children[i].children[1].source = src+"images/" + player_color + "_pion.png"
    }

    Rectangle {
        id: cerbereBarId
        height: parent.height*90/100
        width: parent.width - parent.height*10/100
        color: "#e8e1cd"

        anchors {
            verticalCenter: parent.verticalCenter;
            horizontalCenter: parent.horizontalCenter;
        }

        Row {
            height : parent.height
            width : parent.width
            anchors.fill: parent

            Rectangle {
                id: iconeVitesse
                height: parent.height
                width: parent.height
                color: "#e8e1cd"

                Image {
                    height: parent.height
                    width: parent.width
                    source: "../images/vitesse_icone.png"
                    fillMode: Image.PreserveAspectFit
                }   
            }

            Rectangle {
                id: vitesseCerbere
                height: parent.height
                width: parent.height
                color: "#e8e1cd"

                Image {
                    id:cubeid
                    height: parent.height
                    width: parent.width
                    source: "../images/3.png"
                    fillMode: Image.PreserveAspectFit
                }
            } 

            Rectangle{
                height: parent.height
                width: parent.height*0.5
                color: "#e8e1cd"
            }

            Rectangle {
                id: iconeRage
                height: parent.height
                width: parent.height
                color: "#e8e1cd"

                Image {
                    height : parent.height
                    width : parent.height
                    source : "../images/colere_icone.png"
                    fillMode: Image.PreserveAspectFit
                }
            }

            Row {
                id: rageBar
                height : parent.height*0.66
                width : parent.width - 3.5*parent.height
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        color: "Black"
                        text: "1"
                        anchors.centerIn: parent
                    }

                    Image {
                        height : parent.height
                        width : parent.height
                        anchors.centerIn: parent
                        source : ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text : "2"
                        color : "Black"
                        anchors.centerIn : parent
                    }

                    Image {
                        height : parent.height
                        width : parent.height
                        anchors.centerIn: parent
                        source : ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text : "3"
                        color : "Black"
                        anchors.centerIn : parent 
                    }

                    Image {
                        height : parent.height
                        width : parent.height
                        anchors.centerIn: parent
                        source : ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text : "4"
                        color : "Black"
                        anchors.centerIn : parent
                    }

                    Image {
                        height : parent.height
                        width : parent.height
                        anchors.centerIn: parent
                        source : ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text : "5"
                        color : "Black"
                        anchors.centerIn : parent
                    }

                    Image {
                        height : parent.height
                        width : parent.height
                        anchors.centerIn: parent
                        source : ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text : "6"
                        color : "Black"
                        anchors.centerIn : parent   
                    }

                    Image {
                        height : parent.height
                        width : parent.height
                        anchors.centerIn: parent
                        source : ""
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text : "7"
                        color : "Black"
                        anchors.centerIn : parent
                    }

                    Image {
                        height : parent.height
                        width : parent.height
                        anchors.centerIn: parent
                        source : ""
                        fillMode: Image.PreserveAspectFit
                    }
                }     

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text : "8"
                        color : "Black"
                        anchors.centerIn : parent 
                    }
                }

                Rectangle {
                    height: parent.height
                    width : parent.width/10
                    color : "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text: "9"
                        color: "Black"
                        anchors.centerIn: parent 
                    }
                }  

                Rectangle {
                    height: parent.height
                    width: parent.width/10
                    color: "indianred"
                    border.color: "#740912"
                    border.width: 1

                    Text {
                        visible: false
                        text: "10"
                        color: "Black"
                        anchors.centerIn: parent 
                    }
                }   
            }
        }
    }
}
