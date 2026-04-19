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
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    HoverHandler {
        id: hover
    }

    Rectangle {
        anchors.centerIn: parent
        width: clockItem.implicitWidth + 32
        height: 30
        color: Theme.bg
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        opacity: hover.hovered ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation { duration: Theme.animNormal }
        }

        Clock {
            id: clockItem
            anchors.centerIn: parent
        }
    }
}