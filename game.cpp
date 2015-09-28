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

    int index = 0;
    int prevIndex = 0;

    for(int i = 0; i < _rows; i++) {

        index = qrand() % _columns;

        if(index == prevIndex)
            index = qrand() % _columns;

        Line *l = new Line(_columns, index, (i == _rows - 1) ? true : false);
        connect(l, SIGNAL(aButtonWasClicked(bool)),
                this, SLOT(lineWasClicked(bool)));
        _lines.append(l);

        prevIndex = index;
    }

    return true;
}

void Game::printStructure()
{
    if(_lines.isEmpty())
        generateButtons();

    foreach (QObject *o, _lines) {

        Line *l = (Line *)o;

        QString line = "";

        foreach (QObject *ob, l->getButtons()) {

            Button *b = (Button *)ob;

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

void Game::lineWasClicked(bool answer)
{
    if(answer) {
        rightAnswer();
    } else {
        qDebug() << "The Line isn't the First";
    }
}

void Game::rightAnswer()
{
    _lines.removeLast();

    Line *nLine =  new Line(_columns,qrand() % _columns, false);
    connect(nLine, SIGNAL(aButtonWasClicked(bool)),
                    this, SLOT(lineWasClicked(bool)));

    _lines.insert(0, nLine);

    Line *last = (Line *)_lines.last();
    last->setFirst(true);

    qDebug() << _lines;

    emit rightAnswered();
}
Settings *Game::getSettings() const
{
    return settings;
}

void Game::setSettings(int rows,
                       int columns,
                       QString difficulty,
                       QString primary,
                       QString secondary)
{
    settings = new Settings(rows,columns,difficulty,primary,secondary);
}

bool Game::isSettingsEmpty()
{
    return (settings == NULL) ? true : false;
}

int Game::getRows() const
{
    return _rows;
}

void Game::setRows(int rows)
{
    _rows = rows;
}

int Game::getColumns() const
{
    return _columns;
}

void Game::setColumns(int columns)
{
    _columns = columns;
}


