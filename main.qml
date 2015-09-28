import QtQuick 2.3
import QtQuick.Controls 1.2

import "qrc:/pages"

ApplicationWindow {

    title:"Color's Game"
    height:600
    width:400

    visible: true

    StackView {
        id:stackPages
        anchors.fill: parent
        initialItem: MenuPage {

        }
    }

}
