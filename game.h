#ifndef GAME_H
#define GAME_H

#include "line.h"

class Game : public QObject
{
    Q_OBJECT
public:

    Game(int r, int c);

    Q_INVOKABLE
    bool generateButtons();
    Q_INVOKABLE
    QList<QObject *> getLines();

    void printStructure();

public slots:

    void lineWasClicked(bool isFirst);

private:

    int _columns;
    int _rows;

    QList<QObject *> _lines;

};

#endif // GAME_H
