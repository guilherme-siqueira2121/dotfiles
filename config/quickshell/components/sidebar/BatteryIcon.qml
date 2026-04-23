import QtQuick
import Quickshell
import Quickshell.Io
import "../../services"

Item {
    width: 28
    height: 28

    property int level: 100
    property bool charging: false

    Process {
        id: proc
        command: ["bash", "-c", "cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 100"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: level = parseInt(text.trim())
        }
    }

    Process {
        id: statusProc
        command: ["bash", "-c", "cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo ''"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: charging = text.trim() === "Charging"
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: {
            proc.running = true
            statusProc.running = true
        }
    }

    Text {
        anchors.centerIn: parent
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 18
        color: level <= 20 ? "#d88888" : Theme.accent
        text: charging ? "󰂄" : level > 80 ? "󰁹" : level > 50 ? "󰂀" : level > 20 ? "󰁽" : "󰁺"
    }
}