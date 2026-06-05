import QtQuick
import Quickshell.Io
import "../../components"
import "../../services"

Item {
    id: root

    implicitWidth: Theme.sliderWidth
    implicitHeight: Theme.sliderHeight

    property bool muted: Audio.muted

    Timer {
        id: debounce
        interval: 80
        repeat: false
        onTriggered: Audio.setVolume(Math.round(slider.value))
    }

    Slider {
        id: slider
        anchors.fill: parent
        from: 0
        to: 100
        value: Audio.volume

        onPressedChanged: {
            if (!pressed) Audio.setVolume(Math.round(value))
        }

        onMoved: debounce.restart()
    }
}