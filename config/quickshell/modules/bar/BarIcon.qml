import QtQuick
import "../../services"

Item {
    id: root
    width: 28
    height: 28

    default property alias content: inner.data

    HoverHandler {
        id: hover
    }

    Item {
        id: inner
        width: root.width
        height: root.height
        anchors.centerIn: parent

        scale: hover.hovered ? 1.35 : 1.0

        Behavior on scale {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutBack
            }
        }
    }
}