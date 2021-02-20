import QtQuick 2.12
import QtQuick.Controls 2.14



Row{
    id:rowroot
    property alias cerbereBarId: cerbereBarId
    anchors{ top: parent.top ; right: parent.right; topMargin: 3;rightMargin: 3 }
    spacing:5

    Button {
          text:"+1"
          anchors.verticalCenter: parent.verticalCenter
          width:60
          height: width
          onClicked: {
              cerbereBarId.value += 1
                    if(cerbereBarId.value == 4)
                    {
                            position0.color="#F19619"
                            position1.color="#AB6404"
                    }else if(cerbereBarId.value == 7)
                    {
                            position0.color= "#E11C0C"
                            position1.color="#A01F14"
                    }
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

               // border{ color: "#6EA523"; width:3  }
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
                    gradient: Gradient {
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
