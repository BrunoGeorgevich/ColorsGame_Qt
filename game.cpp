#include "game.h"

Game::Game()
{
    settings = NULL;
    timer = new QTimer(this);
    _level = 0;

    connect(timer, SIGNAL(timeout()),
            this, SLOT(onTimeout()));

    qsrand(time(0));
}

bool Game::generateButtons()
{
    if(isSettingsEmpty()){
        qDebug() << "SETTINGS IS EMPTY!";
        return false;
    }

    Settings *s = (Settings *)settings;

    if(!_lines.isEmpty())
        _lines.clear();

    int index = 0;
    int prevIndex = 0;

    for(int i = 0; i < s->numOfRows(); i++) {

        index = qrand() % s->numOfColumns();

        if(index == prevIndex)
            index = qrand() % s->numOfColumns();

        Line *l = new Line(s->numOfColumns(),
                           index,
                           (i == s->numOfRows() - 1) ? true : false);

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
        wrongAnswer();
    }
}

void Game::onTimeout()
{
    _time--;
    emit timeEnded(_time);
}

void Game::rightAnswer()
{
    _lines.removeLast();
    _time++;

    Settings *s = (Settings *)settings;

    Line *nLine =  new Line(s->numOfColumns(),
                            qrand() % s->numOfColumns(),
                            false);

    connect(nLine, SIGNAL(aButtonWasClicked(bool)),
                    this, SLOT(lineWasClicked(bool)));

    _lines.insert(0, nLine);

    Line *last = (Line *)_lines.last();
    last->setFirst(true);

    //qDebug() << _lines;

    emit rightAnswered();
}

void Game::wrongAnswer()
{
    _time -= 3;
}
QObject *Game::getSettings() const
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
    return (!settings) ? true : false;
}

void Game::startTimer(int turn, int total)
{
    _time = total;
    timer->start(turn);
}

void Game::stopTimer()
{
    timer->stop();
}

void Game::setTimerInterval(int interval)
{
    if(timer->interval() >= 150)
    timer->setInterval(interval);
}

int Game::getTimerInterval()
{
    return timer->interval();
}

int Game::getLevel()
{
    return _level;
}

void Game::setLevel(int l)
{
    if(_level < 15)
        _level = l;
}


