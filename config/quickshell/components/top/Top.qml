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

    implicitHeight: Theme.barBorder
    color: Theme.bg

    HoverHandler {
        id: hover
    }

    Rectangle {
        anchors.centerIn: parent
        width: clockText.implicitWidth + 32
        height: 30
        radius: Theme.radius
        color: Theme.bg
        border.color: Theme.border
        border.width: 1

        opacity: hover.hovered ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation { duration : Theme.animNormal }
        }

        Text {
            id: clockText
            anchors.centerIn: parent
            color: Theme.text
            font.pixelSize: 13
            font.family: "JetBrains Mono Nerd Font"

            SystemClock {
                id: clock
                precision: SystemClock.Minutes
            }

            text: Qt.formatDateTime(clock.date, "hh:mm  ddd, dd MMM")
        }
    }
}