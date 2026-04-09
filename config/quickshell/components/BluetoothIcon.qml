import QtQuick
import Quickshell
import Quickshell.Io

Text {
    property string status: "off"

    Process {
        id: proc
        command: ["bash", "-c",
            "bluetoothctl show | grep -q 'Powered: yes' && " +
            "{ bluetoothctl info 2>/dev/null | grep -q 'Connected: yes' && echo connected || echo on; } " +
            "|| echo off"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: status = text.trim()
        }
    }

    Timer {
        interval: 4000
        running: true
        repeat: true
        onTriggered: proc.running = true
    }

    text: status === "connected" ? "󰂱" : status === "on" ? "󰂯" : "󰂲"
    color: status === "connected" ? "#8fb3d9" : status === "on" ? "#a0a8d0" : "#8888aa"
    font.pixelSize: 16
    font.family: "JetBrains Mono Nerd Font"
}