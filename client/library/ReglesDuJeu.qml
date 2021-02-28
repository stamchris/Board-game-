import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Window 2.5

Window {
    id: window2
    width: 1300
    height: 1100
    visible: true
    title: qsTr("Regles du jeu")



 ScrollView{
        id: scrollViewId
        width: parent.width
        height: parent.height
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn


        ListView {
            anchors.centerIn: parent
            focus:true
            orientation: Qt.Vertical

            model: ListModel{
                   ListElement{
                        name:"../images/Regle1.jpg"
                   }
                   ListElement{
                       name:"../images/Regle2.jpg"

                   }
                   ListElement{
                        name:"../images/Regle3.jpg"
                   }
            }
            delegate: Rectangle {
                width: parent.width
                height: 1000
                color: "green"

                Image {
                    width: parent.width
                    height: parent.height
                   id: regle1
                   source: name
               }
            }
       }

 }
}

