import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.10
import QtWebSockets 1.0
import "library"

Item {
	id : endwindow
	height : 400
	width : 700

	Image {
		source: "images/background_image.jpg"
		anchors.fill:parent
	}
	property alias endcolumnid : endcolumnid
	property alias titleend : titleend
	property alias winnerscolumn : winnerscolumn
	property alias loserscolumn : loserscolumn

	Column {
		anchors.horizontalCenter: parent.horizontalCenter
		spacing : 5
		width : parent.width
		height : parent.height
		y : 15

		Label {
			id : titleend
			anchors.horizontalCenter: parent.horizontalCenter
			height : 1/15*parent.height
			text: "Cerbère "
			font.pointSize: 36
			font.family: "Stoneyard"
		}

		Rectangle {
			width : parent.width
			height : 9/10*parent.height
			color : "transparent"

			Row {
				id : endcolumnid
				width : parent.width
				height : parent.height
				Rectangle {
					width : parent.width/2
					height : parent.height 
					color : "transparent"

					Rectangle {
						width : parent.width/2
						height : parent.height/10
						color : "transparent"
						anchors.horizontalCenter : parent.horizontalCenter
						
						Text {
							anchors.centerIn : parent
							text : "Gagnants " 
							font.pointSize: 30
							font.family: "Stoneyard"
						}
					}    
					Rectangle {
						width : 0.8*parent.width
						height : 0.8*parent.height
						y: 15/100*height
						anchors.horizontalCenter : parent.horizontalCenter
						border.color: "white"
						border.width: 3
						color : "black"
						radius: 10  

						Column {
							id : winnerscolumn
							width : parent.width - 15
							height : parent.height
							x : 5/100*width
							y : height/10
							spacing : parent.height/20
						} 
							
						gradient: Gradient {
							GradientStop { position: 0.0; color: Qt.rgba(0,0, 0,0.5)}
							GradientStop { position: 0.6; color: "transparent"; }
							GradientStop { position: 1.0; color: Qt.rgba(255,255,255,0.5); }
						}
					}
				}

				Rectangle {
					width : parent.width/2
					height : parent.height 
					color : "transparent"
					Rectangle {
						width : parent.width/2
						height : parent.height/10
						color : "transparent"
						anchors.horizontalCenter : parent.horizontalCenter
						Text {
							anchors.centerIn : parent
							text : "Perdants " 
							font.pointSize: 30
							font.family: "Stoneyard"
						}
					}    
					Rectangle {
						width : 0.8*parent.width
						height : 0.8*parent.height
						y: 15/100*height
						anchors.horizontalCenter : parent.horizontalCenter
						border.color: "white"
						border.width: 3
						color : "black"
						radius: 10
						clip : true

						ScrollBar{
							id: scrollBarFinP
							policy: ScrollBar.AlwaysOn
							hoverEnabled: true
							active: hovered || pressed
							orientation: Qt.Vertical
							anchors.right: parent.right
							size : 1 - ((0.42)*(loserscolumn.children.length/10))
							z: 10
							height: parent.height
							width : 15
						}   
						Column {
							id : loserscolumn
							width : parent.width
							height : parent.height
							x : 5/100*width
							y :-scrollBarFinP.position*height + height/10
							spacing : parent.height/20
						}

						gradient: Gradient {
							GradientStop { position: 0.0; color: Qt.rgba(0,0,0,0.5)}
							GradientStop { position: 0.6; color: "transparent"; }
							GradientStop { position: 1.0; color: Qt.rgba(255,255,255,0.5); }
						}
					}
				}
			}
		}
	}
}