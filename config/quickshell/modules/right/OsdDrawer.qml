import QtQuick
import ".."
import "../bar"
import "../../services"

Drawer {
    direction: "right"

    Column {
        spacing: Theme.drawerPadding

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 8

            FadeIcon {
                anchors.horizontalCenter: parent.horizontalCenter
                icon: volSlider.muted
                    ? "󰝟"
                    : volSlider.level < 30 ? "󰕿"
                    : volSlider.level < 70 ? "󰖀"
                    : "󰕾"
                color: volSlider.muted ? Theme.muted : Theme.accent
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

            FadeIcon {
                anchors.horizontalCenter: parent.horizontalCenter
                icon: brightSlider.level < 0 ? "󰃞"
                    : brightSlider.level < 30 ? "󰃞"
                    : brightSlider.level < 70 ? "󰃟"
                    : "󰃠"
                color: Theme.accent
            }

            BrightnessSlider { id: brightSlider }

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: brightSlider.level < 0 ? "..." : brightSlider.level + "%"
                color: Theme.subtext
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
            }
        }
    }
}