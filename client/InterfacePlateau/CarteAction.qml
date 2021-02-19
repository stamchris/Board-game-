import QtQuick 2.12

Rectangle{
      id:root
    width: parent.width
    height: parent.height/2
    anchors.left:parent.left
    z:2
    opacity:0
        MouseArea{
            id : hover1Id
            width:parent.width
            height:parent.height
            hoverEnabled: true

                onHoveredChanged: {
                   if (containsMouse == true)
                        {
                          root.opacity=0.4
                        }else
                        {
                            root.opacity=0
                    }
                }
       }

}
