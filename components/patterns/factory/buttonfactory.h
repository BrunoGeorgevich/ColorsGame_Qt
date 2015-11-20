#ifndef BUTTONFACTORY
#define BUTTONFACTORY

#include <QObject>
#include <QHash>
#include "components/buttons/commonbutton.h"
#include "components/buttons/rightbutton.h"
#include "components/structure/line.h"
class ButtonFactory : public QObject
{
    Q_OBJECT
public:
    static Button *getButton(bool type, Line *line);
};

#endif // BUTTONFACTORY

