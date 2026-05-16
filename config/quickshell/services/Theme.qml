pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property color bg: "#f4f4f8"
    readonly property color surface: "#ececf2"
    readonly property color overlay: "#e2e2ea"
    readonly property color text: "#1a1a2e"
    readonly property color subtext: "#5a5a7a"
    readonly property color border: "#c8c8da"
    readonly property color accent: "#6c63ff"
    readonly property color muted: "#a0a0b8"

    readonly property int barWidth: 54
    readonly property int barBorder: 14
    readonly property int radius: 12
    readonly property int animFast: 150
    readonly property int animNormal: 250
    readonly property int drawerPadding: 16
    readonly property int sliderWidth: 28
    readonly property int sliderHeight: 120
}