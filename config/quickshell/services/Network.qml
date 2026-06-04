pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string state: "disconnected"

    Process {
        id: proc
        command: ["bash", "-c", "nmcli -t -f STATE general 2>/dev/null || echo 'disconnected'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.state = text.trim()
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }
}