#include "driver.h"

QString Driver::index() const
{
    return m_index;
}


QList<QString> Driver::model() const
{
    return m_model;
}

QList<QString> Driver::isomodel() const
{
    return m_isomodel;
}

QString Driver::statustxt() const
{
    return m_statustxt;
}

void Driver::wrapper(char *str, void* obj){
    ((Driver*)obj)->do_log(str);
}

void Driver::do_log(char* str){
    m_statustxt = QString(str);
    emit statustxtChanged();
}


Driver::Driver(){
    int num_devs = enumerate_usb_mass_storage(&m_drives);
    m_drives_size = num_devs;
    m_model = *new QList<QString>();
    m_isomodel = *new QList<QString>();
    m_isomodel.append("Disk or ISO image (Please Select)");
    m_isomodel.append("Non Bootable");


    for (int i = 0; i < num_devs; ++i) {
        QString str = QString(m_drives[i].vendor_name).trimmed() + "  " + QString(m_drives[i].model_name).trimmed() + "  (" + QString(m_drives[i].devnode) + ") " + QString::number(m_drives[i].size);
        m_model.append(str);
    }

    emit modelChanged();
    emit isomodelChanged();

    log_set_func(&Driver::wrapper, this);

}

void Driver::doStuff(){
    make_bootable(&m_drives[0], &m_props);


}

void Driver::analyze_ISO(QUrl url){
    qDebug()<<url.path();

    m_props.path = url.path().toUtf8().data();
    int error = get_iso_properties(&m_props);
    if(error){
        qDebug()<<"Error while analyzing ISO";
    }else{
        m_isomodel[0] = url.path();

        emit isomodelChanged();
        qDebug()<<"Is windows? "<<m_props.isWindowsISO;

    }
}
