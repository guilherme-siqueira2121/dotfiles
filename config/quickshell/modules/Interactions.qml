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

    function inTopPanel(panel, x, y) {
        const panelHeight = panel.implicitHeight * (1 - panel.offsetScale)
        const panelX = bar.implicitWidth + panel.x
        const withinWidth = x >= panelX && x <= panelX + panel.implicitWidth
        return y < Math.max(Theme.barBorder, Theme.barBorder + panelHeight) && withinWidth
    }

    function inRightPanel(panel, x, y) {
        const panelWidth = panel.implicitWidth * (1 - panel.offsetScale)
        const panelY = Theme.barBorder + panel.y
        const withinHeight = y >= panelY && y <= panelY + panel.implicitHeight
        return x > (parent.width - Math.max(Theme.barBorder, Theme.barBorder + panelWidth)) && withinHeight
    }

    onPositionChanged: event => {
        const x = event.x
        const y = event.y

        visibilities.clock = inTopPanel(panels.clock, x, y)
        visibilities.osd = inRightPanel(panels.osd, x, y)
    }

    onExited: {
        visibilities.clock = false
        visibilities.osd = false
    }
}