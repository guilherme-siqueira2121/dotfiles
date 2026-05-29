import QtQuick
import Quickshell.Io
import "../../services"

BarIcon {
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

    FadeIcon {
        anchors.centerIn: parent
        icon: ssid === "" ? "󰤠" : "󰤢"
        color: ssid === "" ? Theme.muted : Theme.accent
    }
}