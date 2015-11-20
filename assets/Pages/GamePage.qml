import QtQuick 2.0
import QtQuick.Controls 1.2

import "qrc:/components"
import "qrc:/dialogs"
import "qrc:/buttons"
import "qrc:/bars"
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
        topBarContent.updateRecord();
        setLevel(topBarContent.getScore())
    }
    function setLevel(score) {
        var lvl = _game.level;
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
        _game.resetLevel();
    }
    objectName: "GamePage"
    color:"transparent"
    Timer {
        interval:10000
        repeat: true
        running: true
        onTriggered: {
            _game.updateRecord(userRecord)
        }
    }
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
            model:_game.lines
            delegate: Row {
                id:buttonsRow
                height: (linesColumn.height/linesRepeater.count) - linesColumn.spacing
                width: linesColumn.width; spacing: 10
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
            function setRecord(v) { recordCell.content = v }
            function getScore() { return scoreCell.content; }
            function getRecord() { return recordCell.content; }
            function updateRecord() {
                if(userRecord <= scoreCell.content)
                    userRecord = scoreCell.content
            }
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
                    label:"Record"; content:userRecord
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
            SvgButton {
                height:parent.height
                width:height
                source: "qrc:/back.svg"
                actions.onClicked: {
                    var previousItem = stackPages.get(stackPages.depth - 2);
                    if(previousItem.objectName == "MenuPage") stackPages.replace(settingsPageComponent);
                    else stackPages.pop()
                }
            }
            PauseButton {
                visible:(levelRect.state == "show")
                height:parent.height*0.8
                width:height
                anchors{ right:parent.right; verticalCenter:parent.verticalCenter }
            }
        }
    }
    PopUpWindow {
        id:popUpWindow
        onImminentHide : {
            _game.resumeTimer();
        }
        onImminentOpen : {
            _game.stopTimer();
        }
        content:Item {
            anchors.fill: parent
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                font.pixelSize: proportion(0.3,0.2,parent)
                text:"Pause"
            }
        }
    }
}

