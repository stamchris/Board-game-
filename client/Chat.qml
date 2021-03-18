import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
    // Change here the Layout and anchors of the message
    id:chatField

    width: parent.width
    // List of messages

    ColumnLayout {
        anchors.fill:parent

            ListView {
                id: mListViewId
                model: game.messages
                delegate: delegateId
                Layout.fillWidth: true
                Layout.fillHeight: true
                onCountChanged: {
                                var newIndex = count - 1 // last index
                                positionViewAtEnd()
                                currentIndex = newIndex
                            }
            }

          // Text Field to send Message
            Rectangle{
                  id:rectField
                  height: textToType.implicitHeight +15 //+15 padding
                  border{color: "#F0B27A";width: 1}
                  radius: 10
                  Layout.fillWidth: true
                  anchors{leftMargin: 2;rightMargin: 2;bottom: parent.bottom}

                    TextInput {
                        id: textToType
                        width:parent.width
                        anchors.centerIn: parent
                        leftPadding: 10
                        rightPadding: 10
                        text: "Type ..."
                        onTextEdited: rectField.border.width = 2.5
                        onFocusChanged: textToType.clear()

                        onAccepted: {
                            socket.send({type:"chatMessage",message:text})
                            textToType.clear()
                        }
                    }
            }
     }

    // Every new Message

    Component {
        id : delegateId
        Rectangle{
            id : rectId
            width : parent.width
            height : textId.implicitHeight + 10


            Text {
                id: textId
                width: parent.width
                wrapMode: Text.Wrap
                anchors.left: parent.left
                leftPadding: 3
                text: '<font color = modelData.player.colour><b><>'+modelData.player.name+'</b>' + ' : ' + modelData.message +'</font>'
                font.pointSize: 8
                textFormat: Text.StyledText
            }
        }
    }
	}

