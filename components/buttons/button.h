#ifndef BUTTON
#define BUTTON

#include <QObject>
#include <QDebug>

#include "components/external/qqmlhelpers.h"

class Button : public QObject
{
    Q_OBJECT
    QML_WRITABLE_PROPERTY(bool,status)
    QML_WRITABLE_PROPERTY(Button *,btn)
public:
    Q_INVOKABLE
    void run() { emit clicked(m_status); }
signals:
    void clicked(bool);
};

#endif // BUTTON

