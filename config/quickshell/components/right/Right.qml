import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../services"

PanelWindow {
    anchors {
        right: true
        top: true
        bottom: true
    }

    implicitWidth: 2
    exclusionMode: ExclusionMode.Ignore
    color: Theme.border
}