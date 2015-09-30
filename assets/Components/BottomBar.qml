import QtQuick 2.0

import "qrc:/pages"

Rectangle {

    property var content

    states: [
        State {
            name: "menu"
            PropertyChanges {
                target: bottomBar
                color:"#161616"
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: bottomBar
                color:"#2A2"
            }
        },
        State {
            name: "game"
            PropertyChanges {
                target: bottomBar
                color:"#09A"
            }
        }
    ]

    Behavior on color {
        ColorAnimation {
            duration: 200
        }
    }

    Loader {
        anchors.fill: parent
        sourceComponent: content
    }
}

