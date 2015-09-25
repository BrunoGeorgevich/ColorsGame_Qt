#include "game.h"

Game::Game(int r, int c)
{
    _rows = r;
    _columns = c;

    qsrand(time(0));
}

bool Game::generateButtons()
{
    if(!_lines.isEmpty())
        _lines.clear();

    for(int i = 0; i < _rows; i++) {
        Line *l = new Line(_columns, qrand() % _columns);
        connect(l, SIGNAL(aButtonWasClicked(bool)),
                this, SLOT(lineWasClicked(bool)));
        _lines.append(l);
    }
}

void Game::printStructure()
{
    if(_lines.isEmpty())
        generateButtons();

    foreach (QObject *o, _lines) {

        Line *l = (Line *)o;

        QString line = "";

        foreach (Button *b, l->getButtons()) {
            if(b->getStatus())
               line.append("1 ");
            else
                line.append("0 ");
        }

        qDebug() << line;
    }
}

QList<QObject *> Game::getLines()
{
    return _lines;
}

void Game::lineWasClicked(bool isFirst)
{
    if(isFirst) {
        qDebug() << "The Line is the First";
    } else {
        qDebug() << "The Line isn't the First";
    }
}

