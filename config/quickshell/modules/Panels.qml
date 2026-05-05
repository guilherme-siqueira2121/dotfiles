import QtQuick
import "top"
import "right"
import "../services"

Item {
    id: root

    required property DrawerVisibilities visibilities
    required property Item bar

    readonly property alias clock: clockDrawer
    readonly property alias volume: volumeDrawer

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

    VolumeDrawer {
        id: volumeDrawer
        open: root.visibilities.volume
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
    }
}