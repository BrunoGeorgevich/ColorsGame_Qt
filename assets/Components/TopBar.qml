import QtQuick 2.4
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0

import "qrc:/components"

Item {
    property alias color : rect.color
    property alias content : rect.children
    DropShadow {
        anchors.fill: rect
        horizontalOffset: parent.width*(0.01)
        verticalOffset: parent.height*(0.05)
        radius: 12.0
        samples: 32
        color: "#90333333"
        source: rect
        transparentBorder: true
    }
    Rectangle {
        id:rect
        anchors{ fill: parent; bottomMargin: 4 }
    }
    states: [
        State {
            name: "menu"
            PropertyChanges { target: topBar; color:"#161616" }
        },
        State {
            name: "settings"
            PropertyChanges { target: topBar; color:"#2A2" }
        },
        State {
            name: "game"
            PropertyChanges { target: topBar; color:"#09A" }
        }
    ]
    transitions: [
        Transition {
            from: "*"; to: "*"
            ColorAnimation { duration:200 }
        }
    ]
}
