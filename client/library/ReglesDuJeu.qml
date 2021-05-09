import QtQuick 2.10
import QtQuick.Controls 2.5
import QtQuick.Window 2.5

Rectangle {
	id: window2
	height: parent.height*0.75
	width: parent.width*0.75
	anchors.centerIn: parent
	color: "#AA000000"
	z: 100
	clip: true
	visible: false
	
	property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL

	Button {
		id: btnQuitter
		text: "X"
		anchors.top: parent.top
		anchors.right: parent.right
		onClicked: window2.visible = false
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
				width: window2.width*0.90
				height: window2.width*0.90
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
