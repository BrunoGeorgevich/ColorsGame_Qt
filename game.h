#ifndef GAME_H
#define GAME_H

//Core Libs
#include <QTimer>

//Custom Libs
#include "settings.h"
#include "line.h"

class Game : public QObject
{
    Q_OBJECT
public:

    Game();

    void printStructure();

    Q_INVOKABLE bool generateButtons();
    Q_INVOKABLE QList<QObject *> getLines();

    Q_INVOKABLE QObject *getSettings() const;
    Q_INVOKABLE void setSettings(int rows,
                     int columns,
                     QString difficulty,
                     QString primary,
                     QString secondary);

    Q_INVOKABLE bool isSettingsEmpty();

    Q_INVOKABLE void startTimer(int turn, int total);
    Q_INVOKABLE void stopTimer();

signals:

    void rightAnswered();
    void timeEnded(int currentTime);

public slots:

    void lineWasClicked(bool answer);
    void onTimeout();

private:

    QList<QObject *> _lines;

    void rightAnswer();
    void wrongAnswer();

    QObject *settings;
    QTimer *timer;

    int _time;

};

#endif // GAME_H
