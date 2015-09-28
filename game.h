#ifndef GAME_H
#define GAME_H

#include "settings.h"
#include "line.h"

class Game : public QObject
{
    Q_OBJECT
public:

    Game(int r = 3, int c = 3);

    void printStructure();

    Q_INVOKABLE
    bool generateButtons();
    Q_INVOKABLE
    QList<QObject *> getLines();

    Q_INVOKABLE
    int getColumns() const;
    Q_INVOKABLE
    void setColumns(int columns);

    Q_INVOKABLE
    int getRows() const;
    Q_INVOKABLE
    void setRows(int rows);

    Q_INVOKABLE
    Settings *getSettings() const;
    Q_INVOKABLE
    void setSettings(int rows,
                     int columns,
                     QString difficulty,
                     QString primary,
                     QString secondary);

    Q_INVOKABLE
    bool isSettingsEmpty();

signals:

    void rightAnswered();

public slots:

    void lineWasClicked(bool answer);

private:

    int _columns;
    int _rows;

    QList<QObject *> _lines;

    void rightAnswer();
    void wrongAnswer();

    Settings *settings;

};

#endif // GAME_H
