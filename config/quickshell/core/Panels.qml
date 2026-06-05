import QtQuick
import "../features/clock"
import "../features/osd"
import "../features/session"
import "../features/launcher"
import "../services"

Item {
    id: root

    required property Item bar

    readonly property alias clock: clockDrawer
    readonly property alias osd: osdDrawer
    readonly property alias session: sessionDrawer
    readonly property alias launcher: launcherDrawer

    anchors.fill: parent

    ClockDrawer {
        id: clockDrawer
        open: DrawerVisibilities.clock
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.leftMargin: bar.implicitWidth / 2
    }

    OsdDrawer {
        id: osdDrawer
        open: DrawerVisibilities.osd
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
    }

    SessionDrawer {
        id: sessionDrawer
        open: DrawerVisibilities.session
        anchors.right: parent.right
        anchors.bottom: parent.bottom
    }

    LauncherDrawer {
        id: launcherDrawer
        open: DrawerVisibilities.launcher
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.leftMargin: bar.implicitWidth / 2
        onLaunched: DrawerVisibilities.launcher = false
    }
}