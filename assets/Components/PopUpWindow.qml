import QtQuick 2.5
import QtGraphicalEffects 1.0

Item {
    id:popUpWindow
    signal imminentHide
    signal imminentOpen
    property alias color : centerRect.color
    property alias content : centerRect.children
    function open() { state = "showed" }
    function closed() { state = "hidden" }
    height: parent.height; width: parent.width
    state:"hidden"
    visible:false
    DropShadow{
        id:shadow
        anchors.fill:centerRect
        horizontalOffset: 0
        verticalOffset: 0
        radius: 0
        samples: 32
        color: "#90000000"
        source: centerRect
        transparentBorder: true
    }

    Rectangle {
        id:centerRect
        anchors { fill:parent; margins:parent.height/10 }
    }

    states: [
        State {
            name: "hidden"
            AnchorChanges {
                target: popUpWindow
                anchors.right: parent.left
            }
        },
        State {
            name: "showed"
            AnchorChanges {
                target: popUpWindow
                anchors.right: parent.right
            }
        }
    ]
    transitions: [
        Transition {
            from: "hidden"; to: "showed"
            SequentialAnimation {
                ScriptAction { script:imminentOpen() }
                PropertyAction { target:popUpWindow; property:"visible"; value:true }
                AnchorAnimation { duration: 400; easing.type:"OutBack" }
                ParallelAnimation {
                    NumberAnimation { target:shadow; property:"radius"; to:22; duration: 200 }
                    NumberAnimation { target:centerRect; property:"scale"; to:1.05; duration: 200 }
                    NumberAnimation { target:shadow; property:"scale"; to:1.05; duration: 200 }
                }
            }
        },
        Transition {
            from: "showed"; to: "hidden"
            SequentialAnimation {
                ParallelAnimation {
                    NumberAnimation { target:shadow; property:"radius"; to:0; duration: 200 }
                    NumberAnimation { target:centerRect; property:"scale"; to:1; duration: 200 }
                    NumberAnimation { target:shadow; property:"scale"; to:1; duration: 200 }
                }
                AnchorAnimation { duration: 300; easing.type:"InCirc" }
                PropertyAction { target:popUpWindow; property:"visible"; value:false }
                ScriptAction { script:imminentHide() }
            }
        }
    ]
}

