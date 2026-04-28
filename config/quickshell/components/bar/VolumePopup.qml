import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../../services"

PanelWindow {
    id: popup

    property int volume: 50
    property bool open: false

    anchors.right: true
    implicitWidth: 56
    implicitHeight: 160
    margins.right: 4
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.exclusionMode: ExclusionMode.Ignore

    Rectangle {
        id: panel
        width: parent.width
        height: parent.height
        color: Theme.bg
        radius: Theme.radius

        x: open ? 0 : width + 10

        Behavior on x {
            NumberAnimation {
                duration: Theme.animNormal
                easing.type: Easing.OutCubic
            }
        }

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