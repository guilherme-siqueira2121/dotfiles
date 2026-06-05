import QtQuick
import "../../components"
import "../../services"

BarIcon {
    FadeIcon {
        anchors.centerIn: parent
        icon: Battery.charging ? "󰂄"
            : Battery.level > 80 ? "󰁹"
            : Battery.level > 50 ? "󰂀"
            : Battery.level > 20 ? "󰁽"
            : "󰁺"
        color: Battery.level <= 20 ? "#e06c75" : Theme.accent
    }
}