import QtQuick
import "../services"

MouseArea {
    id: root

    required property DrawerVisibilities visibilities
    required property Item bar

    anchors.fill: parent
    hoverEnabled: true
    acceptedButtons: Qt.NoButton

    onPositionChanged: event => {
        const x = event.x
        const y = event.y

        visibilities.clock = y < Theme.barBorder && x > bar.implicitWidth
    }

    onExited: {
        visibilities.clock = false
    }
}