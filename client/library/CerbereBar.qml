import QtQuick 2.12
import QtQuick.Controls 2.14



Row{
    id:rowroot
    anchors{ top: parent.top ; right: parent.right; topMargin: 3;rightMargin: 3 }
    spacing:5

    property int vitesse: 3
    signal changeVitesse()

    function incrementVitesse(){
        if (vitesse <6 )
            vitesse += 1
        else if (vitesse >= 6  && vitesse < 8)
        {
            vitesse +=1
            vitesseCerbereTextId.color = "red"
        }
        else //vitesse = 8
        {
            vitesseCerbereTextId.color ="green"
            vitesse = 3
        }
    }

    Button {
             text:"+1"
             anchors.verticalCenter: parent.verticalCenter
             width:60
             height: width
             onClicked: {
                 rowroot.changeVitesse()
             }
       }

    Text {
           id:vitesseCerbereTextId
           anchors.verticalCenter: parent.verticalCenter
           anchors.top:  parent.top
           anchors.topMargin: 15
           width: 320
           height: 60
           color: "green"
           text: "Vitesse de cerbere : " + vitesse
           horizontalAlignment: Text.AlignHCenter
           font {styleName: "Normal"; weight: Font.Bold;strikeout: false; bold: true; family: "Arial";pointSize: 16 }
       }


     Component.onCompleted: {
         changeVitesse.connect(rowroot.incrementVitesse)
     }


    Button {
          text:"+1"
          anchors.verticalCenter: parent.verticalCenter
          width:60
          height: width
          onClicked: {
                   if(cerbereBarId.value < 4)
                    {     // green
                            position0.color="#11af14"
                            position1.color="#08660a"
                    }else if(cerbereBarId.value < 7)
                    {      // orange
                           position0.color="#F19619"
                           position1.color="#AB6404"
                    }else if(cerbereBarId.value == 10)
                     {
                            cerbereBarId.value = 1
                            // vert
                            position0.color="#11af14"
                            position1.color="#08660a"
                     }
                   else{  // red
                       position0.color= "#E11C0C"
                       position1.color="#A01F14"
                     }
                   cerbereBarId.value += 1
          }


    }

    ProgressBar {
            id: cerbereBarId
            from:1
            to:10
            padding: 2
            width: 500
            height: 55
            anchors{top:parent.top;topMargin: 3}

            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: 60
                radius: 15
                gradient: Gradient {
                       GradientStop { position: 0.0; color: "#F4F6F6" }
                       GradientStop { position: 0.5; color: "#D5F5E3" }
                   }
            }

            contentItem: Item {
                implicitWidth: 200
                implicitHeight: 5

                Rectangle {

                    width: cerbereBarId.visualPosition * 460
                    height: 30
                    anchors{top:parent.top;topMargin: 15;left:parent.left;leftMargin: 15;rightMargin: 15}
                    radius: 2
                    gradient:

                    Gradient {
                        GradientStop {
                            id:position0
                            position: 0
                            color: "#11af14"

                        }
                        GradientStop {
                            id:position1
                            position: 1
                            color: "#08660a"
                        }

                    }
                }
            }
    }
}
