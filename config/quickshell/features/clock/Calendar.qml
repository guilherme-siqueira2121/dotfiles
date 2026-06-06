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
    readonly property var weekdays: ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]

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
            model: weekdays
            Text {
                width: 24; height: 20
                horizontalAlignment: Text.AlignHCenter
                text: modelData
                color: (index === 0 || index === 6) ? Theme.accent : Theme.muted
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 9
                font.weight: (index === 0 || index === 6) ? Font.Medium : Font.Normal
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

                readonly property int weekday: (firstWeekday + index) % 7
                readonly property bool isWeekend: weekday === 0 || weekday === 6
                readonly property bool isToday: (index + 1) === currentDay

                Text {
                    anchors.centerIn: parent
                    text: index + 1
                    color: isToday ? Theme.bg
                        : isWeekend ? Theme.accent
                        : Theme.text
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 10
                    font.weight: isToday ? Font.Bold : Font.Normal
                }
            }
        }
    }
}