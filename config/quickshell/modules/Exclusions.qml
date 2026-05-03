import QtQuick
import Quickshell
import Quickshell.Wayland
import "../services"

Item {
    component Border: PanelWindow {
        color: Theme.bg
        exclusiveZone: Theme.barBorder
        implicitWidth: 1
        implicitHeight: 1
    }

    Border { anchors.top: true }
    Border { anchors.bottom: true }
    Border { anchors.right: true }
    Border {
        anchors.left: true
        exclusiveZone: Theme.barWidth
    }
}