#include "game.h"

Game::Game()
{
    m_settings = NULL; m_timer = new QTimer(this); m_level = 0;
    m_lines = new QQmlObjectListModel<Line>(this);
    connect(m_timer, SIGNAL(timeout()),
            this, SLOT(onTimeout()));
    initDb();
    m_settings = getUser();
    qsrand(time(0));
}

bool Game::generateButtons()
{
    if(!m_lines->isEmpty()) m_lines->clear();
    int index = 0; int prevIndex = 0;
    for(int i = 0; i < m_settings->get_rows(); i++) {
        index = qrand() % m_settings->get_columns();
        if(index == prevIndex) index = qrand() % m_settings->get_columns();
        Line *l = new Line(m_settings->get_columns(),
                           index,
                           (i == m_settings->get_rows() - 1) ? true : false);
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

void Game::dbLog(QByteArray msg) { qDebug() << qPrintable(msg); }

void Game::initDb()
{
    QByteArray path = QStandardPaths::standardLocations(QStandardPaths::DocumentsLocation)[0].toLatin1();
    m_db = new Database(path+"/db.colors");
    connect(m_db,SIGNAL(updateLog(QByteArray)),
            this,SLOT(dbLog(QByteArray)));
    if(!m_db->hasAnyTables()) {
        m_db->createTable("users","id int unique not null, "
                                  "rows int not null, "
                                  "columns int not null, "
                                  "record int not null, "
                                  "difficulty varchar(15) not null,"
                                  "primaryC varchar(15) not null, "
                                  "secondaryC varchar(15) not null");
        m_db->insertInto("users","0,3,3,0,'Facil','#000','#FFF'");
    }
}

Settings *Game::getUser()
{
    if(!m_db->dbExists()) return NULL;
    QVariantList user = m_db->select("users","*","id=0");
    if(user.isEmpty()) return NULL;
    Settings *s = new Settings(
                user[0].toMap()["rows"].toInt(),
            user[0].toMap()["columns"].toInt(),
            user[0].toMap()["difficulty"].toByteArray(),
            user[0].toMap()["primaryC"].toByteArray(),
            user[0].toMap()["secondaryC"].toByteArray()
            );
    m_record=user[0].toMap()["record"].toInt();
    qDebug() << "Record :" << m_record;
    s->printStructure();
    return s;
}

void Game::rightAnswer()
{
    m_lines->remove(m_lines->size() - 1); m_time++;
    Line *nLine =  new Line(m_settings->get_columns(),
                            qrand() % m_settings->get_columns(),
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
{
    m_settings = new Settings(rows,columns,difficulty,primary,secondary);
    m_db->updateUser("users",
                     "id=0,"
                     "rows="+QByteArray::number(rows)+","
                     "columns="+QByteArray::number(columns)+","
                     "difficulty='"+difficulty+"',"
                     "primaryC='"+primary+"',"
                     "secondaryC='"+secondary+"'",
                     "id=0");
}

void Game::startTimer(int turn, int total) { m_time = total; m_timer->start(turn); }

void Game::resumeTimer() { m_timer->start(); }

void Game::stopTimer() { m_timer->stop(); }

void Game::setTimerInterval(int interval) {
    if(m_timer->interval() >= 150) m_timer->setInterval(interval);
}

int Game::getTimerInterval() { return m_timer->interval(); }

void Game::setLevel(int l)
{
    if(m_level < 15) m_level = l;
}

void Game::updateRecord(int v)
{
    m_record = v;
    m_db->updateUser("users","record="+QByteArray::number(v),"id=0");
}


