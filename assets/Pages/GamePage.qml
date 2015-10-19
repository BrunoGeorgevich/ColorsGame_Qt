import QtQuick 2.0
import QtQuick.Controls 1.2

import "qrc:/components/"

Rectangle {

    signal isTheCurrentItem;

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

        if(topBar.getScore() == 0) {
            _game.startTimer(800, 60);
            levelRect.state = "show"
        }

        topBar.incrementScore();
        setLevel(topBar.getScore())

        if(topBar.getScore())

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

    function setLevel(score) {

        var lvl = _game.getLevel();
        var inteval = _game.getTimerInterval();

        if(score >= (lvl*lvl)) {

            _game.setLevel(lvl + 1);
            _game.setTimerInterval(inteval - 30);

            levelText.text = "Nível " + (lvl + 1);
            console.log("LEVEL " + (lvl + 1) + "!");
        }
    }

    onIsTheCurrentItem: {
        bottomBar.content = bottomBarContentComponent
    }

    Component.onCompleted: {
        _game.generateButtons();
        addLines(_game.getLines());
    }

    objectName: "GamePage"
    color:"transparent"

    Connections {
        target:_game
        onRightAnswered:{
            refreshGame();
        }

        onTimeEnded : {
            if(currentTime <= 0) {
                buttonsGrid.visible = false;
                currentTime = 0;
                _game.stopTimer();
            }

            topBar.setTime(currentTime);
        }
    }

    GridView {
        id:buttonsGrid

        anchors {
            top:parent.top
            left:parent.left
            right:parent.right
            bottom:parent.bottom
            margins:parent.height*(0.05)
            bottomMargin: parent.height*0.2
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

    Rectangle {
        id:levelRect

        state : "hide"
        color:"#09A"

        anchors {
            left:parent.left
            right: parent.right
            bottom:parent.bottom
        }

        height:parent.height*0.2

        Text {
            id:levelText
            visible:false
            anchors.fill: parent

            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter

            font {
                bold:true
                pixelSize: height/2
            }

            color:"white"

            text:"Nível 0"
        }

        states : [
            State {
                name: "hide"
                AnchorChanges {
                    target: levelRect
                    anchors.top : parent.bottom
                }
            }, State {
                name: "show"
                AnchorChanges {
                    target: levelRect
                    anchors.top : buttonsGrid.bottom
                }
                PropertyChanges {
                    target: levelText
                    visible:true
                }
            }
        ]

        transitions: [
            Transition {
                from: "hide"
                to: "show"
                AnchorAnimation {
                    duration: 800
                    easing.type: "OutElastic"
                }
            }
        ]
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
}

