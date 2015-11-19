#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QDebug>

#include <components/external/qqmlhelpers.h>

class Settings : public QObject
{
    Q_OBJECT
    QML_WRITABLE_PROPERTY(QByteArray, primaryColor)
    QML_WRITABLE_PROPERTY(QByteArray, secondaryColor)
    QML_WRITABLE_PROPERTY(QByteArray, difficulty)
    QML_WRITABLE_PROPERTY(int, rows)
    QML_WRITABLE_PROPERTY(int, columns)
public:
    Settings();
    Settings(int rows,
             int columns,
             QByteArray difficulty,
             QByteArray primary,
             QByteArray secondary);
    void printStructure();
};

#endif // SETTINGS_H
