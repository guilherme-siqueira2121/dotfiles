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

    R {
        panel: panels.clock
        bar: root.bar
        win: root.win
        y: 0
        height: panel.implicitHeight * (1 - panel.offsetScale) + Theme.barBorder
    }

    R {
        panel: panels.osd
        bar: root.bar
        win: root.win
        x: win.width - width
        y: panel.y + Theme.barBorder
        width: panel.implicitWidth * (1 - panel.offsetScale) + Theme.barBorder
        height: panel.implicitHeight
    }

    R {
        panel: panels.session
        bar: root.bar
        win: root.win
        x: win.width - width
        y: panel.y + Theme.barBorder
        width: panel.implicitWidth * (1 - panel.offsetScale) + Theme.barBorder
        height: panel.implicitHeight
    }

    R {
        panel: panels.launcher
        bar: root.bar
        win: root.win
        y: win.height - Theme.barBorder - height
        height: panel.implicitHeight * (1 - panel.offsetScale) + Theme.barBorder
    }

    component R: Region {
        required property Item panel
        required property Item bar
        required property var  win

        x: panel.x + bar.implicitWidth
        y: panel.y + Theme.barBorder
        width: panel.implicitWidth
        height: panel.implicitHeight
        intersection: Intersection.Subtract
    }
}