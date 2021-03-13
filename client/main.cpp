#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <libgen.h>

#ifdef EMSCRIPTEN
	#include <emscripten.h>
	#include <emscripten/val.h>
#endif

int main(int argc, char *argv[])
{
	#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
		QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	#endif

	#ifdef EMSCRIPTEN
		qputenv("QT_IM_MODULE", "qtvirtualkeyboard");
	#endif

	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;
	#ifdef EMSCRIPTEN
		const QUrl url(QStringLiteral("qrc:/ApplicationWeb.qml"));
	#else
		const QUrl url(QStringLiteral("qrc:/Application.qml"));
	#endif
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
			 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	QString root_url;
	bool web;
	#ifdef EMSCRIPTEN
		std::string location_href = emscripten::val::global("location")["href"].as<std::string>();
		char* copy = new char[location_href.size()];
		strncpy(copy, location_href.c_str(), location_href.size());
		root_url = QString(dirname(copy))+'/';
		delete[] copy;
		web = true;
	#else
		root_url = engine.baseUrl().toString();
		web = false;
	#endif
	engine.rootContext()->setContextProperty("ROOT_URL", root_url);
	engine.rootContext()->setContextProperty("WEB", web);
	engine.load(url);
	return app.exec();
}
