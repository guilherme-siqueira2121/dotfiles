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
}
