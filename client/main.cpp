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

	bool needs_virtual_keyboard;
	#ifdef EMSCRIPTEN
		// https://developer.mozilla.org/en-US/docs/Web/HTTP/Browser_detection_using_the_user_agent#Mobile_Device_Detection
		needs_virtual_keyboard = EM_ASM_INT({
			let res = false;
			if("maxTouchPoints" in navigator){
				res = (navigator.maxTouchPoints > 0);
			}else if("msMaxTouchPoints" in navigator){
				res = (navigator.msMaxTouchPoints > 0);
			}else{
				let mQ = window.matchMedia && matchMedia("(pointer:coarse)");
				if(mQ && mQ.media === "(pointer:coarse)"){
					res = !!mQ.matches;
				}else if("orientation" in window){
					res = true;
				}else{
					let ua = navigator.userAgent;
					res = (new Regexp("\\b(Blackberry|webOS|iPhone|IEMobile)\\b",'i').test(ua)
						|| new Regexp("\\b(Android|Windows Phone|iPad|iPod)\\b",'i').test(ua)
					);
				}
			}
			return res;
		});
		if(needs_virtual_keyboard){
			qputenv("QT_IM_MODULE", "qtvirtualkeyboard");
		}
	#else
		needs_virtual_keyboard = false;
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
	engine.rootContext()->setContextProperty("NEEDS_VIRTUAL_KEYBOARD", needs_virtual_keyboard);
	engine.load(url);
	return app.exec();
}
