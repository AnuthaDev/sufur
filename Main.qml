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
    color: palette.window
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
            color: palette.text
        }
        Text {
            id: device_txt
            text: qsTr("Device")
            font.pointSize: 12
            color: palette.text


        }
        ComboBox {
            id: device_combo
            model: Driver.model
            Layout.fillWidth: true
            Layout.preferredHeight: 26
            enabled: model.length > 0
            displayText: model.length === 0 ? "No USB devices detected" : currentText
            palette{
                button: palette.button
                text: palette.text
                buttonText: palette.buttonText
                window: palette.window
            }
        }
        Text {
            id: bootsel_txt
            text: qsTr("Boot Selection")
            font.pointSize: 12
            color: palette.text


        }
        RowLayout{
            Layout.fillWidth: true
            ComboBox {
                id: bootsel_combo
                model: ["Disk or ISO image (Please Select)", "Non Bootable"]
                // model: [fileDialog.selectedFile.toString().length === 0 ? "Disk or ISO image (Please Select)":fileDialog.selectedFile, "Non Bootable"]
                enabled: device_combo.model.length > 0
                Layout.preferredHeight: 26
                Layout.fillWidth: true

                onActivated: {
                    var txt = currentIndex
                    model = ["Disk or ISO image (Please Select)", "Non Bootable"];
                    currentIndex = txt

                    console.log(bootsel_combo.palette.base)
                }
                palette{
                    button: palette.button
                    text: palette.text
                    buttonText: palette.buttonText
                    window: palette.window
                }






            }
            Button{
                id: bootsel_button
                text: "SELECT"
                onClicked: {
                    fileDialog.open()
                }
                palette{
                    button: palette.button
                    buttonText: palette.buttonText
                    window: palette.window
                }

            }
        }

        Text {
            id: format_ops
            text: qsTr("Format Options")
            font.pointSize: 20
            color: palette.text

        }
        Text {
            id: vol_txt
            text: qsTr("Volume label")
            font.pointSize: 12
            color: palette.text

        }
        TextField{
            id: vol_field
            text: "Ubuntu"
            Layout.fillWidth: true
            palette{
                button: palette.button
                buttonText: palette.buttonText
                window: palette.window
                base: palette.base
                text: palette.text
            }
        }
        Text {
            id: fs_txt
            text: qsTr("File System")
            font.pointSize: 12
            color: palette.text


        }
        ComboBox {
            id: fs_combo
            width: 200
            Layout.preferredHeight: 26

            model: [ "FAT32 (Default)", "NTFS" ]
            palette{
                button: palette.button
                text: palette.text
                buttonText: palette.buttonText
                window: palette.window
            }
        }

        Text {
            id: status_head
            text: qsTr("Status")
            font.pointSize: 20
            color: palette.text

        }
        Rectangle{
            id: status_txt
            Layout.fillWidth: true


            width: parent.width
            height: childrenRect.height
            color: palette.mid

            Text {
                text: qsTr("READY")
                font.pointSize: 12
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                color: palette.text

            }
        }
        RowLayout{
            Layout.alignment: Qt.AlignRight
            Layout.topMargin: 20
            Button{
                id: start_btn
                text: "START"
                onClicked: {
                    if(bootsel_combo.currentIndex === 1){  // Non-bootable selected
                     Driver.doStuff()
                    }
                }
                palette{
                    button: palette.button
                    buttonText: palette.buttonText
                    window: palette.window
                }
            }
            Button{
                id: close_btn
                text: "CLOSE"
                onClicked: Qt.callLater(Qt.quit)
                palette{
                    button: palette.button
                    buttonText: palette.buttonText
                    window: palette.window
                }
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
        color: palette.text

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
            bootsel_combo.model = [selectedFile.toString(), "Non Bootable"]
        }
    }

    SystemPalette {
         id: palette
         colorGroup: SystemPalette.Active
     }
}
