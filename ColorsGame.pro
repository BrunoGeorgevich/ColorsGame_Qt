#-------------------------------------------------
#
# Project created by QtCreator 2015-09-25T00:28:17
#
#-------------------------------------------------

QT       += core widgets quick qml

TARGET = ColorsGame
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES += main.cpp \
    line.cpp \
    rightbutton.cpp \
    commonbutton.cpp \
    game.cpp

HEADERS += \
    line.h \
    button.h \
    rightbutton.h \
    commonbutton.h \
    game.h

RESOURCES += \
    qml.qrc
