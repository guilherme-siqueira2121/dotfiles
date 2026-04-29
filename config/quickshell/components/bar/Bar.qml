import QtQuick
import Quickshell
import "../../services"

Rectangle {
    anchors {
        top:    parent.top
        bottom: parent.bottom
        left:   parent.left
    }

    width: Theme.barWidth
    color: Theme.bg

    Column {
        anchors {
            top:              parent.top
            topMargin:        12
            horizontalCenter: parent.horizontalCenter
        }

        Workspaces {}
    }

    Column {
        anchors {
            bottom:           parent.bottom
            bottomMargin:     12
            horizontalCenter: parent.horizontalCenter
        }

        spacing: 16

        WifiIcon {}
        VolumeIcon {}
        BatteryIcon {}
    }
}