import QtQuick
import Quickshell
import Quickshell.Io
import ".."
import "../../services"

Drawer {
    direction: "right"

    implicitWidth: bg.implicitWidth
    implicitHeight: bg.implicitHeight

    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter

    Rectangle {
        id: bg
        implicitWidth: col.implicitWidth + 24
        implicitHeight: col.implicitHeight + 24
        color: Theme.bg
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        Column {
            id: col
            anchors.centerIn: parent
            spacing: 8

            SessionButton {
                icon: "󰍃"
                command: ["bash", "-c", "hyprctl dispatch exit"]
            }

            SessionButton {
                icon: "󰒲"
                command: ["bash", "-c", "systemctl suspend"]
            }

            SessionButton {
                icon: "󰜉"
                command: ["bash", "-c", "systemctl reboot"]
            }

            SessionButton {
                icon: "󰐥"
                command: ["bash", "-c", "systemctl poweroff"]
            }

            component SessionButton: Rectangle {
                id: btn

                required property string icon
                required property list<string> command

                width: 40
                height: 40
                radius: Theme.radius
                color: hover.hovered ? Theme.overlay : "transparent"

                Behavior on color {
                    ColorAnimation { duration: Theme.animFast }
                }

                HoverHandler {
                    id: hover
                }

                TapHandler {
                    onTapped: Quickshell.execDetached(btn.command)
                }

                Text {
                    anchors.centerIn: parent
                    text: btn.icon
                    color: hover.hovered ? Theme.accent : Theme.text
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 18

                    Behavior on color {
                        ColorAnimation { duration: Theme.animFast }
                    }
                }
            }
        }
    }
}