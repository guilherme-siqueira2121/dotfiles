import QtQuick
import "top"
import "../services"

Item {
    id: root

    required property DrawerVisibilities visibilities
    required property Item bar

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
}