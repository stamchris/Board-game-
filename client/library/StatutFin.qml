import QtQuick 2.10
import QtQuick.Window 2.10
import QtQuick.Controls 2.10
import QtQuick.Layouts 1.10
import QtWebSockets 1.0

Rectangle {
	id : imageStatusid
	width : parent.width*0.8
	height : parent.height/7
	x : parent.x
	color : "transparent"
	opacity : 1
	border.width : 2
	property string src: typeof ROOT_URL === "undefined" ? "../" : ROOT_URL
	property alias textname : textname
	property alias imagestatut : imagestatut
	property alias imagesicone : imagesicone

	Row {
		height : parent.height
		width : parent.width
		spacing : 4

		Rectangle {
			width : parent.width*0.4
			height : parent.height/3
			color : "transparent"
			y : height
			Text {
				id : textname
				anchors.centerIn : parent
				width : parent.width
				y : 1/4*parent.height
				text : "" 
				font.pointSize: 24
				font.family: "Stoneyard"
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				elide: Text.ElideRight
			}
		}

		Rectangle {
			width : parent.width*0.3
			height : parent.height
			color : "transparent"
		
			BorderImage {
				id : imagesicone
				width: parent.width*(1/2)
				height: width
				anchors.centerIn : parent
				Layout.fillHeight : true
				Layout.fillWidth : true
				Layout.maximumWidth: 150
				Layout.maximumHeight: 150
				source: src + "images/blanc_icone.png"
			}
		}

		Rectangle {
			width : parent.width*0.3
			height : parent.height
			color : "transparent"
			BorderImage {
				id : imagestatut
				width: parent.width*(1/2)
				height: width
				anchors.centerIn : parent
				Layout.fillHeight : true
				Layout.fillWidth : true
				Layout.maximumWidth: 150
				Layout.maximumHeight: 150
				source: src + "images/cerbere_finaly.png"
			}
		}
	}
}