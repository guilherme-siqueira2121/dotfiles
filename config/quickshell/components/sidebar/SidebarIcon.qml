import QtQuick
import "../../services"

Item {
    id: root
    width: 28
    height: 28

    default property alias content: inner.children

    HoverHandler {
        id: hover
    }

    Item {
        id: inner
        anchors.centerIn: parent

        scale: hover.hovered ? 1.3 : 1.0

        Behavior on scale {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutBack
            }
        }
    }
}