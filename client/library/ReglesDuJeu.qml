import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Window 2.5

Window {
	id: window2
	width: 1500
	height: 1100
	visible: true
	title: qsTr("Règles du jeu")
	
	// Quand c'est compilé, l'URL est relative à l'emplacement de l'exécutable,
	// si c'est exécuté avec qmlscene, elle est relative au dossier library
	property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL
	
	BorderImage {
        	id: background
        	source: "/images/background_image.jpg"
        	anchors.fill:parent
	}
	
	Button {
		id: btnQuitter
		text: "Quitter"
		onClicked: window2.close()
		x : 5
		y : 5
	}
	
	ScrollView {
		id: scrollViewId
		width: parent.width
		height: parent.height - 100 //sinon sur Window on voit pas la fin
		anchors.top: btnQuitter.bottom
		ScrollBar.vertical.policy: ScrollBar.AlwaysOn
		
		
		ListView {
			anchors.centerIn: parent
			focus: true
			spacing: 10
			orientation: Qt.Vertical
			
			model: ListModel {
				ListElement {
					num: 1
				}
				
				ListElement {
					num: 2
				}
				
				ListElement {
					num: 3
				}
			}
			
			delegate: Rectangle {
				width: 1200
				height: 1200
				anchors.horizontalCenter: parent.horizontalCenter
				
				Image {
					width: parent.width
					height: parent.height
					id: regle
					source: src+"images/Regle"+num+".jpg"
				}
			}
		}
	}
}
