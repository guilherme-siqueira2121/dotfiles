import QtQuick
import Quickshell

Text {
    property string format: "hh:mm  ddd, dd MMM"

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, format)
    color: "#8fb3d9"
    font.family: "JetBrains Mono Nerd Font"
    font.pixelSize: 13
    font.weight: Font.Medium
}