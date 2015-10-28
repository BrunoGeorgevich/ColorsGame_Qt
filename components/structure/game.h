#ifndef GAME_H
#define GAME_H

//Core Libs
#include <QTimer>

//Custom Libs
#include "settings.h"
#include "line.h"

//External Libs
#include "components/external/qqmlobjectlistmodel.h"

class Game : public QObject
{
    Q_OBJECT

public:

    Game();

    void printStructure();

    Q_INVOKABLE bool generateButtons();
    Q_INVOKABLE QObject *getLines();

    Q_INVOKABLE QObject *getSettings() const;
    Q_INVOKABLE void setSettings(int rows,
                     int columns,
                     QString difficulty,
                     QString primary,
                     QString secondary);

    Q_INVOKABLE bool isSettingsEmpty();

    Q_INVOKABLE void startTimer(int turn, int total);
    Q_INVOKABLE void stopTimer();

    Q_INVOKABLE void setTimerInterval(int interval);
    Q_INVOKABLE int getTimerInterval();

    Q_INVOKABLE int getLevel();
    Q_INVOKABLE void setLevel(int l);

signals:

    void rightAnswered();
    void timeEnded(int currentTime);

public slots:

    void lineWasClicked(bool answer);
    void onTimeout();

private:

    QQmlObjectListModel<Line> *_lines;

    void rightAnswer();
    void wrongAnswer();

    QObject *settings;
    QTimer *timer;

    int _time;
    int _level;

};

#endif // GAME_H
