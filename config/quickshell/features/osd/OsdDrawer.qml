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
                icon: Audio.muted ? "󰝟"
                    : Audio.volume < 30 ? "󰕿"
                    : Audio.volume < 70 ? "󰖀"
                    : "󰕾"
                color: Audio.muted ? Theme.muted : Theme.accent
            }

            VolumeSlider {}

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: Audio.volume + "%"
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
                icon: Brightness.level < 0 ? "󰃞"
                    : Brightness.level < 30 ? "󰃞"
                    : Brightness.level < 70 ? "󰃟"
                    : "󰃠"
                color: Theme.accent
            }

            BrightnessSlider {}

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: Brightness.level < 0 ? "..." : Brightness.level + "%"
                color: Theme.subtext
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
            }
        }
    }
}