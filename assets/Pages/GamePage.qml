import QtQuick 2.0
import QtQuick.Controls 1.2

import "qrc:/components/"

Rectangle {

    objectName: "GamePage"
    color:"transparent"

    signal isTheCurrentItem;

    onIsTheCurrentItem: {
        bottomBar.content = bottomBarContentComponent
    }

    Component.onCompleted: {
        _game.startTimer(300, 60);
        _game.generateButtons();
        addLines(_game.getLines());
    }

    Connections {
        target:_game
        onRightAnswered:{
            refreshGame();
        }

        onTimeEnded : {
            if(currentTime <= 0) {
                buttonsGrid.visible = false;
                _game.stopTimer();
            }

            topBar.setTime(currentTime);
        }
    }

    GridView {
        id:buttonsGrid

        anchors {
            fill:parent
            margins:parent.height*(0.05)
        }

        cellWidth: width/settings['columns'];
        cellHeight:height/settings['rows'];

        add : Transition {
            PropertyAnimation { property:"scale"; from:0; to:1; duration:50; }
        }

        model: ListModel {  id:buttonsGridModel  }
        delegate: Rectangle {

            width:buttonsGrid.cellWidth*(0.9)
            height:buttonsGrid.cellHeight*(0.9)

            radius:10

            color:(btn.getStatus()) ? settings['primaryColor'] :
                                      settings['secondaryColor'];
            MouseArea {
                anchors.fill: parent

                onClicked: {
                    btn.run();
                }
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

                        var previousItem = stackPages.get(stackPages.depth - 2);

                        if(previousItem.objectName == "MenuPage"){
                            stackPages.replace(settingsPageComponent);
                        } else {
                            stackPages.pop()
                        }
                    }
                }
            }
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

    function refreshGame() {

        topBar.incrementScore();

        for(var i = 0; i < settings['columns']; i++) {
            buttonsGridModel.remove(buttonsGridModel.count - 1);
        }

        var line = _game.getLines()[0];
        var btns = line.getButtons();

        btns.forEach(function(btn) {

            buttonsGridModel.insert(0, {
                                        btn:btn,
                                        line:line
                                    });
        });
    }
}

