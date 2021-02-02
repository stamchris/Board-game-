TEMPLATE += app
QT += quick

TARGET = cerbere
SOURCES += main.cpp

cerbere_serveur.target = cerbere-serveur
cerbere_serveur.commands = cd serveur; \
	shards build; \
	cp bin/cerbere-serveur ..
cerbere_serveur.depends = serveur/src/main.cr

QMAKE_EXTRA_TARGETS += cerbere_serveur

