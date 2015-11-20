import QtQuick 2.5

Item {
    property alias actions : mouseArea
    property var hoverColor : "yellow"
    property var color : "#FFF"
    property alias text : label.text
    property alias fontSize : label.font.pixelSize
    width:label.contentWidth
    height:label.contentHeight
    Text {
        id:label
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color:mouseArea.containsMouse ? hoverColor : parent.color
        font.bold: true
    }
    MouseArea {
        id:mouseArea
        anchors.fill: parent
        hoverEnabled: true
    }
}

