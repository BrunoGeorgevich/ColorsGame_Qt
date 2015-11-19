#include "settings.h"

Settings::Settings()
{
    set_rows(3);
    set_columns(3);
    set_difficulty("Fácil");
    set_primaryColor("Black");
    set_secondaryColor("White");
}

Settings::Settings(int rows, int columns, QByteArray difficulty, QByteArray primary, QByteArray secondary)
{
    set_rows(rows);
    set_columns(columns);
    set_difficulty(difficulty);
    set_primaryColor(primary);
    set_secondaryColor(secondary);
}

void Settings::printStructure()
{
    qDebug() << "Linhas : " << get_rows();
    qDebug() << "Colunas : " << get_columns();
    qDebug() << "Dificuldade : " << qPrintable(get_difficulty());
    qDebug() << "Cor primária : " << get_primaryColor();
    qDebug() << "Cor secundária : " << get_secondaryColor();
}






