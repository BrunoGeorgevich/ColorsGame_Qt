import QtQuick 2.3
import QtQuick.Controls 1.2

import "."

ApplicationWindow {

    title:"Color's Game"
    height:600
    width:400

    visible: true

    StackView {
        anchors.fill: parent
        initialItem: MenuPage {

        }
    }

}
