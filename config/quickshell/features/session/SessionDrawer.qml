import QtQuick
import Quickshell
import "../../core"
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

        property bool confirming: false

        implicitWidth: 40
        implicitHeight: 40
        radius: Theme.radius
        color: confirming ? Theme.accent
            : hover.hovered ? Theme.overlay
            : "transparent"

        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }

        HoverHandler { id: hover }

        Timer {
            id: confirmTimeout
            interval: 2000
            onTriggered: btn.confirming = false
        }

        TapHandler {
            onTapped: {
                if (btn.confirming) {
                    confirmTimeout.stop()
                    btn.confirming = false
                    Quickshell.execDetached(btn.command)
                } else {
                    btn.confirming = true
                    confirmTimeout.restart()
                }
            }
        }

        Text {
            anchors.centerIn: parent
            text: btn.confirming ? "󰄬" : btn.icon
            color: btn.confirming ? Theme.bg
                : hover.hovered ? Theme.text
                : Theme.accent
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 18

            Behavior on color {
                ColorAnimation { duration: Theme.animFast }
            }
        }
    }
}