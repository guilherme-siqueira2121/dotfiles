import QtQuick
import Quickshell
import Quickshell.Wayland
import "../features/bar"
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

    WlrLayershell.keyboardFocus: DrawerVisibilities.launcher
        ? WlrKeyboardFocus.OnDemand
        : WlrKeyboardFocus.None

    mask: regions

    Regions {
        id: regions
        bar: bar
        panels: panels
        win: root
    }

    Bar { id: bar }

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Theme.barBorder
        color: Theme.bg
    }

    Rectangle {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: Theme.barBorder
        color: Theme.bg
    }

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: Theme.barBorder
        color: Theme.bg
    }

    Panels {
        id: panels
        bar: bar
    }

    Interactions {
        bar: bar
        panels: panels
    }
}