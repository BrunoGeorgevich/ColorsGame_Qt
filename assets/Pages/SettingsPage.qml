import QtQuick 2.0

import "qrc:/components"

Rectangle {

    objectName: "SettingsPage"
    color:"#DDD"

    signal isTheCurrentItem;

    onIsTheCurrentItem: {
        bottomBar.content = bottomBarContentComponent
    }

    Component.onCompleted : {
        if(!_game.isSettingsEmpty()) {

            primaryColorPanel.textInput.text = settings['primaryColor'];
            secondaryColorPanel.textInput.text = settings['secondaryColor'];

            difficultyComboBox.comboBox.currentIndex =
                    difficultyComboBox.comboBoxModel.indexOf(settings['difficulty']);

            columnsSettingsSlider.slider.value = settings['columns'];
            rowsSettingsSlider.slider.value = settings['rows'];
        }
    }

    Column {
        anchors{
            fill:parent
            topMargin: 10
            bottomMargin: 10
            leftMargin: parent.width*(0.15)
            rightMargin: parent.width*(0.15)
        }
        spacing: parent.height*(0.04)

        ColorPanel {
            id:primaryColorPanel

            height: parent.height/8
            width: parent.width

            textLabel: "Cor Primária"
            textInput.text: "#000";
        }

        ColorPanel {
            id:secondaryColorPanel

            height: parent.height/8
            width: parent.width

            textLabel : "Cor Secundária"
            textInput.text: "#FFF";
        }

        SettingsComboBox {
            id:difficultyComboBox

            height: parent.height/8
            width: parent.width

            textLabel:"Dificuldade"
            comboBoxModel : ["Fácil","Médio","Difícil","Personalizado"]

            comboBox.onCurrentTextChanged: {
                if(comboBox.currentText == "Personalizado") {
                    customPanel.open();
                } else {
                    customPanel.close();
                }
            }
        }

        Rectangle {
            id:customPanel

            color: "transparent"

            height: parent.height/4
            width: parent.width

            property bool valid: false

            visible: valid

            Column {

                anchors.fill: parent

                SettingsSlider {
                    id:columnsSettingsSlider
                    height:parent.height/2
                    width: parent.width

                    textLabel: "Colunas"
                }

                SettingsSlider {
                    id:rowsSettingsSlider
                    height:parent.height/2
                    width: parent.width

                    textLabel : "Linhas"
                }
            }

            function open() {
                valid = true
            }

            function close() {
                valid = false
            }
        }
    }

    Component {
        id:bottomBarContentComponent

        Item {
            Image {
                anchors {
                    top:parent.top
                    left:parent.left
                    bottom:parent.bottom

                    margins: (parent.width < parent.height) ?
                                 parent.width*(0.3) : parent.height*(0.3)
                }

                source: "qrc:/images/back-arrow.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {

                    anchors.fill: parent
                    onClicked: {
                        stackPages.pop()
                    }
                }
            }

            Text {
                anchors {
                    top:parent.top
                    right:parent.right
                    bottom:parent.bottom

                    rightMargin: (parent.width < parent.height) ?
                                     parent.width*(0.3) : parent.height*(0.3)
                }

                verticalAlignment: Text.AlignVCenter

                text:"Jogar"
                color:"white"

                font {
                    bold:true
                    pixelSize: height/2
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: start();
                }
            }
        }
    }

    function start() {

        var rows;
        var columns;
        var primaryColor;
        var secondaryColor;

        switch(difficultyComboBox.comboBox.currentText) {
        case "Fácil":
            rows = 3;
            columns = 3;
            break;
        case "Médio":
            rows = 5;
            columns = 5;
            break;
        case "Difícil":
            rows = 7;
            columns = 7;
            break;
        case "Personalizado":
            rows = rowsSettingsSlider.slider.value
            columns = columnsSettingsSlider.slider.value
            break;
        }

        if(primaryColorPanel.textInput.text == "")  {
            primaryColor = "#000";
        } else {
            primaryColor = primaryColorPanel.textInput.text
        }

        if(secondaryColorPanel.textInput.text == "") {
            secondaryColor = "#FFF";
        } else {
            secondaryColor = secondaryColorPanel.textInput.text;
        }

        _game.setSettings(
                    rows,
                    columns,
                    difficultyComboBox.comboBox.currentText,
                    primaryColor,
                    secondaryColor
                    );

        settings['rows'] = rows;
        settings['columns'] = columns;
        settings['difficulty'] = difficultyComboBox.comboBox.currentText;
        settings['primaryColor'] = primaryColor;
        settings['secondaryColor'] = secondaryColor;

        stackPages.push(gamePageComponent);
    }
}
