import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10

Rectangle {
	property int positionCounter: 1
	property alias yPosition: pionId.y
	property alias xPosition: pionId.x
	id: pionId
	width: parent.width/3
	height: parent.height/5
	color: "white"
	radius: 15
	y: 0
	x: 0
}
