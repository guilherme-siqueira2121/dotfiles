import QtQuick
import Quickshell
import "../../services"

Text {
    color: Theme.text
    font.pixelSize: 13
    font.family: "JetBrains Mono Nerd Font"

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(clock.date, "hh:mm  ddd, dd  MM")
}