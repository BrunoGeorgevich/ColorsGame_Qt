#include "line.h"
#include "game.h"
#include "components/patterns/factory/buttonfactory.h"

Line::Line(){
    m_rightBtnIndex = -1;
    m_buttons = new QQmlObjectListModel<Button>(this);
    set_line(this);
}
Line::Line(int numOfColumns, int rightBtnIndex, bool status)
{
    m_buttons = new QQmlObjectListModel<Button>(this);
    set_line(this);
    m_columns = numOfColumns; m_isFirst = status;
    m_rightBtnIndex = rightBtnIndex;
    generateButtons();
}
QObject *Line::getButtons()
{
    if(m_rightBtnIndex == -1) qFatal("RIGHTBTNINDEX IS NOT DEFINED!");
    if(!m_buttons->size()) generateButtons();
    return m_buttons;
}
void Line::buttonClicked(bool isRight)
{
    if(isRight && m_isFirst) Game::getInstance()->rightAnswer();
    else Game::getInstance()->wrongAnswer();
}
void Line::generateButtons()
{
    for(int i = 0; i < m_columns; i++) {
        Button *b;
        if(i == m_rightBtnIndex) b = ButtonFactory::getButton(true,this);
        else b = ButtonFactory::getButton(false,this);
        m_buttons->append(b);
    }
}

