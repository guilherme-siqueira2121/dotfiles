pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property color bg:      "#0d0f1a"
    readonly property color surface: "#13162b"
    readonly property color border:  "#ffffff10"
    readonly property color text:    "#cdd6f4"
    readonly property color muted:   "#4a5068"
    readonly property color accent:  "#8fb3d9"

    readonly property int sidebarWidth: 44
    readonly property int radius:       12
    readonly property int spacing:      8
    readonly property int animFast:     150
    readonly property int animNormal:   250
}