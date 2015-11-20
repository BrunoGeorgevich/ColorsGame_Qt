import QtQuick 2.3
import QtQuick.Controls 1.2

import "qrc:/components"
import "qrc:/bars"
import "qrc:/pages"

ApplicationWindow {
    id:root
    property var settings : _game.settings
    property alias bottomBar : bottomBar
    property alias topBar : topBar
    property int userRecord : _game.record
    function proportion(p1,p2,r) {
        return (root.width > root.height) ? r.height*p1 : r.width*p2;
    }

    title:"Color's Game"; visible: true
    height:600; width:400
    TopBar {
        id:topBar
        color:"#161616"; z:1
        anchors { fill : parent; bottomMargin: parent.height*(0.85) }
    }
    BottomBar {
        id:bottomBar
        color:"#161616"
        anchors { fill:parent; topMargin:parent.height*(0.9) }
    }
    StackView {
        id:stackPages
        anchors {
            top:topBar.bottom; left:parent.left
            right:parent.right; bottom:bottomBar.top
        }
        onCurrentItemChanged : {
            if(currentItem) {
                currentItem.isTheCurrentItem();
                switch(currentItem.objectName) {
                case "SettingsPage": bottomBar.state = "settings"; topBar.state = "settings"; break;
                case "MenuPage": bottomBar.state = "menu"; topBar.state = "menu"; break;
                case "GamePage": bottomBar.state = "game"; topBar.state = "game"; break;
                }
            }
        }
        initialItem: MenuPage {}
    }
}
