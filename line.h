#ifndef LINE_H
#define LINE_H

#include <QObject>

#include "rightbutton.h"
#include "commonbutton.h"

class Line : public QObject
{
    Q_OBJECT

public:

    Line(int numOfColumns, int rightBtnIndex, bool status);

    Q_INVOKABLE
    QList<QObject *> getButtons();

    Q_INVOKABLE
    bool isFirst();
    void setFirst(bool isFirst);

public slots:

    void buttonClicked(bool isRight);

signals:

    void aButtonWasClicked(bool);

private:

    int _columns;
    QList<QObject *> _buttons;

    bool _isFirst;

};

#endif // LINE_H
