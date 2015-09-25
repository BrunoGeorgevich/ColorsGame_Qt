#include "commonbutton.h"

CommonButton::CommonButton(){ _status=false; }

void CommonButton::run()
{
    qDebug() << "Commom Button!";
    emit clicked(_status);
}

