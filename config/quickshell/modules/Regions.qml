import QtQuick
import Quickshell
import "../services"

Region {
    id: root

    required property Item bar
    required property Item panels
    required property var win

    x: bar.implicitWidth
    y: Theme.barBorder
    width: win.width - bar.implicitWidth - Theme.barBorder
    height: win.height - Theme.barBorder * 2
    intersection: Intersection.Xor

    Region {
        x: panels.clock.x + bar.implicitWidth
        y: 0
        width: panels.clock.implicitWidth
        height: panels.clock.implicitHeight * (1 - panels.clock.offsetScale) + Theme.barBorder
        intersection: Intersection.Subtract
    }
}