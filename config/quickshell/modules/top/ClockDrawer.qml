import QtQuick
import "../../services"

Item {
    id: root

    property bool open: false
    property real offsetScale: open ? 0 : 1

    anchors.top: parent.top
    anchors.horizontalCenter: parent.horizontalCenter

    implicitWidth: bg.implicitWidth
    implicitHeight: bg.implicitHeight

    visible: offsetScale < 1

    Behavior on offsetScale {
        NumberAnimation {
            duration: Theme.animNormal
            easing.type: Easing.OutCubic
        }
    }

    anchors.topMargin: -(implicitHeight) * offsetScale

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