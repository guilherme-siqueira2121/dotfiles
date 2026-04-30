import QtQuick
import Quickshell
import ".."
import "../../services"

Drawer {
    direction: "top"
    height: 34
    width:  clockText.implicitWidth + 32

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        anchors.fill: parent
        color: Theme.bg
        radius: Theme.radius

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