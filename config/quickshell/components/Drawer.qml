import QtQuick
import "."
import "../services"

Item {
    id: root

    property bool open: false
    property string direction: "right"

    property real offsetScale: open ? 0 : 1

    visible: offsetScale < 1

    Behavior on offsetScale {
        NumberAnimation {
            duration: Theme.animNormal
            easing.type: Easing.OutCubic
        }
    }

    anchors.rightMargin: direction === "right" ? (-width  - Theme.barBorder) * offsetScale : 0
    anchors.leftMargin: direction === "left" ? (-width  - Theme.barBorder) * offsetScale : 0
    anchors.topMargin: direction === "top" ? (-height - Theme.barBorder) * offsetScale : 0
    anchors.bottomMargin: direction === "bottom" ? (-height - Theme.barBorder) * offsetScale : 0

    opacity: 1 - offsetScale
}