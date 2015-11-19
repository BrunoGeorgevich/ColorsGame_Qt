#ifndef GAME_H
#define GAME_H

//Core Libs
#include <QStandardPaths>
#include <QTimer>

//Custom Libs
#include "settings.h"
#include "line.h"

//External Libs
#include "components/external/qqmlobjectlistmodel.h"
#include "components/external/database.h"

class Game : public QObject
{
    Q_OBJECT
    QML_OBJMODEL_PROPERTY(Line, lines)
    QML_WRITABLE_PROPERTY(Settings *, settings)
    QML_WRITABLE_PROPERTY(QTimer *, timer)
    QML_WRITABLE_PROPERTY(int, time)
    QML_WRITABLE_PROPERTY(int, level)
    QML_READONLY_PROPERTY(Database *, db)
    QML_WRITABLE_PROPERTY(int, record)
public:
    Game();
    void printStructure();
    Q_INVOKABLE bool generateButtons();
    Q_INVOKABLE void setSettings(int rows,
                     int columns,
                     QByteArray difficulty,
                     QByteArray primary,
                     QByteArray secondary);
    Q_INVOKABLE void startTimer(int turn, int total);
    Q_INVOKABLE void stopTimer();
    Q_INVOKABLE void setTimerInterval(int interval);
    Q_INVOKABLE int getTimerInterval();
    Q_INVOKABLE void setLevel(int l);
    Q_INVOKABLE void updateRecord(int v);
signals:
    void rightAnswered();
    void timeEnded(int currentTime);
public slots:
    void lineWasClicked(bool answer);
    void onTimeout();
    void dbLog(QByteArray msg);
private:
    void initDb();
    Settings *getUser();
    void rightAnswer();
    void wrongAnswer();
};

#endif // GAME_H
