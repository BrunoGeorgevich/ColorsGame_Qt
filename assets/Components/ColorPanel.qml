import QtQuick 2.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.3

Rectangle {

    color:"transparent"

    property alias textLabel : label.text
    property alias textInput : txtInput

    Text {
        id:label
        anchors {
            fill:parent
            bottomMargin: parent.height/2
        }

        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        text:textLabel
        color:"#555"

        font {
            bold:true
            pixelSize: height
        }
    }

    Rectangle {
        id:textInputRectangle
        anchors {
            fill:parent
            topMargin: parent.height/2
            rightMargin: parent.width*(0.1)
        }

        radius: 20
        border.color: "black"

        TextInput {
            id:txtInput
            anchors {
                fill: parent
                leftMargin: parent.width*(0.02)
            }

            font {
                pixelSize: height*(0.8)
            }

            verticalAlignment: TextInput.AlignVCenter

            color:"#555"

            onTextChanged: {
                colorCircle.color = text
            }
        }
    }

    Rectangle {
        id:colorCircle

        anchors {
            right:parent.right
            left:textInputRectangle.right
            leftMargin: parent.width*(0.02)
            verticalCenter: textInputRectangle.verticalCenter
        }

        height: width
        radius: height/2

        MouseArea {
            anchors.fill: parent
            onClicked: colorDialog.open()
        }
    }

    ColorDialog {
        id:colorDialog

        onAccepted: {
            txtInput.text  = colorDialog.currentColor
            colorCircle.color = colorDialog.currentColor
        }
    }
}

