import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {

    title:"Color's Game"
    height:600
    width:400

    visible: true

    GridView {
        id:buttonsGrid
        anchors {
            fill:parent
            bottomMargin: parent.height/10
        }

        model: ListModel {  id:buttonsGridModel  }
        delegate: Rectangle {

            width:80
            height:80

            color:(isRight) ? "black" : "lightGray";
        }

        onModelChanged: console.log("Model has been changed!");
    }

    Button {
        anchors {
            fill:parent

            topMargin: buttonsGrid.height
            leftMargin: parent.width*(0.8)

            margins:5
        }

        text:"Gerar"

        onClicked: {
            _game.generateButtons();
            addLines(_game.getLines());
        }
    }

    function addLines(l) {

        var lines = l;

        if(buttonsGridModel.count != 0)
            buttonsGridModel.clear();

        lines.forEach(function(line){
            var btns = line.getButtons();

            btns.forEach(function(btn) {

                buttonsGridModel.append({
                                            isRight:btn.getStatus()
                                        });

            });
        });
    }
}
