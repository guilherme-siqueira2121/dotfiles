import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: 48
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        color: "#0d0f1a"
        radius: 12
    }
}