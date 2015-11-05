import QtQuick 2.0

import "qrc:/components"

Rectangle {

    objectName: "MenuPage"
    color:"#DDD"

    signal isTheCurrentItem;

    onIsTheCurrentItem: {
        bottomBar.content = undefined
    }

    CommomButton {
        id:playBtn

        anchors {
            top:parent.top
            left:parent.left
            leftMargin: parent.width*(0.2)
            topMargin:parent.height*(0.15)
        }

        width:parent.width*(0.6)
        height: parent.height/5

        buttonText: "Jogar"
        buttonColor: "#09A"

        mouseArea.onClicked: {
            if(!_game.isSettingsEmpty())
                stackPages.push(gamePageComponent);
            else
                stackPages.push(settingsPageComponent);
        }
    }

    CommomButton {
        id:settingsBtn

        anchors {
            top:playBtn.bottom
            left:parent.left
            leftMargin: parent.width*(0.2)
            topMargin:parent.height*(0.05)
        }

        width:parent.width*(0.6)
        height: parent.height/5

        buttonText: "Ajustes"
        buttonColor: "#2A2"

        mouseArea.onClicked: {
            stackPages.push(settingsPageComponent);
        }
    }

    CommomButton {
        id:quitButton

        anchors {
            top:settingsBtn.bottom
            left:parent.left
            leftMargin: parent.width*(0.2)
            topMargin:parent.height*(0.04)
        }

        width:parent.width*(0.6)
        height: parent.height/5

        buttonText: "Sair"
        buttonColor: "#C00"

        mouseArea.onClicked: {
            Qt.quit();
        }
    }

    Component {
        id:settingsPageComponent
        SettingsPage {}
    }

    Component {
        id:gamePageComponent
        GamePage {}
    }

    Component {
        id:bottomBarContentComponent
        Text {
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            text:"MENU"
            color:"White"

            font.pixelSize: height/2
        }
    }
}
