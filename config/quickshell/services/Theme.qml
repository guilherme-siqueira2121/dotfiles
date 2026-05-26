pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property color bg: "#f5f0e8"
    readonly property color surface: "#ede8de"
    readonly property color overlay: "#e4ddd2"
    readonly property color text: "#2c2416"
    readonly property color subtext: "#6b5c45"
    readonly property color border: "#d4c9b8"
    readonly property color accent: "#c8a97e"
    readonly property color muted: "#a8997e"

    readonly property int barWidth: 54
    readonly property int barBorder: 14
    readonly property int radius: 12
    readonly property int animFast: 150
    readonly property int animNormal: 250
    readonly property int drawerPadding: 16
    readonly property int sliderWidth: 28
    readonly property int sliderHeight: 120
}