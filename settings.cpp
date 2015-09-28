#include "settings.h"

Settings::Settings()
{
    setNumOfRows(3);
    setNumOfColumns(3);
    setDifficulty("Fácil");
    setPrimaryColor("Black");
    setSecondaryColor("White");
}

Settings::Settings(int rows, int columns, QString difficulty, QString primary, QString secondary)
{
    setNumOfRows(rows);
    setNumOfColumns(columns);
    setDifficulty(difficulty);
    setPrimaryColor(primary);
    setSecondaryColor(secondary);
}

void Settings::printStructure()
{
    qDebug() << "Linhas : " << numOfRows();
    qDebug() << "Colunas : " << numOfColumns();
    qDebug() << "Dificuldade : " << qPrintable(difficulty());
    qDebug() << "Cor primária : " << primaryColor();
    qDebug() << "Cor secundária : " << secondaryColor();
}
int Settings::numOfRows() const
{
    return _numOfRows;
}

void Settings::setNumOfRows(int numOfRows)
{
    _numOfRows = numOfRows;
}
int Settings::numOfColumns() const
{
    return _numOfColumns;
}

void Settings::setNumOfColumns(int numOfColumns)
{
    _numOfColumns = numOfColumns;
}
QString Settings::difficulty() const
{
    return _difficulty;
}

void Settings::setDifficulty(const QString &difficulty)
{
    _difficulty = difficulty;
}
QString Settings::primaryColor() const
{
    return _primaryColor;
}

void Settings::setPrimaryColor(const QString &primaryColor)
{
    _primaryColor = primaryColor;
}
QString Settings::secondaryColor() const
{
    return _secondaryColor;
}

void Settings::setSecondaryColor(const QString &secondaryColor)
{
    _secondaryColor = secondaryColor;
}






