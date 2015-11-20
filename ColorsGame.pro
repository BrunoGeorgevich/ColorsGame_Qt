#-------------------------------------------------
#
# Project created by QtCreator 2015-09-25T00:28:17
#
#-------------------------------------------------

QT       += core widgets quick qml svg sql

TARGET = ColorsGame
CONFIG   += console
CONFIG   -= app_bundle

TEMPLATE = app


SOURCES +=                                      \
    main.cpp                                    \
    components/structure/line.cpp               \
    components/structure/game.cpp               \
    components/structure/settings.cpp           \
    components/buttons/rightbutton.cpp          \
    components/buttons/commonbutton.cpp         \
    components/external/qqmlobjectlistmodel.cpp \
    components/external/qqmlhelpers.cpp         \
    components/external/database.cpp

HEADERS +=                                      \
    components/structure/line.h                 \
    components/structure/game.h                 \
    components/structure/settings.h             \
    components/buttons/button.h                 \
    components/buttons/rightbutton.h            \
    components/buttons/commonbutton.h           \
    components/external/qqmlobjectlistmodel.h   \
    components/external/qqmlhelpers.h           \
    components/external/database.h

RESOURCES += \
    qml.qrc \
    images.qrc
