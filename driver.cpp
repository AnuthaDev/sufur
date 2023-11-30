#include "driver.h"

QString Driver::index() const
{
    return m_index;
}


QList<QString> Driver::model() const
{
    return m_model;
}


Driver::Driver(){
    usb_drive *val = NULL;
    int num_devs = enumerate_usb_mass_storage(&val);
    m_model = *new QList<QString>();

    for (int i = 0; i < num_devs; ++i) {
        QString str = QString(val[i].vendor_name).trimmed() + "  " + QString(val[i].model_name).trimmed() + "  (" + QString(val[i].devnode) + ")";
        m_model.append(str);
    }

    emit modelChanged();

}

void Driver::doStuff(){
    qDebug()<<"The beginning of the end\n";

}
