#ifndef DRIVER_H
#define DRIVER_H

#include <QGuiApplication>
#include <QQuickView>
#include <QQuickItem>

extern "C" {

#include "libsufur/libsufur.h"
#include "libsufur/log.h"
}

class Driver : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString index READ index NOTIFY indexChanged)
    Q_PROPERTY(QList<QString> model READ model NOTIFY modelChanged)
    Q_PROPERTY(QList<QString> isomodel READ isomodel NOTIFY isomodelChanged)
    Q_PROPERTY(QString statustxt READ statustxt NOTIFY statustxtChanged)


public:
    QString index() const;
    QList<QString> model() const;
    QList<QString> isomodel() const;
    QString statustxt() const;
    void do_log(char* str);
    static void wrapper(char *str, void* obj);

    Driver();

public slots:
    void doStuff();
    void analyze_ISO(QUrl str);

signals:
    void indexChanged();
    void modelChanged();
    void isomodelChanged();
    void statustxtChanged();

private:
    QString m_index = "null";
    QList<QString> m_model;
    QList<QString> m_isomodel;
    usb_drive *m_drives = NULL;
    int m_drives_size = 0;
    iso_props m_props = {};
    QString m_statustxt = "READY";


};
#endif // DRIVER_H
