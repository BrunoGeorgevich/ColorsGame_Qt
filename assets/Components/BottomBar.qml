import QtQuick 2.0

import "qrc:/pages"

Rectangle {
    id:root
    property alias content : root.children
    states: [
        State {
            name: "menu"
            PropertyChanges { target: bottomBar; color:"#161616" }
        },
        State {
            name: "settings"
            PropertyChanges { target: bottomBar; color:"#2A2" }
        },
        State {
            name: "game"
            PropertyChanges { target: bottomBar;color:"#09A" }
        }
    ]
    transitions:[
        Transition {
            from:"*"; to:"*"
            ColorAnimation { duration: 200 }
        }
    ]
}

