import QtQuick
import Quickshell
import Quickshell.Io

Text {
    property int level: 0
    property bool muted: false

    Process {
        id: procVol
        command: ["bash", "-c", "pamixer --get-volume 2>/dev/null || echo '0'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: level = parseInt(text.trim())
        }
    }

    Process {
        id: procMute
        command: ["bash", "-c", "pamixer --get-mute 2>/dev/null || echo 'false'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: muted = text.trim() === "true"
        }
    }

    Timer {
        interval: 2000
        running: true
        repeat: true
        onTriggered: { procVol.running = true; procMute.running = true }
    }

    text: muted ? "󰝟" : level < 30 ? "󰕿" : level < 70 ? "󰖀" : "󰕾"
    color: muted ? "#555570" : "#b8c5db"
    font.pixelSize: 16
    font.family: "JetBrains Mono Nerd Font"
}