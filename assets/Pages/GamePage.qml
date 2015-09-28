import QtQuick 2.0
import QtQuick.Controls 1.2

Rectangle {
    Connections {
        target:_game
        onRightAnswered:{
            addLines(_game.getLines());
        }
    }

    GridView {
        id:buttonsGrid

        anchors {
            fill:parent
            topMargin: parent.height/50
            leftMargin: parent.width/50
            rightMargin: parent.width/50
            bottomMargin: parent.height/10
        }

        cellWidth: width/_game.getColumns();
        cellHeight:height/_game.getRows();

        model: ListModel {  id:buttonsGridModel  }
        delegate: Rectangle {

            width:buttonsGrid.cellWidth*(0.9)
            height:buttonsGrid.cellHeight*(0.9)

            color:(btn.getStatus()) ? ((line.isFirst()) ? "gold" : "black") : "lightGray";

            MouseArea {
                anchors.fill: parent

                onClicked: {
                    btn.run();
                }
            }
        }
    }

    Button {
        anchors {

            top:buttonsGrid.bottom

            topMargin: parent.height/50
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
                                            btn:btn,
                                            line:line
                                        });

            });
        });
    }
}

