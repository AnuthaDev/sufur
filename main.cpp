#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "driver.h"



int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Driver *driver = new Driver();
    qmlRegisterSingletonInstance("com.sufur.Driver", 1, 0, "Driver", driver);
    const QUrl url(u"qrc:/sufur/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);


    return app.exec();
}
