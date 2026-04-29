import QtQuick
import Quickshell
import Quickshell.Wayland
import "../services"

Item {
    component ExclusionZone: PanelWindow {
        color: "transparent"
        exclusiveZone: Theme.barBorder
        implicitWidth: 1
        implicitHeight: 1
    }

    ExclusionZone { anchors.top: true }
    ExclusionZone { anchors.bottom: true }
    ExclusionZone { anchors.right: true }
    ExclusionZone { 
        anchors.left: true
        exclusiveZone: Theme.barWidth
    }
}