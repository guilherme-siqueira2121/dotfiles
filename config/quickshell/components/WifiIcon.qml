import QtQuick
import Quickshell
import Quickshell.Io

Text {
    property string ssid: ""

    Process {
        id: proc
        command: ["bash", "-c", "iwgetid -r 2>/dev/null || echo ''"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: ssid = text.trim()
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }

    text: ssid === "" ? "󰤠" : "󰤢"
    color: ssid === "" ? "#d88888" : "#8fb3d9"
    font.pixelSize: 16
    font.family: "JetBrains Mono Nerd Font"
}