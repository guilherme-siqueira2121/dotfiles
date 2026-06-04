pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property int volume: 0
    property bool muted: false

    Process {
        id: volProc
        command: ["bash", "-c", "pamixer --get-volume 2>/dev/null || echo 0"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.volume = parseInt(text.trim())
        }
    }

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
        onTriggered: {
            volProc.running = true
            muteProc.running = true
        }
    }

    function setVolume(level) {
        root.volume = level
        setProc.running = true
    }

    Process {
        id: setProc
        command: ["bash", "-c", "pamixer --set-volume " + String(root.volume)]
        running: false
    }
}