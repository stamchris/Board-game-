import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Window 2.5

Window {
	id: window2
	width: 1300
	height: 1100
	visible: true
	title: qsTr("Regles du jeu")
	
	// Quand c'est compilé, l'URL est relative à l'emplacement de l'exécutable,
	// si c'est exécuté avec qmlscene, elle est relative au dossier library
	property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL
	
	Button {
		id: btnQuitter
		text: "Quitter"
		onClicked: window2.close()
	}
	
	ScrollView {
		id: scrollViewId
		width: parent.width
		height: parent.height
		anchors.top: btnQuitter.bottom
		ScrollBar.vertical.policy: ScrollBar.AlwaysOn
		
		
		ListView {
			anchors.centerIn: parent
			focus: true
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
				width: parent.width
				height: 1000
				color: "green"
				
				Image {
					width: parent.width
					height: parent.height
					id: regle1
					source: src+"images/Regle"+num+".jpg"
				}
			}
		}
	}
}
