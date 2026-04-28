import QtQuick
import Quickshell
import Quickshell.Io
import "../../services"

Item {
    width: 28
    height: 28

    property int level: 0
    property bool muted: false

    VolumePopup {
        id: popup
        visible: true
        open: false
    }

    Process {
        id: volProc
        command: ["bash", "-c", "pamixer --get-volume 2>/dev/null || echo 0"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: level = parseInt(text.trim())
        }
    }

    Process {
        id: muteProc
        command: ["bash", "-c", "pamixer --get-mute 2>/dev/null || echo false"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: { muted = text.trim() === "true" }
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

    Rectangle {
        anchors.centerIn: parent
        width: 28
        height: 28
        radius: 6
        color: hover.hovered ? "#2727277c" : "transparent"

        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }

        HoverHandler { id: hover }
        
        Text {
        anchors.centerIn: parent
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 18
        color: muted ? Theme.muted : Theme.accent
        text: muted ? "󰝟" : level < 30 ? "󰕿" : level < 70 ? "󰖀" : "󰕾"
        }
    }


    TapHandler {
        onTapped: popup.open = !popup.open
    }
}