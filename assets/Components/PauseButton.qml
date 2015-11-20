import QtQuick 2.0

Item {
    SvgButton {
        visible:!popUpWindow.visible
        anchors.fill: parent
        source: "qrc:/pause.svg"
        actions.onClicked: popUpWindow.open()
    }
    SvgButton {
        visible:popUpWindow.visible
        anchors.fill: parent
        source: "qrc:/play.svg"
        actions.onClicked: popUpWindow.closed()
    }
}

