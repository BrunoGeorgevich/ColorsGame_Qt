import QtQuick 2.0
import QtQuick.Controls 1.2

import "qrc:/components/"
import line 1.0

Rectangle {
    signal isTheCurrentItem;
    property var topBarContent
    function refreshGame() {
        if(topBarContent.getScore() == 0) {
            _game.startTimer(600, 60);
            levelRect.state = "show"
        }
        topBarContent.incrementScore();
        setLevel(topBarContent.getScore())
    }
    function setLevel(score) {
        var lvl = _game.getLevel();
        var inteval = _game.getTimerInterval();
        if(score >= (lvl*lvl)) {
            _game.setLevel(lvl + 1);
            _game.setTimerInterval(inteval - 30);
            levelText.text = "Nível " + lvl;
        }
    }
    onIsTheCurrentItem: {
        topBarContent = topBarContentComponent.createObject()
        topBar.content = topBarContent
        bottomBar.content = bottomBarContentComponent.createObject()
    }
    Component.onCompleted: {
        _game.generateButtons();
        _game.startTimer(600,60);
        _game.stopTimer();
        _game.setLevel(0);
    }
    objectName: "GamePage"
    color:"transparent"
    Connections {
        target:_game
        onRightAnswered:{ refreshGame(); }
        onTimeEnded : {
            if(currentTime <= 0) {
                buttonsGrid.visible = false;
                currentTime = 0;
                _game.stopTimer();
            }
            topBarContent.setTime(currentTime);
        }
    }
    Column {
        id:linesColumn
        anchors {
            top:parent.top; left:parent.left; right:parent.right
            bottom:parent.bottom; margins:parent.height*(0.05); bottomMargin: parent.height*0.2
        }
        spacing: 10; clip: true
        add : Transition {
            PropertyAnimation { property:"scale"; from:0; to:1; duration:100; easing.type: "OutElastic"}
        }
        Repeater {
            id:linesRepeater
            model:_game.getLines()
            delegate: Row {
                id:buttonsRow
                height: (linesColumn.height/linesRepeater.count) - linesColumn.spacing
                width: linesColumn.width; spacing: 10
                Component.onCompleted: console.log(_game.getLines().get(index))
                Repeater {
                    id:buttonsRepeater
                    model:line.getButtons()
                    delegate: Rectangle {
                        width:(buttonsRow.width/buttonsRepeater.count) - buttonsRow.spacing
                        height:buttonsRow.height
                        color: (status) ? settings['primaryColor'] :
                                          settings['secondaryColor'];
                        radius:10
                        MouseArea {
                            anchors.fill: parent
                            onClicked: btn.run()
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id:levelRect
        state : "hide"; color:"#09A"
        anchors {
            left:parent.left; right: parent.right; bottom:parent.bottom
        }
        height:parent.height*0.2
        Text {
            id:levelText
            visible:false
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font { bold:true; pixelSize: height/2 }
            color:"white"; text:"Nível 0"
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
                    anchors.top : linesColumn.bottom
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
        id:lineComponent
        Line { }
    }
    Component {
        id:topBarContentComponent
        Item {
            id:gameTopBarItem
            function setTime(time) { timeCell.content = time; }
            function incrementScore() { scoreCell.content++; }
            function getScore() { return scoreCell.content; }
            anchors.fill:parent
            Row {
                anchors.fill:parent
                TopBarCell {
                    id:timeCell
                    label:"Tempo"; content:"-"
                }
                TopBarCell {
                    id:scoreCell
                    label:"Placar"; content:"0"
                }
                TopBarCell {
                    id:recordCell
                    label:"Record"; content:"0"
                }
                onVisibleChanged: {
                    scoreCell.content = 0; recordCell.content = 0; timeCell.content = 60
                }
            }
        }
    }
    Component {
        id:bottomBarContentComponent
        Item {
            anchors.fill: parent
            Image {
                anchors {
                    top:parent.top; left:parent.left; bottom:parent.bottom
                    margins: (parent.width < parent.height) ?
                                 parent.width*(0.2) : parent.height*(0.2)
                }
                source: "qrc:/images/back-arrow.png"
                fillMode: Image.PreserveAspectFit
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        var previousItem = stackPages.get(stackPages.depth - 2);
                        if(previousItem.objectName == "MenuPage") stackPages.replace(settingsPageComponent);
                        else stackPages.pop()
                    }
                }
            }
        }
    }
}

