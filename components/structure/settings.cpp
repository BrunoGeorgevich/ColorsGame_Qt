#include "settings.h"

Settings::Settings()
{
    set_numOfRows(3);
    set_numOfColumns(3);
    set_difficulty("Fácil");
    set_primaryColor("Black");
    set_secondaryColor("White");
}

Settings::Settings(int rows, int columns, QByteArray difficulty, QByteArray primary, QByteArray secondary)
{
    set_numOfRows(rows);
    set_numOfColumns(columns);
    set_difficulty(difficulty);
    set_primaryColor(primary);
    set_secondaryColor(secondary);
}

void Settings::printStructure()
{
    qDebug() << "Linhas : " << get_numOfRows();
    qDebug() << "Colunas : " << get_numOfColumns();
    qDebug() << "Dificuldade : " << qPrintable(get_difficulty());
    qDebug() << "Cor primária : " << get_primaryColor();
    qDebug() << "Cor secundária : " << get_secondaryColor();
}






