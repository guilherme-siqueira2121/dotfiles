import QtQuick
import Quickshell

Item {
    id: root

    property string format: "hh:mm:ss - yyyy-MM-dd"

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        anchors.centerIn: parent
        color: "#cdd6f4"
        font.pixelSize: 14

        text: Qt.formatDateTime(clock.date, root.format)
    }
}