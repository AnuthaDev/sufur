import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 540
    height: 720
    maximumHeight: height
    maximumWidth: width

    minimumHeight: height
    minimumWidth: width
    visible: true
    title: qsTr("Sufur")
    ColumnLayout{
        spacing: 3
        id: main_column
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top

            margins: 15
        }

        Text {
            id: drive_props
            text: qsTr("Drive Properties")
            font.pointSize: 20
        }
        Text {
            id: device_txt
            text: qsTr("Device")
            font.pointSize: 12

        }
        ComboBox {
            id: device_combo
            model: [ "None" ]
            enabled: false
            Layout.fillWidth: true
            Layout.preferredHeight: 26


        }
        Text {
            id: bootsel_txt
            text: qsTr("Boot Selection")
            font.pointSize: 12

        }
        RowLayout{
            Layout.fillWidth: true
            ComboBox {
                id: bootsel_combo
                model: [ "Disk or ISO image (Please Select)" ]
                enabled: false
                Layout.preferredHeight: 26
                Layout.fillWidth: true

            }
            Button{
                id: bootsel_button
                text: "SELECT"

            }
        }

        Text {
            id: format_ops
            text: qsTr("Format Options")
            font.pointSize: 20
        }
        Text {
            id: vol_txt
            text: qsTr("Volume label")
            font.pointSize: 12
        }
        TextField{
            id: vol_field
            text: "Ubuntu"
            Layout.fillWidth: true
        }
        Text {
            id: fs_txt
            text: qsTr("File System")
            font.pointSize: 12

        }
        ComboBox {
            id: fs_combo
            width: 200
            Layout.preferredHeight: 26

            model: [ "FAT32 (Default)" ]
        }

        Text {
            id: status_head
            text: qsTr("Status")
            font.pointSize: 20
        }
        Rectangle{
            color: "#eeeeee"
            id: status_txt
            Layout.fillWidth: true


            width: parent.width
            height: childrenRect.height
            Text {
                text: qsTr("READY")
                font.pointSize: 12
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }
        }
        RowLayout{
            Layout.alignment: Qt.AlignRight
            Layout.topMargin: 20
            Button{
                id: start_btn
                text: "START"
            }
            Button{
                id: close_btn
                text: "CLOSE"
                onClicked: Qt.callLater(Qt.quit)
            }
        }

    }
    Text{
        id: numdev_txt
        text: "0 devices found"
        font.pointSize: 11
        anchors{
            left: parent.left
            bottom: parent.bottom
            leftMargin: 5
        }
    }


    Text{
        id: elapsed_txt
        text: "00:00:00"
        font.pointSize: 11
        color: "#aaaaaa"
        anchors{
            right: parent.right
            bottom: parent.bottom
            rightMargin: 5
        }
    }
}
