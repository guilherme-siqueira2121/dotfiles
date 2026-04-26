import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../../services"

PanelWindow {
    id: popup

    property int volume: 50

    anchors.right: true
    implicitWidth: 56
    implicitHeight: 160
    margins.right: 10
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    Rectangle {
        anchors.fill: parent
        color: Theme.bg
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        Column {
            anchors.centerIn: parent
            spacing: 8

            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: volume + "%"
                color: Theme.text
                font.pixelSize: 11
                font.family: "JetBrains Mono Nerd Font"
            }

            Slider {
                id: slider
                width: 28
                height: 120
                orientation: Qt.Vertical
                value: volume / 100
                onMoved: {
                    volume = Math.round(slider.value * 100)
                    setVol.running = true
                }
            }
        }
    }

    Process {
        id: getVol
        command: ["bash", "-c", "pamixer --get-volume 2>/dev/null || echo 50"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: volume = parseInt(text.trim())
        }
    }

    Process {
        id: setVol
        command: ["bash", "-c", "pamixer --set-volume " + volume]
        running: false
    }
}