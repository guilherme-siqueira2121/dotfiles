import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: 48
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        color: "#dbdeef"
        radius: 12

        Column {
            anchors.centerIn: parent
            spacing: 8

            SidebarItem {
                icon.text: wifiIcon.text
                icon.color: wifiIcon.color
                command: "kitty -e nmtui"
                WifiIcon
                 { id: wifiIcon; visible: false }
            }

            SidebarItem {
                icon.text: btIcon.text
                icon.color: btIcon.color
                command: "blueman-manager"
                BluetoothIcon { id: btIcon; visible: false }
            }

            SidebarItem {
                icon.text: volIcon.text
                icon.color: volIcon.color
                command: "pavucontrol"
                VolumeIcon { id: volIcon; visible: false }
            }

            SidebarItem {
                icon.text: brightIcon.text
                icon.color: brightIcon.color
                command: ""
                BrightnessIcon { id: brightIcon; visible: false}
            }
        }
    }
}