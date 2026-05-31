import QtQuick
import Quickshell
import "../../services"

Item {
    implicitWidth: grid.implicitWidth
    implicitHeight: header.implicitHeight + 8 + grid.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }

    readonly property var months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    readonly property var today: new Date(clock.date)
    readonly property int currentDay: today.getDate()
    readonly property int currentMonth: today.getMonth()
    readonly property int currentYear: today.getFullYear()

    readonly property int firstWeekday: new Date(currentYear, currentMonth, 1).getDay()
    readonly property int daysInMonth: new Date(currentYear, currentMonth + 1, 0).getDate()

    Text {
        id: header
        anchors.horizontalCenter: parent.horizontalCenter
        text: months[currentMonth] + "  " + currentYear
        color: Theme.text
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 11
        font.weight: Font.Medium
    }

    Grid {
        id: grid
        anchors.top: header.bottom
        anchors.topMargin: 8
        columns: 7
        rowSpacing: 2
        columnSpacing: 2

        Repeater {
            model: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
            Text {
                width: 24; height: 20
                horizontalAlignment: Text.AlignHCenter
                text: modelData
                color: Theme.muted
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 9
            }
        }

        Repeater {
            model: firstWeekday
            Item { width: 24; height: 24 }
        }

        Repeater {
            model: daysInMonth
            delegate: Rectangle {
                width: 24; height: 24
                radius: 12
                color: (index + 1) === currentDay ? Theme.accent : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: index + 1
                    color: (index + 1) === currentDay ? Theme.bg : Theme.text
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 10
                    font.weight: (index + 1) === currentDay ? Font.Bold : Font.Normal
                }
            }
        }
    }
}