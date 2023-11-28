#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <cstdio>
#include <iostream>


extern "C" {
#include "libsufur/libsufur.h"
}

int main(int argc, char *argv[])
{
    usb_drive *val = NULL;
    int size = enumerate_usb_mass_storage(&val);

    for (int i = 0;i<size;i++) {
        printf("\n%s %s\n", val[i].vendor_name, val[i].model_name);
        printf("%li\n", val[i].size);
        printf("%s\n", val[i].devnode);
    }
    std::cout<<std::endl;
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/sufur/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
