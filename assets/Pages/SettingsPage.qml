import QtQuick 2.0

import "qrc:/components"
import "qrc:/dialogs"
import "qrc:/buttons"

Rectangle {
    signal isTheCurrentItem;
    function start() {
        var rows; var columns; var primaryColor; var secondaryColor;
        switch(difficultyComboBox.comboBox.currentText) {
        case "Facil": rows = 3; columns = 3; break;
        case "Medio": rows = 4; columns = 4; break;
        case "Dificil": rows = 5; columns = 5; break;
        case "Personalizado":
            rows = rowsSettingsSlider.slider.value
            columns = columnsSettingsSlider.slider.value
            break;
        }
        if(primaryColorPanel.textInput.text == "") primaryColor = "#000";
        else primaryColor = primaryColorPanel.textInput.text
        if(secondaryColorPanel.textInput.text == "") secondaryColor = "#FFF";
        else secondaryColor = secondaryColorPanel.textInput.text;
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
    objectName: "SettingsPage"
    color:"transparent"
    onIsTheCurrentItem: {
        topBar.content = topBarContentComponent.createObject()
        bottomBar.content = bottomBarContentComponent.createObject()
    }
    Component.onCompleted : {
        primaryColorPanel.textInput.text = settings['primaryColor'];
        secondaryColorPanel.textInput.text = settings['secondaryColor'];
        for(var i=0;i<difficultyComboBox.comboBoxModel.length;i++){
            if(difficultyComboBox.comboBoxModel[i] == settings['difficulty'])
                difficultyComboBox.comboBox.currentIndex = i
        }
        columnsSettingsSlider.slider.value = settings['columns'];
        rowsSettingsSlider.slider.value = settings['rows'];
    }
    Column {
        anchors{
            fill:parent; topMargin: 10; bottomMargin: 10
            leftMargin: parent.width*(0.15)
            rightMargin: parent.width*(0.15)
        }
        spacing: parent.height*(0.04)
        ColorPanel {
            id:primaryColorPanel
            height: parent.height/8; width: parent.width
            textLabel: "Cor Primária"; textInput.text: "#000";
            mouse.onClicked: primaryColorDialog.open()
        }
        ColorPanel {
            id:secondaryColorPanel
            height: parent.height/8; width: parent.width
            textLabel : "Cor Secundária"; textInput.text: "#FFF";
            mouse.onClicked: secondaryColorDialog.open()
        }
        SettingsComboBox {
            id:difficultyComboBox
            height: parent.height/8; width: parent.width
            textLabel:"Dificuldade"; comboBoxModel : ["Facil","Medio","Dificil","Personalizado"]
            comboBox.onCurrentTextChanged: {
                if(comboBox.currentText == "Personalizado") customPanel.open();
                else customPanel.close();
            }
        }
        Rectangle {
            id:customPanel
            property bool valid: false
            color: "transparent"; visible: valid
            height: parent.height/4; width: parent.width
            Column {
                anchors.fill: parent
                SettingsSlider {
                    id:columnsSettingsSlider
                    height:parent.height/2; width: parent.width
                    minValue: 2; maxValue: 6
                    textLabel: "Colunas"
                }
                SettingsSlider {
                    id:rowsSettingsSlider
                    height:parent.height/2; width: parent.width
                    minValue: 2; maxValue: 6
                    textLabel : "Linhas"
                }
            }
            function open() { valid = true }
            function close() { valid = false }
        }
    }
    Component {
        id:topBarContentComponent
        Text {
            anchors.fill: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text:"Ajustes"; color:"White"
            font { bold:true; pixelSize: topBar.height/2 }
        }
    }
    Component {
        id:bottomBarContentComponent
        Item {
            anchors.fill: parent
            SvgButton {
                height:parent.height
                width:height
                source: "qrc:/back.svg"
                actions.onClicked:stackPages.pop()
            }
            FlatButton {
                fontSize:parent.height*0.45
                anchors{ right: parent.right; rightMargin:proportion(0.3,0.025,parent); verticalCenter:parent.verticalCenter }
                text:"JOGAR"
                actions.onClicked : start()
            }
        }
    }
    ColorDialogBox {
        id:primaryColorDialog
        okBtn.onClicked : {
            primaryColorPanel.textInput.text = primaryColorDialog.getColor()
            primaryColorDialog.closed()
        }
    }
    ColorDialogBox {
        id:secondaryColorDialog
        okBtn.onClicked : {
            secondaryColorPanel.textInput.text = secondaryColorDialog.getColor()
            secondaryColorDialog.closed()
        }
    }
}
