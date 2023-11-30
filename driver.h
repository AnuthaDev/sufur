#ifndef DRIVER_H
#define DRIVER_H

#include <QGuiApplication>
#include <QQuickView>
#include <QQuickItem>

extern "C" {

#include "libsufur/libsufur.h"

}

class Driver : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString index READ index NOTIFY indexChanged)
    Q_PROPERTY(QList<QString> model READ model NOTIFY modelChanged)

public:
    QString index() const;
    QList<QString> model() const;
    Driver();

public slots:
    void doStuff();

signals:
    void indexChanged();
    void modelChanged();
private:
    QString m_index = "null";
    QList<QString> m_model;
};
#endif // DRIVER_H
