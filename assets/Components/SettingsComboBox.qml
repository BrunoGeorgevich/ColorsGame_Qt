import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.2

Rectangle {

    property string textLabel : "No Text"
    property var comboBoxModel : []
    property alias comboBox : cmbBox

    color:"transparent"

    Text {
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
            pixelSize: height*(0.8)
        }
    }

    ComboBox {
        id:cmbBox
        anchors {
            fill:parent
            topMargin: parent.height/2
        }
        style: ComboBoxStyle {
            font {
                pixelSize : parent.height/2
            }
        }

        editable: false

        model:comboBoxModel
    }

}
