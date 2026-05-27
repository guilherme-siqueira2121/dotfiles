pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string configPath: Quickshell.configDir + "/theme"

    property string current: "light"

    Component.onCompleted: readProc.running = true

    Process {
        id: readProc
        command: ["bash", "-c", "cat " + root.configPath + " 2>/dev/null || echo light"]
        running: false
        stdout: StdioCollector {
            onStreamFinished: root.current = text.trim()
        }
    }

    Process {
        id: writeProc
        property string value: ""
        command: ["bash", "-c", "echo " + value + " > " + root.configPath]
        running: false
    }

    function toggle() {
        current = current === "light" ? "dark" : "light"
        writeProc.value = current
        writeProc.running = true
    }

    function set(theme) {
        current = theme
        writeProc.value = current
        writeProc.running = true
    }
}