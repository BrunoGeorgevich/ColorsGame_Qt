#ifndef SETTINGS_H
#define SETTINGS_H

#include <QObject>
#include <QDebug>

class Settings : public QObject
{
    Q_OBJECT

public:

    Settings();
    Settings(int rows,
             int columns,
             QString difficulty,
             QString primary,
             QString secondary);

    void printStructure();

    Q_INVOKABLE int numOfRows() const;
    Q_INVOKABLE void setNumOfRows(int numOfRows);

    Q_INVOKABLE int numOfColumns() const;
    Q_INVOKABLE void setNumOfColumns(int numOfColumns);

    Q_INVOKABLE QString difficulty() const;
    Q_INVOKABLE void setDifficulty(const QString &difficulty);

    Q_INVOKABLE QString primaryColor() const;
    Q_INVOKABLE void setPrimaryColor(const QString &primaryColor);

    Q_INVOKABLE QString secondaryColor() const;
    Q_INVOKABLE void setSecondaryColor(const QString &secondaryColor);

private:

    int _numOfRows;
    int _numOfColumns;
    QString _difficulty;
    QString _primaryColor;
    QString _secondaryColor;
};

#endif // SETTINGS_H
