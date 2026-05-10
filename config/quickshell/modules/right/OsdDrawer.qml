import QtQuick
import "../../services"

Item {
    id: root

    property bool open: false
    property real offsetScale: open ? 0 : 1

    implicitWidth: 112
    implicitHeight: 180

    visible: offsetScale < 1

    Behavior on offsetScale {
        NumberAnimation {
            duration: Theme.animNormal
            easing.type: Easing.OutCubic
        }
    }

    anchors.rightMargin: -implicitWidth * offsetScale

    Rectangle {
        anchors.fill: parent
        color: Theme.bg
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        Row {
            anchors.centerIn: parent
            spacing: 8

            Column {
                anchors.verticalCenter: parent.verticalCenter
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
                width: 1
                height: 120
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.border
            }

            Column {
                anchors.verticalCenter: parent.verticalCenter
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