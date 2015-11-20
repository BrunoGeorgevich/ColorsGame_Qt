import QtQuick 2.5
import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

import "qrc:/components"

Item {
    id:colorDialogBoxRoot
    property alias okBtn : okButton
    property string color
    function open() { state = "open" }
    function closed() { state = "closed" }
    function componentToHex(c) {
        var hex = c.toString(16);
        return hex.length == 1 ? "0" + hex : hex;
    }
    function rgbToHex(r, g, b) {
        return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
    }
    function getColor() {
        return rgbToHex(rSlider.slider.value,gSlider.slider.value,bSlider.slider.value);
    }
    state:"closed"
    anchors.fill : parent
    opacity: 0
    Rectangle {
        id:backgroundRect
        anchors.fill: parent
        opacity:0
        color:"black"
        Behavior on opacity { NumberAnimation { duration:200 } }
    }
    DropShadow {
        id:dropShadow
        anchors.fill: colorDialogBox
        horizontalOffset: 3
        verticalOffset: 3
        radius: 8.0
        samples: 16
        color: "#00000000"
        source: colorDialogBox
        transparentBorder: true
        Behavior on color { ColorAnimation { duration: 200 } }
    }
    Rectangle {
        id:colorDialogBox
        width:proportion(0.8,0.8,parent)
        height:width
        anchors.verticalCenter: parent.verticalCenter
        color:"#DDD"
        MouseArea{
            anchors.fill: parent
            onClicked: {}
        }
        Column {
            anchors { fill: parent; margins: parent.width*(0.03) }
            spacing: parent.width*(0.02)
            SettingsSlider {
                id:rSlider
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width*(0.8)
                height:parent.height/6
                minValue: 0
                maxValue: 255
                textLabel: "R"
            }
            SettingsSlider {
                id:gSlider
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width*(0.8)
                height:parent.height/6
                minValue: 0
                maxValue: 255
                textLabel: "G"
            }
            SettingsSlider {
                id:bSlider
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width*(0.8)
                height:parent.height/5
                minValue: 0
                maxValue: 255
                textLabel: "B"
            }
            Rectangle {
                id:colorPreviewer
                anchors.horizontalCenter: parent.horizontalCenter
                width:parent.width*(0.8)
                height:parent.height/5
                color: rgbToHex(rSlider.slider.value,gSlider.slider.value,bSlider.slider.value)
            }
            Row {
                width:parent.width*(0.8)
                height:parent.height/5
                anchors.horizontalCenter: parent.horizontalCenter
                spacing:parent.width/4
                Button {
                    text:"Cancelar"
                    width:parent.width/3
                    height:parent.height/2
                    anchors.verticalCenter: parent.verticalCenter
                    onClicked: closed()
                }
                Button {
                    id:okButton
                    text:"Ok"
                    width:parent.width/3
                    height:parent.height/2
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }

    states: [
        State {
            name: "open"
            PropertyChanges { target:colorDialogBoxRoot; visible:true }
            AnchorChanges {
                target: colorDialogBox; anchors.right : undefined; anchors.horizontalCenter: parent.horizontalCenter
            }
        },
        State {
            name: "closed"
            AnchorChanges {
                target: colorDialogBox; anchors.right : parent.left; anchors.horizontalCenter: undefined
            }
        }
    ]

    transitions: [
        Transition {
            from: "closed"; to: "open"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        backgroundRect.opacity = 0.6
                        dropShadow.color = "#80000000"
                        colorDialogBoxRoot.opacity = 1
                    }
                }
                AnchorAnimation { duration: 200 }
                ScriptAction {
                    script: {
                        backgroundRect.opacity = 0.6
                        dropShadow.color = "#80000000"
                    }
                }
            }
        },
        Transition {
            from: "open"; to: "closed"
            SequentialAnimation {
                ScriptAction {
                    script: {
                        dropShadow.color = "#00000000"
                        backgroundRect.opacity = 0
                    }
                }
                AnchorAnimation { duration: 200 }
                ScriptAction {
                    script: {
                        rSlider.slider.value = 0
                        gSlider.slider.value = 0
                        bSlider.slider.value = 0
                        colorDialogBoxRoot.opacity = 0
                    }
                }
            }
        }
    ]
}

