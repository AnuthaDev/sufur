#ifndef MYCLASS_H
#define MYCLASS_H

#include <QGuiApplication>
#include <QQuickView>
#include <QQuickItem>

extern "C" {

#include "libsufur/libsufur.h"

}

class MyClass : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString index READ index NOTIFY indexChanged)

public:
    QString index() const;
    MyClass();

//public slots:

signals:
    void indexChanged();
private:
    QString m_index = "null";
};
#endif // MYCLASS_H
