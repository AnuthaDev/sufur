import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtCore

import com.sufur.Driver

Window {
    id: window
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
            model: Driver.model
            Layout.fillWidth: true
            Layout.preferredHeight: 26
            enabled: model.length > 0
            displayText: model.length === 0 ? "No USB devices detected" : currentText
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
                model: Driver.isomodel
                // model: [fileDialog.selectedFile.toString().length === 0 ? "Disk or ISO image (Please Select)":fileDialog.selectedFile, "Non Bootable"]
                enabled: device_combo.model.length > 0
                Layout.preferredHeight: 26
                Layout.fillWidth: true

                onActivated: {
                    var txt = currentIndex
                    model = ["Disk or ISO image (Please Select)", "Non Bootable"];
                    currentIndex = txt

                }

            }
            Button{
                id: bootsel_button
                text: "SELECT"
                onClicked: {
                    fileDialog.open()
                }
            }
        }
        RowLayout{
            Layout.fillWidth: true
            ColumnLayout{
                Layout.fillWidth: true

                Text {
                    Layout.fillWidth: true
                    text: qsTr("Partition Scheme")
                    font.pointSize: 12
                }
                ComboBox {
                    id: partscheme_combo
                    model: ["GPT"]
                    Layout.preferredHeight: 26
                    Layout.fillWidth: true
                    Layout.rightMargin: 15
                }

            }
            ColumnLayout{
                Layout.fillWidth: true

                Text {
                    Layout.fillWidth: true
                    text: qsTr("Target System")
                    font.pointSize: 12
                }
                ComboBox {
                    id: tgtsystem_combo
                    model: ["UEFI (non CSM)"]
                    Layout.preferredHeight: 26
                    Layout.fillWidth: true
                }
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
            model: [ "FAT32 (Default)", "NTFS", "exFAT", "ext2", "ext3", "ext4" ]
        }

        Text {
            id: status_head
            text: qsTr("Status")
            font.pointSize: 20

        }
        Rectangle{
            id: status_txt
            Layout.fillWidth: true
            color: "#aaaaaa"
            width: parent.width
            height: childrenRect.height

            Text {
                text: Driver.statustxt
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
                onClicked: {
                    if(bootsel_combo.currentIndex === 0){  // Non-bootable selected
                     Driver.doStuff()
                    }
                }
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
        text: device_combo.model.length +  " devices found"
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

    FileDialog{
        id: fileDialog
        title: "Pick ISO file"
        currentFolder: StandardPaths.standardLocations(StandardPaths.DownloadLocation)[0]
        onAccepted: {
//            bootsel_combo.model = [selectedFile, "Non Bootable"]
            Driver.analyze_ISO(selectedFile)
        }
    }
}
