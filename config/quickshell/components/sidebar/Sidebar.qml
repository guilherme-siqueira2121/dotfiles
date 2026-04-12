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

        Column {
            anchors {
                top: parent
                topMargin: 12
                horizontalCenter: parent.horizontalCenter
            }

            Workspaces {}
        }

        Column {
            anchors {
                bottom: parent.bottom
                bottomMargin: 12
                horizontalCenter: parent.horizontalCenter
            }
            
            VolumeIcon {}

            spacing: 8
        }
    }
}