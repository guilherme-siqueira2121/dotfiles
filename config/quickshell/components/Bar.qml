import QtQuick
import Quickshell
import Quickshell.Wayland

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 36
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        anchors.margins: 4
        color: "#dbdeef"
        radius: 18

        Workspaces {
            anchors.left: parent.left
            anchors.leftMargin: 12
            anchors.verticalCenter: parent.verticalCenter
        }

        ClockText {
            anchors.centerIn: parent
        }
    }
}