import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../services"

PanelWindow {
    anchors {
        bottom: true
        left: true
        right: true
    }

    implicitHeight: Theme.barBorder
    color: Theme.bg
}