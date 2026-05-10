import QtQuick
import QtQuick.Controls
import QtQuick.Io
import "../../services"

Item {
    implicitWidth: 28
    implicitHeight: 120

    property int level: 50

    Process {
        id: getVol
        comman: ["bash", "-c", "pamixer --get-volume 2>/dev/null || echo 50"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: level = parseInt(text.trim())
        }
    }

    Process {
        id: setVol
        command: ["bash", "-c", "pamixer --set-volume " + level]
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: getVol.running: true
    }

    Slider {
        anchors.fill: parent
        orientation: Qt.Vertical
        value: level / 100
        onMoved {
            level = Math.round(value * 100)
            setVol.running = true
        }
    }
}