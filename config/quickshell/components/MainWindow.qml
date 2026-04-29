import QtQuick
import Quickshell
import Quickshell.Wayland
import "bar"1
import "../services"

PanelWindow {
    id: root

    anchors.top: true
    anchors.bottom: true
    anchors.left:true
    anchors.right: true

    color: "transparent"
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    Bar {
        id: bar
    }

    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: Theme.barBorder
        color: Theme.bg
    }
}