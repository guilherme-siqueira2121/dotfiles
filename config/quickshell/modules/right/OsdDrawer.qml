import QtQuick
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
        implicitWidth: col.implicitWidth + 32
        implicitHeight: col.implicitHeight + 32
        color: Theme.bg
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        Column {
            id: col
            anchors.centerIn: parent
            spacing: 16

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "󰕾"
                    color: Theme.accent
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 14
                }

                VolumeSlider {
                    id: volSlider
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: volSlider.level + "%"
                    color: Theme.subtext
                    font.pixelSize: 10
                    font.family: "JetBrains Mono Nerd Font"
                }
            }

            Rectangle {
                width: 28
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                color: Theme.border
            }

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 8

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "󰃟"
                    color: Theme.accent
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 14
                }

                BrightnessSlider {
                    id: brightSlider
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: brightSlider.level + "%"
                    color: Theme.subtext
                    font.pixelSize: 10
                    font.family: "JetBrains Mono Nerd Font"
                }
            }
        }
    }
}