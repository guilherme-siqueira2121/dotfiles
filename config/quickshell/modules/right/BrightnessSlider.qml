import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "../../services"

Item {
    id: root

    implicitWidth: 28
    implicitHeight: 120

    property int level: 100

    Process {
        id: getLevel
        command: ["bash", "-c", "brightnessctl -m | awk -F, '{print $4}' | tr -d '%'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: level = parseInt(text.trim())
        }
    }

    Process {
        id: setLevel
        command: ["bash", "-c", "brightnessctl set " + level + "%"]
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: getLevel.running = true
    }

    Slider {
        anchors.fill: parent
        orientation: Qt.Vertical
        from: 0.01
        to: 1.0
        value: level / 100
        onMoved: {
            level = Math.round(value * 100)
            setLevel.running = true
        }
    }
}