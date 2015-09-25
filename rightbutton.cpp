#include "rightbutton.h"
#include "line.h"

RightButton::RightButton(){ _status=true; }

void RightButton::run()
{
    qDebug() << "Right Button";
    emit clicked(_status);
}

