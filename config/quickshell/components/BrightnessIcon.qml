import QtQuick
import Quickshell
import Quickshell.Io

Text {
    property int level: 100

    Process {
        id: proc
        command: ["bash", "-c",
            "brightnessctl -m | awk -F, '{print $4}' | tr -d '%'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: level = parseInt(text.trim())
        }
    }

    Timer {
        interval: 3000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }

    text: level < 30 ? "󱩎" : level < 60 ? "󱩑" : "󱩔"
    color: "#b8c5db"
    font.pixelSize: 16
    font.family: "JetBrains Mono Nerd Font"
}