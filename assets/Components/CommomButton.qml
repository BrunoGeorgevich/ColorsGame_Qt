import QtQuick 2.0

Rectangle {
    id:commomButtonRoot
    property string buttonColor : "Black"
    property string textColor : "White"
    property string buttonText : "No Text"
    property alias mouseArea : mouse
    color:buttonColor
    radius:height*(0.2)
    Text {
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text:buttonText
        color:textColor
        font { bold:true; pixelSize: height/2 }
    }
    MouseArea {
        id:mouse
        anchors.fill: parent
    }
}
