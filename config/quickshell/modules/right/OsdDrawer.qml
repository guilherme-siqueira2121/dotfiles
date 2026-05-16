import QtQuick
import ".."
import "../../services"

Drawer {
    direction: "right"

    Column {
        spacing: Theme.drawerPadding

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

            VolumeSlider { id: volSlider }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: volSlider.level + "%"
                color: Theme.subtext
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
            }
        }

        Rectangle {
            width: Theme.sliderWidth
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

            BrightnessSlider { id: brightSlider }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: brightSlider.level + "%"
                color: Theme.subtext
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
            }
        }
    }
}