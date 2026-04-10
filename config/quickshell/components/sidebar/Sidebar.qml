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
            topMargin: 8
            bottomMargin: 8
            leftMargin: 6
        }

        color: Theme.bg
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        Workspaces {
            anchors.centerIn: parent
        }
    }
}