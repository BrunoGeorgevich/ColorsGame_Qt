#ifndef BUTTON
#define BUTTON

#include <QObject>
#include <QDebug>

class Button : public QObject
{
    Q_OBJECT

public:

    Q_INVOKABLE
    virtual void run() = 0;

    Q_INVOKABLE
    bool getStatus() {
        return _status;
    }

signals:

    void clicked(bool);

protected:

    bool _status;
};

#endif // BUTTON

