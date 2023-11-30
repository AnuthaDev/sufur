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
    Q_PROPERTY(QList<QString> model READ model NOTIFY modelChanged)

public:
    QString index() const;
    QList<QString> model() const;
    MyClass();

//public slots:

signals:
    void indexChanged();
    void modelChanged();
private:
    QString m_index = "null";
    QList<QString> m_model;
};
#endif // MYCLASS_H
