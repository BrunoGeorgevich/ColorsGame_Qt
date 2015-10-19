import QtQuick 2.4
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0

import "qrc:/components"

Item {

    property alias color : rect.color
    property var content

    function setTime(time) {
        timeCell.content = time;
    }

    function incrementScore() {
        scoreCell.content++;
    }

    function getScore() {
        return scoreCell.content;
    }

    Behavior on color {
        ColorAnimation {
            duration:200
        }
    }

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
        anchors.fill: parent
        anchors.bottomMargin: 4

        Loader {
            anchors.fill: parent
            sourceComponent: content
        }


        Item {
            id:gameTopBarItem
            visible:content?false:true;

            anchors.fill:parent

            Row {
                anchors.fill:parent

                TopBarCell {
                    id:timeCell
                    label:"Tempo"
                    content:"00:00"
                }
                TopBarCell {
                    id:scoreCell
                    label:"Placar"
                    content:"0"
                }
                TopBarCell {
                    id:recordCell
                    label:"Record"
                    content:"0"
                }

                onVisibleChanged: {
                    scoreCell.content = 0
                    recordCell.content = 0
                    timeCell.content = 60
                }
            }
        }
    }

    Component {
        id:menuTopBarComponent
        Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            text:"Menu"
            color:"White"

            font {
                bold:true
                pixelSize: height/2
            }
        }
    }

    Component {
        id:settingsTopBarComponent
        Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            text:"Ajustes"
            color:"White"

            font {
                bold:true
                pixelSize: height/2
            }
        }
    }

    states: [
        State {
            name: "menu"
            PropertyChanges {
                target: topBar
                color:"#161616"
                content : menuTopBarComponent
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: topBar
                color:"#2A2"
                content : settingsTopBarComponent
            }
        },
        State {
            name: "game"
            PropertyChanges {
                target: topBar
                color:"#09A"
                content : undefined
            }
        }
    ]

}
