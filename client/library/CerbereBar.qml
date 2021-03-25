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

            rageBar.children[i].children[0].text.visible = false

            if (i == newRage - 1) {
                rageBar.children[i].children[0].text.visible = true 
            }
        }
    }

    function updateBar(players) {

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
                        color: "white"
                        text: "1"
                        anchors.centerIn: parent
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
                        color : "white"
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
                        text : "3"
                        color : "white"
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
                        text : "4"
                        color : "white"
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
                        text : "5"
                        color : "white"
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
                        text : "6"
                        color : "white"
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
                        text : "7"
                        color : "white"
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
                        text : "8"
                        color : "white"
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
                        color: "white"
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
                        color: "white"
                        anchors.centerIn: parent 
                    }
                }   
            }
        }
    }
}
