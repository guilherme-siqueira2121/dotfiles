import QtQuick
import "../services"

MouseArea {
    id: root

    required property Item bar
    required property Item panels

    anchors.fill: parent
    anchors.topMargin: -Theme.barBorder
    hoverEnabled: true
    acceptedButtons: Qt.NoButton

    function inTopPanel(panel, x, y) {
        const panelHeight = panel.implicitHeight * (1 - panel.offsetScale)
        const panelX = bar.implicitWidth + panel.x
        const withinWidth = x >= panelX && x <= panelX + panel.implicitWidth
        return y <= Theme.barBorder + panelHeight && withinWidth
    }

    function inRightPanel(panel, x, y) {
        const panelWidth = panel.implicitWidth * (1 - panel.offsetScale)
        const panelY = Theme.barBorder + panel.y
        const withinHeight = y >= panelY && y <= panelY + panel.implicitHeight
        return x > (parent.width - Math.max(Theme.barBorder, Theme.barBorder + panelWidth)) && withinHeight
    }

    function inBottomRightPanel(panel, x, y) {
        const panelWidth = panel.implicitWidth * (1 - panel.offsetScale)
        const panelY = parent.height - Theme.barBorder - panel.implicitHeight
        const withinHeight = y >= panelY && y <= parent.height
        return x > (parent.width - Math.max(Theme.barBorder, Theme.barBorder + panelWidth)) && withinHeight
    }

    function inBottomPanel(panel, x, y) {
        const panelHeight = panel.implicitHeight * (1 - panel.offsetScale)
        const panelX = bar.implicitWidth + panel.x
        const withinWidth = x >= panelX && x <= panelX + panel.implicitWidth
        return y >= (parent.height - Math.max(Theme.barBorder, Theme.barBorder + panelHeight)) && withinWidth
    }

    onPositionChanged: event => {
        const x = event.x
        const y = event.yz
        DrawerVisibilities.clock = inTopPanel(panels.clock, x, y)
        DrawerVisibilities.osd = inRightPanel(panels.osd, x, y)
        DrawerVisibilities.session = inBottomRightPanel(panels.session, x, y)
        DrawerVisibilities.launcher = inBottomPanel(panels.launcher, x, y)
    }

    onExited: {
        DrawerVisibilities.clock = false
        DrawerVisibilities.osd = false
        DrawerVisibilities.session = false
        DrawerVisibilities.launcher = false
    }
}