import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Layouts 1.14

Column {
	id: widget

	Layout.fillWidth: true

	property string label: "???"

	Label {
		text: widget.label
	}
}
