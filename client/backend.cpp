#include "backend.h"

#include <QGuiApplication>

void Backend::showKeyboard(){
	QGuiApplication::inputMethod()->show();
}
