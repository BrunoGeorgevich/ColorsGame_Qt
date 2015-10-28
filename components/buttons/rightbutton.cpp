#include "rightbutton.h"

RightButton::RightButton() {
    set_status(true);
    set_btn(this);
}

void RightButton::run()
{
    emit clicked(get_status());
}

