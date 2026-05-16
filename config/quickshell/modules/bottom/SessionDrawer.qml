import QtQuick
import Quickshell
import ".."
import "../../services"

Drawer {
    direction: "right"

    Column {
        spacing: 8

        SessionButton { icon: "󰍃"; command: ["hyprctl", "dispatch", "exit"] }
        SessionButton { icon: "󰒲"; command: ["systemctl", "suspend"] }
        SessionButton { icon: "󰜉"; command: ["systemctl", "reboot"] }
        SessionButton { icon: "󰐥"; command: ["systemctl", "poweroff"] }
    }

    component SessionButton: Rectangle {
        id: btn

        required property string icon
        required property string label
        required property list<string> command

        implicitWidth: row.implicitWidth  + 16
        implicitHeight: row.implicitHeight + 16
        radius: Theme.radius
        color: hover.hovered ? Theme.overlay : "transparent"

        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }

        HoverHandler { id: hover }

        TapHandler {
            onTapped: Quickshell.execDetached(btn.command)
        }

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 10

            Text {
                text: btn.icon
                color: hover.hovered ? Theme.accent : Theme.text
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 18
                anchors.verticalCenter: parent.verticalCenter

                Behavior on color {
                    ColorAnimation { duration: Theme.animFast }
                }
            }

            Text {
                text: btn.label
                color: hover.hovered ? Theme.accent : Theme.subtext
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                anchors.verticalCenter: parent.verticalCenter

                Behavior on color {
                    ColorAnimation { duration: Theme.animFast }
                }
            }
        }
    }
}