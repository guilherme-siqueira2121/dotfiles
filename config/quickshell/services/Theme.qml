pragma Singleton
import QtQuick
import Quickshell
import "./themes"

Singleton {
    readonly property color bg: ThemeManager.current === "dark" ? Dark.bg      : Light.bg
    readonly property color surface: ThemeManager.current === "dark" ? Dark.surface : Light.surface
    readonly property color overlay: ThemeManager.current === "dark" ? Dark.overlay : Light.overlay
    readonly property color text: ThemeManager.current === "dark" ? Dark.text    : Light.text
    readonly property color subtext: ThemeManager.current === "dark" ? Dark.subtext : Light.subtext
    readonly property color border: ThemeManager.current === "dark" ? Dark.border  : Light.border
    readonly property color accent: ThemeManager.current === "dark" ? Dark.accent  : Light.accent
    readonly property color muted: ThemeManager.current === "dark" ? Dark.muted   : Light.muted

    readonly property int barWidth: 54
    readonly property int barBorder: 14
    readonly property int radius: 12
    readonly property int animFast: 150
    readonly property int animNormal: 250
    readonly property int drawerPadding: 16
    readonly property int sliderWidth: 28
    readonly property int sliderHeight: 120
}