#include <QQmlApplicationEngine>
#include <QApplication>
#include <QQmlContext>
#include <QtQml>

#include "components/structure/game.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    qmlRegisterType<Line>("line",1,0,"Line");
    QQmlApplicationEngine engine;
    QQmlContext *ctx = engine.rootContext();
    ctx->setContextProperty("_game", Game::getInstance());
    engine.load(QUrl("qrc:/main.qml"));
    return a.exec();
}
