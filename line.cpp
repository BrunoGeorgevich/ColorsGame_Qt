#include "line.h"

Line::Line(int numOfColumns, int rightBtnIndex, bool status)
{
    _columns = numOfColumns;

    _isFirst = status;

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

void Line::setFirst(bool isFirst)
{
    _isFirst = isFirst;
}

void Line::buttonClicked(bool isRight)
{
    if(isRight && _isFirst) {
        emit aButtonWasClicked(true);
    } else {
        emit aButtonWasClicked(false);
    }
}

