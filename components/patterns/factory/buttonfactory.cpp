#include "buttonfactory.h"

Button *ButtonFactory::getButton(bool type, Line *line)
{
    Button *b;
    if(type) b = new RightButton();
    else b = new CommonButton();
    connect(b,SIGNAL(clicked(bool)),
            line,SLOT(buttonClicked(bool)));
    return b;
}
