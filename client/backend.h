#ifndef backend_h
#define backend_h

#include <QObject>

class Backend : public QObject{
	Q_OBJECT
	public:
		Q_INVOKABLE void showKeyboard();
};

#endif//backend_h
