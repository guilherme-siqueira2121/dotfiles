import QtQuick
import "../services"

Item {
    id: root

    property bool open: false
    property real offsetScale: open ? 0 : 1
    property string direction: "right"

    default property alias content: container.children

    implicitWidth: bg.implicitWidth
    implicitHeight: bg.implicitHeight

    visible: offsetScale < 1

    Behavior on offsetScale {
        NumberAnimation {
            duration: Theme.animNormal
            easing.type: Easing.OutCubic
        }
    }

    anchors.topMargin: direction === "top" ? -implicitHeight * offsetScale : 0
    anchors.rightMargin: direction === "right" ? -implicitWidth  * offsetScale : 0
    anchors.bottomMargin: direction === "bottom" ? -implicitHeight * offsetScale : 0
    anchors.leftMargin: direction === "left" ? -implicitWidth  * offsetScale : 0

    Rectangle {
        id: bg
        implicitWidth:  container.implicitWidth + Theme.drawerPadding * 2
        implicitHeight: container.implicitHeight + Theme.drawerPadding * 2
        color: Theme.bg
        radius: Theme.radius

        Item {
            id: container
            anchors.centerIn: parent
            implicitWidth: childrenRect.width
            implicitHeight: childrenRect.height
        }
    }
}