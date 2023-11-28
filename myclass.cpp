#include "myclass.h"

QString MyClass::index() const
{
    return m_index;
}

//void MyClass::refreshIndex()
//{
//    usb_drive *val = NULL;
//    int num_devs = enumerate_usb_mass_storage(&val);

//    m_index = QString(val[1].vendor_name) + QString(val[1].model_name);


////    for (int i = 0;i<size;i++) {
////        printf("\n%s %s\n", val[i].vendor_name, val[i].model_name);
////        printf("%li\n", val[i].size);
////        printf("%s\n", val[i].devnode);
////    }
//    emit indexChanged();
//}



MyClass::MyClass(){
    usb_drive *val = NULL;
    int num_devs = enumerate_usb_mass_storage(&val);

    if(num_devs>0){
    m_index = QString(val[0].vendor_name) + QString(val[0].model_name) + "\t(" + QString(val[0].devnode) + ")";
    }else{
    m_index = QString("No USB devices found");
    }
    emit indexChanged();

}
