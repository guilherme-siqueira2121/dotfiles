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

    ClockDrawer {
        id: clockDrawer
        open: root.visibilities.clock
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.leftMargin: bar.implicitWidth / 2
    }

    OsdDrawer {
        id: osdDrawer
        open: root.visibilities.osd
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    SessionDrawer {
        id: sessionDrawer
        open: root.visibilities.session
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }
}