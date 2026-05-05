import QtQuick
import "../services"

MouseArea {
    id: root

    required property DrawerVisibilities visibilities
    required property Item bar
    required property Item panels

    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.NoButton

    onPositionChanged: event => {
        const x = event.x
        const y = event.y

        visibilities.clock = y < Theme.barBorder && x > bar.implicitWidth
        visibilities.volume = x > (parent.width - Theme.barBorder)
    }

    onExited: {
        visibilities.clock = false
        visibilities.volume = false
    }
}