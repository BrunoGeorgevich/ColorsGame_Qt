#include "game.h"

Game::Game()
{
    settings = NULL; timer = new QTimer(this); _level = 0;
    _lines = new QQmlObjectListModel<Line>(this);
    connect(timer, SIGNAL(timeout()),
            this, SLOT(onTimeout()));
    qsrand(time(0));
}
bool Game::generateButtons()
{
    if(isSettingsEmpty()){
        qDebug() << "SETTINGS IS EMPTY!"; return false;
    }
    Settings *s = (Settings *)settings;
    if(!_lines->isEmpty()) _lines->clear();
    int index = 0; int prevIndex = 0;
    for(int i = 0; i < s->get_numOfRows(); i++) {
        index = qrand() % s->get_numOfColumns();
        if(index == prevIndex) index = qrand() % s->get_numOfColumns();
        Line *l = new Line(s->get_numOfColumns(),
                           index,
                           (i == s->get_numOfRows() - 1) ? true : false);
        connect(l, SIGNAL(aButtonWasClicked(bool)),
                this, SLOT(lineWasClicked(bool)));
        _lines->append(l);
        prevIndex = index;
    }
    return true;
}
void Game::printStructure()
{
    if(_lines->isEmpty()) generateButtons();
    for(int i = 0; i < _lines->size(); i++) {
        QString line = "";
        QQmlObjectListModel<Button> *btns =
                (QQmlObjectListModel<Button> *)_lines->at(i)->getButtons();
        for(int j = 0; j < btns->size(); j++) {
            Button *b = btns->at(j);
            if(b->get_status()) line.append("1 ");
            else line.append("0 ");
        }
        qDebug() << line;
    }
}
QObject *Game::getLines() { return _lines; }
void Game::lineWasClicked(bool answer)
{
    if(answer) rightAnswer();
    else wrongAnswer();
}
void Game::onTimeout() { _time--; emit timeEnded(_time); }
void Game::rightAnswer()
{
    _lines->remove(_lines->size() - 1); _time++;
    Settings *s = (Settings *)settings;
    Line *nLine =  new Line(s->get_numOfColumns(),
                            qrand() % s->get_numOfColumns(),
                            false);
    connect(nLine, SIGNAL(aButtonWasClicked(bool)),
                    this, SLOT(lineWasClicked(bool)));
    _lines->insert(0, nLine); Line *last = (Line *)_lines->last();
    last->set_isFirst(true);
    emit rightAnswered();
}
void Game::wrongAnswer() { _time -= 3; }
QObject *Game::getSettings() const { return settings; }
void Game::setSettings(int rows,
                       int columns,
                       QByteArray difficulty,
                       QByteArray primary,
                       QByteArray secondary)
{ settings = new Settings(rows,columns,difficulty,primary,secondary); }
bool Game::isSettingsEmpty() { return (!settings) ? true : false; }
void Game::startTimer(int turn, int total) { _time = total; timer->start(turn); }
void Game::stopTimer() { timer->stop(); }
void Game::setTimerInterval(int interval) {
    if(timer->interval() >= 150) timer->setInterval(interval);
}
int Game::getTimerInterval() { return timer->interval(); }
int Game::getLevel() { return _level; }
void Game::setLevel(int l)
{
    if(_level < 15) _level = l;
}


