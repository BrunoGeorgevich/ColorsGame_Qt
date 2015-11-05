import QtQuick 2.4
import QtQuick.Controls 1.3

Rectangle {

    property string textLabel : "No text"
    property alias  slider : _slider
    property alias minValue : _slider.minimumValue
    property alias maxValue : _slider.maximumValue

    color:"transparent"

    Text {
        anchors {
            fill:parent
            bottomMargin: parent.height*(0.5)
        }

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text:textLabel + " : " + _slider.value
        color:"#555"

        font {
            bold:true
            pixelSize: height
        }
    }

    Slider {
        id:_slider
        anchors {
            fill:parent
            topMargin: parent.height*(0.5)
        }

        updateValueWhileDragging: true
        tickmarksEnabled: true

        stepSize: 1

        minimumValue: 2
        maximumValue: 5
    }

}
