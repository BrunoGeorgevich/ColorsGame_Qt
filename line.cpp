#include "line.h"

Line::Line(int numOfColumns, int rightBtnIndex)
{
    _columns = numOfColumns;

    for(int i = 0; i < _columns; i++) {
        Button *b;

        if(i == rightBtnIndex)
            b = new RightButton();
        else
            b = new CommonButton();

        connect(b, SIGNAL(clicked(bool)), this, SLOT(buttonClicked(bool)));
        _buttons.append(b);
    }
}

QList<QObject *> Line::getButtons()
{
    return _buttons;
}

bool Line::isFirst()
{
    return _isFirst;
}

void Line::buttonClicked(bool isRight)
{
    if(isRight) {
        qDebug() << "The Button is the Right";
    } else {
        qDebug() << "The Button isn't the Right";
    }
}

