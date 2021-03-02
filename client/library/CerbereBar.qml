import QtQuick 2.10
import QtQuick.Controls 2.10

Item {
    id: rowroot
    width: parent.width
    property int vitesse: 3

    anchors {
        top: parent.top;
        left: parent.left;
        topMargin: 3;
        leftMargin: 0
    }

    signal changeVitesse()

    function incrementVitesse() {
        if(vitesse < 6) {
            vitesse += 1
        } else {
            if(vitesse < 8) {
                vitesse += 1
                vitesseCerbereTextId.color = "red"
            } else { //vitesse = 8
                vitesse = 3
                vitesseCerbereTextId.color = "green"
            }
        }
    }

    Button {
            text: "+1"
            width: parent.width*0.05
            height: 60

            anchors {
                right: vitesseCerbereTextId.left
            }

            onClicked: {
                rowroot.changeVitesse()
            }
    }

    Text {
        id: vitesseCerbereTextId
        width: parent.width*0.3
        height: 60
        color: "green"
        text: "Vitesse de cerbere : " + vitesse
        horizontalAlignment: Text.AlignHCenter

        anchors{
            top: parent.top;
            topMargin: 15;
            right: buttonCerbId.left
        }

        font {
            styleName: "Normal";
            weight: Font.Bold;
            strikeout: false;
            bold: true;
            family: "Arial";
            pointSize: 16 
        }
    }


    Component.onCompleted: {
        changeVitesse.connect(rowroot.incrementVitesse)
    }

    Button {
        id: buttonCerbId
        text: "+1"
        width: parent.width*0.05
        height: 60
        
        anchors {
            right: cerbereBarId.left
        }

        onClicked: {
            if(cerbereBarId.value < 4) { // green
                position0.color = "#11af14"
                position1.color = "#08660a"
            } else {
                if(cerbereBarId.value < 7) { // orange
                    position0.color = "#F19619"
                    position1.color = "#AB6404"
                } else {
                    if(cerbereBarId.value == 10) { // green
                        cerbereBarId.value = 1
                        position0.color = "#11af14"
                        position1.color = "#08660a"
                    } else { // red
                        position0.color= "#E11C0C"
                        position1.color="#A01F14"
                    }
                }
            }

            cerbereBarId.value += 1
        }
    }

    ProgressBar {
        id: cerbereBarId
        from: 1
        to: 10
        padding: 2
        width: parent.width*0.595
        height: 55
        
        anchors {
            right: parent.right;
            rightMargin: 3;
            top: parent.top;
            topMargin: 4
        }

        background: Rectangle {
            implicitWidth: parent.width
            implicitHeight: 60
            radius: 15

            gradient: Gradient {
                GradientStop {
                    position: 0.0;
                    color: "#F4F6F6"
                }

                GradientStop { 
                    position: 0.5;
                    color: "#D5F5E3"
                }
            }
        }

        contentItem: Item {
            implicitWidth: 200
            implicitHeight: 5

            Rectangle {
                width: cerbereBarId.visualPosition*cerbereBarId.width*0.92 //cerbereBarId.visualPosition * 460
                height: 30
                radius: 2

                anchors {
                    top:parent.top;
                    topMargin: 15;
                    left:parent.left;
                    leftMargin: 15;
                    rightMargin: 15
                }

                gradient: Gradient {
                    GradientStop {
                        id: position0
                        position: 0
                        color: "#11af14"
                    }

                    GradientStop {
                        id: position1
                        position: 1
                        color: "#08660a"
                    }
                }
            }
        }
    }
}
