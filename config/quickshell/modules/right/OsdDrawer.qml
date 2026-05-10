import QtQuick
import QtQuick.Controls
import Quickshell.Io
import "../../services"

Item {
    id: root

    property bool open: false
    property real offsetScale: open ? 0 : 1
    property int volume: 50

    implicitWidth: 56
    implicitHeight: 160

    visible: offsetScale < 1

    Behavior on offsetScale {
        NumberAnimation {
            duration: Theme.animNormal
            easing.type: Easing.OutCubic
        }
    }

    anchors.rightMargin: -implicitWidth * offsetScale

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
    }

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
                    volume = Math.round(value * 100)
                    setVol.running = true
                }
            }
        }
    }
}