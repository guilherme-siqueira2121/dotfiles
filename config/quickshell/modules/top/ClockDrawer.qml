import QtQuick
import ".."
import "../../services"

Drawer {
    direction: "top"

    implicitWidth: bg.implicitWidth
    implicitHeight: bg.implicitHeight

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: bg
        implicitWidth: clockText.implicitWidth + 32
        implicitHeight: 34
        color: Theme.bg
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        Clock {
            id: clockText
            anchors.centerIn: parent
        }
    }
}