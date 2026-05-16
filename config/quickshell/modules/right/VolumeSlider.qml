import QtQuick
import Quickshell.Io
import "../../services"

Item {
    implicitWidth: Theme.sliderWidth
    implicitHeight: Theme.sliderHeight

    property int level: 50

    Process {
        id: getVol
        command: ["bash", "-c", "pamixer --get-volume 2>/dev/null || echo 50"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: level = parseInt(text.trim())
        }
    }

    Process {
        id: setVol
        command: ["bash", "-c", "pamixer --set-volume " + String(level)]
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: getVol.running = true
    }

    Slider {
        anchors.fill: parent
        value: level / 100
        onMoved: {
            level = Math.round(value * 100)
            setVol.running = true
        }
    }
}