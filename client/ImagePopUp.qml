import QtQuick 2.12


    Image {
              id: imgEffetDeCarteId
              width: window.width / 3
              height: window.height* 2/3
              source:"images/effetDeCarte.jpg"
              visible: false //hidden by default
              anchors.centerIn: parent
              z: 10
          }
