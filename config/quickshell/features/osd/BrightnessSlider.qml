import QtQuick
import "../../components"
import "../../services"

Item {
    id: root

    implicitWidth: Theme.sliderWidth
    implicitHeight: Theme.sliderHeight

    Timer {
        id: debounce
        interval: 80
        repeat: false
        onTriggered: Brightness.setLevel(Math.round(slider.value))
    }

    Slider {
        id: slider
        anchors.fill: parent
        from: 1
        to: 100
        value: Brightness.level < 0 ? 1 : Brightness.level

        onPressedChanged: {
            if (!pressed) Brightness.setLevel(Math.round(value))
        }

        onMoved: debounce.restart()
    }
}