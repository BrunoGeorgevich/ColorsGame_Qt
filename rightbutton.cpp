#include "rightbutton.h"
#include "line.h"

RightButton::RightButton(){ _status=true; }

void RightButton::run()
{
    emit clicked(_status);
}

