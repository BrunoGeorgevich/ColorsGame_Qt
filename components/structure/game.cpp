#include "game.h"

Game::Game()
{
    m_settings = NULL; m_timer = new QTimer(this); m_level = 0;
    m_lines = new QQmlObjectListModel<Line>(this);
    connect(m_timer, SIGNAL(timeout()),
            this, SLOT(onTimeout()));
    qsrand(time(0));
}
bool Game::generateButtons()
{
    if(isSettingsEmpty()){
        qDebug() << "SETTINGS IS EMPTY!"; return false;
    }
    if(!m_lines->isEmpty()) m_lines->clear();
    int index = 0; int prevIndex = 0;
    for(int i = 0; i < m_settings->get_numOfRows(); i++) {
        index = qrand() % m_settings->get_numOfColumns();
        if(index == prevIndex) index = qrand() % m_settings->get_numOfColumns();
        Line *l = new Line(m_settings->get_numOfColumns(),
                           index,
                           (i == m_settings->get_numOfRows() - 1) ? true : false);
        connect(l, SIGNAL(aButtonWasClicked(bool)),
                this, SLOT(lineWasClicked(bool)));
        m_lines->append(l);
        prevIndex = index;
    }
    return true;
}
void Game::printStructure()
{
    if(m_lines->isEmpty()) generateButtons();
    for(int i = 0; i < m_lines->size(); i++) {
        QString line = "";
        QQmlObjectListModel<Button> *btns =
                (QQmlObjectListModel<Button> *)m_lines->at(i)->getButtons();
        for(int j = 0; j < btns->size(); j++) {
            Button *b = btns->at(j);
            if(b->get_status()) line.append("1 ");
            else line.append("0 ");
        }
        qDebug() << line;
    }
}
void Game::lineWasClicked(bool answer)
{
    if(answer) rightAnswer();
    else wrongAnswer();
}
void Game::onTimeout() { m_time--; emit timeEnded(m_time); }
void Game::rightAnswer()
{
    m_lines->remove(m_lines->size() - 1); m_time++;
    Line *nLine =  new Line(m_settings->get_numOfColumns(),
                            qrand() % m_settings->get_numOfColumns(),
                            false);
    connect(nLine, SIGNAL(aButtonWasClicked(bool)),
                    this, SLOT(lineWasClicked(bool)));
    m_lines->insert(0, nLine); Line *last = (Line *)m_lines->last();
    last->set_isFirst(true);
    emit rightAnswered();
}
void Game::wrongAnswer() { m_time -= 3; }
void Game::setSettings(int rows,
                       int columns,
                       QByteArray difficulty,
                       QByteArray primary,
                       QByteArray secondary)
{ m_settings = new Settings(rows,columns,difficulty,primary,secondary); }
bool Game::isSettingsEmpty() { return (!m_settings) ? true : false; }
void Game::startTimer(int turn, int total) { m_time = total; m_timer->start(turn); }
void Game::stopTimer() { m_timer->stop(); }
void Game::setTimerInterval(int interval) {
    if(m_timer->interval() >= 150) m_timer->setInterval(interval);
}
int Game::getTimerInterval() { return m_timer->interval(); }
void Game::setLevel(int l)
{
    if(m_level < 15) m_level = l;
}


