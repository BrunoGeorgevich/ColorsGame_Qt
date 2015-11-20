import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    property alias source : image.source
    property alias actions : mouseArea
    property var color : "#FFF"
    property var hoverColor : "yellow"
    Image {
        id:image
        anchors.fill: parent
        sourceSize.height: height; sourceSize.width: width
        fillMode: Image.PreserveAspectFit
    }
    ColorOverlay {
        id:colorOverlay
        anchors.fill: image
        source: image
        color:mouseArea.containsMouse ? parent.hoverColor : parent.color;
    }
    MouseArea {
        id:mouseArea
        hoverEnabled: true
        anchors.fill: parent
    }
}

