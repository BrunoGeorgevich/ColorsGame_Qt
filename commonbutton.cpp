#include "commonbutton.h"

CommonButton::CommonButton(){ _status=false; }

void CommonButton::run()
{
    emit clicked(_status);
}

