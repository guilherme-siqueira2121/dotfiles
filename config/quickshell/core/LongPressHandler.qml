import QtQuick

Item {
    id: root

    property int duration: 800
    property real progress: 0
    property bool active: false

    signal activated

    function reset() {
        active = false
        progress = 0
        holdTimer.stop()
    }

    readonly property alias pressed: tap.pressed

    TapHandler {
        id: tap
        onPressedChanged: {
            if (pressed) {
                root.active = true
                holdTimer.start()
            } else {
                root.reset()
            }
        }
    }

    Timer {
        id: holdTimer
        interval: 16
        repeat: true
        onTriggered: {
            root.progress = Math.min(1, root.progress + 16 / root.duration)
            if (root.progress >= 1) {
                root.reset()
                root.activated()
            }
        }
    }
}