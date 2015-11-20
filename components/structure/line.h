#ifndef LINE_H
#define LINE_H

#include <QObject>

#include "components/external/qqmlhelpers.h"
#include "components/external/qqmlobjectlistmodel.h"

#include "components/buttons/rightbutton.h"
#include "components/buttons/commonbutton.h"

class Line : public QObject
{
    Q_OBJECT
    QML_WRITABLE_PROPERTY(int,columns)
    QML_WRITABLE_PROPERTY(int,rightBtnIndex)
    QML_WRITABLE_PROPERTY(bool,isFirst)
    QML_WRITABLE_PROPERTY(Line *, line)
public:
    Line();
    Line(int numOfColumns, int rightBtnIndex, bool status);
    Q_INVOKABLE QObject *getButtons();
public slots:
    void buttonClicked(bool isRight);
private:
    void generateButtons();
    QQmlObjectListModel<Button> *m_buttons;
};

#endif // LINE_H
