import QtQuick
import "../services"

Item {
    id: root

    property bool open: false
    property real offsetScale: open ? 0 : 1
    property string direction: "right"

    default property alias content: inner.data

    visible: offsetScale < 1

    Behavior on offsetScale {
        NumberAnimation {
            duration: Theme.animNormal
            easing.type: Easing.OutCubic
        }
    }

    anchors.rightMargin: direction === "right" ? -implicitWidth  * offsetScale : 0
    anchors.leftMargin: direction === "left" ? -implicitWidth  * offsetScale : 0
    anchors.topMargin: direction === "top" ? -implicitHeight * offsetScale : 0
    anchors.bottomMargin: direction === "bottom" ? -implicitHeight * offsetScale : 0

    Item {
        id: inner
        anchors.fill: parent
    }
}