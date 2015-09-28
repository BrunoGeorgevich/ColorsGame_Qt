import QtQuick 2.0

import "qrc:/components"

Rectangle {

    color:"#DDD"

    CommomButton {
        id:playBtn

        buttonText: "Jogar"
        buttonColor: "#09A"

        mouseArea.onClicked: {
            if(_game.isSettingsEmpty())
                stackPages.push(gamePageComponent);
            else
                stackPages.push(settingsPageComponent);
        }

        width:parent.width*(0.6)
        height: parent.height/5

        anchors {
            top:parent.top
            left:parent.left
            leftMargin: parent.width*(0.2)
            topMargin:parent.height*(0.15)
        }
    }

    CommomButton {
        id:settingsBtn

        buttonText: "Ajustes"
        buttonColor: "#2A2"

        width:parent.width*(0.6)
        height: parent.height/5

        mouseArea.onClicked: {
            stackPages.push(settingsPageComponent);
        }

        anchors {
            top:playBtn.bottom
            left:parent.left
            leftMargin: parent.width*(0.2)
            topMargin:parent.height*(0.05)
        }
    }

    CommomButton {
        id:quitButton

        buttonText: "Sair"
        buttonColor: "#C00"

        mouseArea.onClicked: {
            Qt.quit();
        }

        width:parent.width*(0.6)
        height: parent.height/5

        anchors {
            top:settingsBtn.bottom
            left:parent.left
            leftMargin: parent.width*(0.2)
            topMargin:parent.height*(0.05)
        }
    }

    Component {
        id:settingsPageComponent
        SettingsPage {

        }
    }

    Component {
        id:gamePageComponent
        GamePage {

        }
    }
}
