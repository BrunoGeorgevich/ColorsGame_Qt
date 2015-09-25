#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQmlContext>

#include "game.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    Game *game = new Game(5,5);

    QQmlApplicationEngine engine;
    QQmlContext *ctx = engine.rootContext();

    ctx->setContextProperty("_game", game);
    engine.load(QUrl("qrc:/main.qml"));
    return a.exec();
}
