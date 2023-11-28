#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "myclass.h"



int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MyClass *myClass = new MyClass();
    qmlRegisterSingletonInstance("com.sufur.MyClass", 1, 0, "MyClass", myClass);
    const QUrl url(u"qrc:/sufur/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);


    return app.exec();
}
