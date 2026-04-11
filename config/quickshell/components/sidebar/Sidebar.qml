import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../services"

PanelWindow {
    anchors {
        left: true
        top: true
        bottom: true
    }

    implicitWidth: Theme.sidebarWidth
    color: "transparent"

    Rectangle {
        anchors {
            fill: parent
        }

        color: Theme.bg
        radius: 0
        border.color: Theme.border
        border.width: 1

        Workspaces {
            anchors.centerIn: parent
        }
    }
}