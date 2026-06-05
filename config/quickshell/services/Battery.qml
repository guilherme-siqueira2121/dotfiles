pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int level: 100
    property bool charging: false

    Process {
        id: capacityProc
        command: ["bash", "-c", "cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 100"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.level = parseInt(text.trim())
        }
    }

    Process {
        id: statusProc
        command: ["bash", "-c", "cat /sys/class/power_supply/BAT0/status 2>/dev/null || echo ''"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.charging = text.trim() === "Charging"
        }
    }

    Timer {
        interval: 30000
        running: true
        repeat: true
        onTriggered: {
            capacityProc.running = true
            statusProc.running = true
        }
    }
}