TEMPLATE += app
QT += quick

TARGET = cerbere
SOURCES += main.cpp

cerbere_serveur.target = cerbere-serveur
cerbere_serveur.commands = cd serveur; \
        shards build && cp bin/cerbere-serveur ..
cerbere_serveur.depends = serveur/src/


DISTFILES += \
    ../build-project-Desktop_Qt_5_14_2_MSVC2017_64bit-Debug/client/Application.qml \
    ../build-project-Desktop_Qt_5_14_2_MSVC2017_64bit-Debug/client/Board.qml \
    ../build-project-Desktop_Qt_5_14_2_MSVC2017_64bit-Debug/client/Game.qml \
    ../build-project-Desktop_Qt_5_14_2_MSVC2017_64bit-Debug/client/Lobby.qml \
    ../build-project-Desktop_Qt_5_14_2_MSVC2017_64bit-Debug/client/Login.qml
