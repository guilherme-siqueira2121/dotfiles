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
        required property list<string> command

        implicitWidth: 40
        implicitHeight: 40
        radius: Theme.radius
        color: hover.hovered ? Theme.overlay : "transparent"

        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }

        HoverHandler { id: hover }

        TapHandler {
            onTapped: Quickshell.execDetached(btn.command)
        }

        Text {
            anchors.centerIn: parent
            text: btn.icon
            color: hover.hovered ? Theme.text : Theme.accent
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 18

            Behavior on color {
                ColorAnimation { duration: Theme.animFast }
            }
        }
    }
}