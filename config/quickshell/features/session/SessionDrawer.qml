import QtQuick
import Quickshell
import "../../core"
import "../../services"

Drawer {
    direction: "right"

    Column {
        spacing: 8

        SessionButton { icon: "󰍃"; command: ["hyprctl", "dispatch", "exit"]; requireHold: false }
        SessionButton { icon: "󰒲"; command: ["systemctl", "suspend"]; requireHold: false }
        SessionButton { icon: "󰜉"; command: ["systemctl", "reboot"]; requireHold: true }
        SessionButton { icon: "󰐥"; command: ["systemctl", "poweroff"]; requireHold: true }
    }

    component SessionButton: Rectangle {
        id: btn

        required property string icon
        required property list<string> command
        required property bool requireHold

        implicitWidth: 40
        implicitHeight: 40
        radius: Theme.radius
        color: hover.hovered ? Theme.overlay : "transparent"

        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }

        HoverHandler { id: hover }

        TapHandler {
            enabled: !btn.requireHold
            onTapped: Quickshell.execDetached(btn.command)
        }

        LongPressHandler {
            id: longPress
            anchors.fill: parent
            enabled: btn.requireHold
            duration: 800
            onActivated: Quickshell.execDetached(btn.command)
        }

        Rectangle {
            visible: btn.requireHold && hover.hovered
            anchors.centerIn: parent
            width: 36
            height: 36
            radius: Theme.radius
            color: "transparent"

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height * longPress.progress
                radius: Theme.radius
                color: Theme.accent
                opacity: 0.25
            }
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