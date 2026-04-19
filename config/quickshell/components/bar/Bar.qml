import QtQuick
import Quickshell
import Quickshell.Wayland
import "../../services"

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 36
    color: "transparent"

    HoverHandler {
        id: hover
    }

    Rectangle {
        anchors.fill: parent
        color: Theme.bg
        border.color: Theme.border
        border.width: 1

        opacity: hover.hovered ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animNormal
            }
        }

        Clock {
            anchors.centerIn: parent
        }
    }
}