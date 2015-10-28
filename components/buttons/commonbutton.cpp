#include "commonbutton.h"

CommonButton::CommonButton() {
    set_status(false);
    set_btn(this);
}

void CommonButton::run()
{
    emit clicked(get_status());
}

