import QtQuick
import Quickshell.Io
import "../../services"

Item {
    id: root

    implicitWidth: Theme.sliderWidth
    implicitHeight: Theme.sliderHeight

    property int level: 0
    property real sliderFrom: 0

    property var getCommand: []
    property var setCommand: []
    property int pollInterval: 2000

    Process {
        id: getProc
        command: root.getCommand
        running: root.getCommand.length > 0
        stdout: StdioCollector {
            onStreamFinished: root.level = parseInt(text.trim())
        }
    }

    Process {
        id: setProc
        command: root.setCommand
        running: false
    }

    Timer {
        interval: root.pollInterval
        running: true
        repeat: true
        onTriggered: getProc.running = true
    }

    Timer {
        id: debounce
        interval: 80
        repeat: false
        onTriggered: setProc.running = true
    }

    Slider {
        anchors.fill: parent
        from: root.sliderFrom
        to: 100
        value: root.level
        onMoved: {
            root.level = Math.round(value)
            debounce.restart()
        }
    }
}