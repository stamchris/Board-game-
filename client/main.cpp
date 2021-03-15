#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>

#include <libgen.h>

#ifdef EMSCRIPTEN
	#include <emscripten.h>
	#include <emscripten/val.h>
#endif

#include "backend.h"

int main(int argc, char *argv[])
{
	#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
		QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	#endif

	QGuiApplication app(argc, argv);
    app.setWindowIcon(QIcon("cerbere-victoire.jpg"));


	QQmlApplicationEngine engine;
	const QUrl url(QStringLiteral("qrc:/Application.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
			 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	QString root_url;
	#ifdef EMSCRIPTEN
		std::string location_href = emscripten::val::global("location")["href"].as<std::string>();
		char* copy = new char[location_href.size()];
		strncpy(copy, location_href.c_str(), location_href.size());
		root_url = QString(dirname(copy))+'/';
		delete[] copy;
	#else
		root_url = engine.baseUrl().toString();
	#endif
	engine.rootContext()->setContextProperty("ROOT_URL", root_url);
	Backend backend;
	engine.rootContext()->setContextProperty("Backend", &backend);
	engine.load(url);
	return app.exec();
}
