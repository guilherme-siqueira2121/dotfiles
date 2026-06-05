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

    readonly property var days: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    readonly property var months: ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    readonly property var date: new Date(clock.date)

    text: Qt.formatDateTime(clock.date, "hh:mm") +
          "  " + days[date.getDay()] +
          ", " + Qt.formatDateTime(clock.date, "dd") +
          " " + months[date.getMonth()]
}