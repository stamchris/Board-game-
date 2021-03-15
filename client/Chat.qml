import QtQuick 2.10
import QtQuick.Layouts 1.10
import QtQuick.Controls 2.10
import QtWebSockets 1.0

Item {
    width:150
    height: 200
    anchors.bottom:parent.bottom
    anchors.left:parent.left

    // Structure of the message

    ListModel {
            id:mListModel

            ListElement {
                    username:"New player"; message:" has entered the room"
            }
    }

    ColumnLayout {
        anchors.fill:parent
        ListView {
            id: mListViewId
            model: mListModel
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
              width:parent.width
              height: textToType.implicitHeight +15 //+15 padding
              border{color: "blue";width: 1}

                TextInput {
                    id: textToType
                    width:parent.width
                    anchors.centerIn: parent
                    text: "Type ..."
                    onFocusChanged:{ textToType.clear()}
                    onAccepted: {
                        socket.send({type:"chatMessage",message:text})
                        mListModel.append({"username": socket.login, "message": text})
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
                text: '<font><b>'+username+'</b>' + ' : ' + message +'</font>'
                font.pointSize: 8
                textFormat: Text.StyledText
            }
        }
    }
	}

