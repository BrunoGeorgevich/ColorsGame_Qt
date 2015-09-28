import QtQuick 2.0

import "qrc:/components"

Rectangle {

    color:"#DDD"

    Column {

        anchors{
            fill: parent
            margins:parent.width*(0.04)
        }

        spacing: parent.height*(0.03)

        ColorPanel {
            id:primaryColorPanel

            textLabel: "Cor Primária"

            height: parent.height/6
            width: parent.width
        }

        ColorPanel {
            id:secondaryColorPanel

            textLabel : "Cor Secundária"

            height: parent.height/6
            width: parent.width
        }

        SettingsComboBox {
            id:difficultyComboBox

            height: parent.height/6
            width: parent.width

            textLabel:"Dificuldade"
            comboBoxModel : ["Fácil","Médio","Difícil","Personalizado"]

            comboBox.onCurrentTextChanged: {

                console.log(comboBox.currentText);

                if(comboBox.currentText == "Personalizado") {
                    customPanel.open();
                } else {
                    customPanel.close();
                }
            }
        }

        Rectangle {
            id:customPanel

            color: "Green"

            height: parent.height/6
            width: parent.width

            property bool valid: false

            visible: valid

            function open() {
                valid = true
            }

            function close() {
                valid = false
            }
        }
    }
}
