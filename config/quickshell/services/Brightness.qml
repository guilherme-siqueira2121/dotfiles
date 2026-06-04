pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int level: -1

    Process {
        id: getProc
        command: ["bash", "-c", "brightnessctl -m | awk -F, '{print $4}' | tr -d '%'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.level = parseInt(text.trim())
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: getProc.running = true
    }

    function setLevel(value) {
        root.level = value
        setProc.running = true
    }

    Process {
        id: setProc
        command: ["bash", "-c", "brightnessctl set " + String(root.level) + "%"]
        running: false
    }
}