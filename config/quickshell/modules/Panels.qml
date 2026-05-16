import QtQuick
import "top"
import "right"
import "bottom"
import "../services"

Item {
    id: root

    required property DrawerVisibilities visibilities
    required property Item bar

    readonly property alias clock: clockDrawer
    readonly property alias osd: osdDrawer
    readonly property alias session: sessionDrawer

    anchors.fill: parent
    anchors.leftMargin: bar.implicitWidth
    anchors.topMargin: Theme.barBorder
    anchors.rightMargin: Theme.barBorder
    anchors.bottomMargin: Theme.barBorder

    ClockDrawer {
        id: clockDrawer
        open: root.visibilities.clock
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
    }

    OsdDrawer {
        id: osdDrawer
        open: root.visibilities.osd
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }

    SessionDrawer {
        id: sessionDrawer
        open: root.visibilities.session
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }
}