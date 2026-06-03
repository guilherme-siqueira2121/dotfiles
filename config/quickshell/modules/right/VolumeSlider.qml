import QtQuick
import Quickshell.Io
import "../../services"

SystemSlider {
    id: root

    level: 50
    getCommand: ["bash", "-c", "pamixer --get-volume 2>/dev/null || echo 50"]
    setCommand: ["bash", "-c", "pamixer --set-volume " + String(level)]
    pollInterval: 2000

    property bool muted: false

    Process {
        id: muteProc
        command: ["bash", "-c", "pamixer --get-mute 2>/dev/null || echo false"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.muted = text.trim() === "true"
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: muteProc.running = true
    }
}