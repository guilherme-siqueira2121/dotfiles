import QtQuick
import Quickshell.Io

Item {
    id: root
    property alias icon: iconText
    property string command: ""

    width: 40
    height: 40

    Process {
        id: proc
        command: ["bash", "-c", root.command]
        running: false
    }

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: hover.containsMouse ? "#161830" : "transparent"
        Behavior on color { ColorAnimation { duration: 120 } }
    }

    Text {
        id: iconText
        anchors.centerIn: parent
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
    }

    HoverHandler { id: hover }

    TapHandler {
        onTapped: {
            if (command !== "")
                proc.running = true
        }
    }
}