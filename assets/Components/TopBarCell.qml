import QtQuick 2.0

Rectangle {

    property string label : "Label"
    property string content : "Content"

    color:"transparent"
    height:parent.height; width:parent.width/3

    Column {

        anchors.fill: parent

        Text {

            height:parent.height/2; width:parent.width

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            text:label
            color:"#DDD"

            font {
               bold:true
               pixelSize: height*(0.7)
            }
        }
        Text {

            height:parent.height/2; width:parent.width

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            text:content
            color:"#DDD"

            font {
               bold:false
               pixelSize: height*(0.7)
            }
        }
    }
}
