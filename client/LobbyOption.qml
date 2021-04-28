import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Column {

	id: widget
	spacing:5

	Layout.fillWidth: true

	property string label: "???"

	Label {
		text: widget.label
		font.pointSize: 25
		anchors.bottomMargin: 20
		font.family: "Stoneyard"
	}
}
