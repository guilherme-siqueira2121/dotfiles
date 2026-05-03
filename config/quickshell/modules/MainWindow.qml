import QtQuick
import Quickshell
import Quickshell.Wayland
import "bar"
import "../services"

PanelWindow {
    id: root

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    color: "transparent"
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    mask: Region {
        item: bar
    }

    Bar {
        id: bar
    }
}