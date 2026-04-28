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

    implicitWidth: Theme.barWidth
    color: "transparent"

    Rectangle {
        anchors {
            fill: parent
        }

        color: Theme.bg
        radius: 0

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

            spacing: 16
            
            WifiIcon {}
            VolumeIcon {}
            BatteryIcon {}
        }
    }
}