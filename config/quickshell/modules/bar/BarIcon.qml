import QtQuick
import "../../services"

Item {
    id: root
    width: 28
    height: 28

    default property alias content: inner.data
    property string tooltip: ""

    readonly property bool hovered: hover.hovered

    HoverHandler { id: hover }

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

    onHoveredChanged: {
        if (hovered && tooltip !== "") {
            var pos = root.mapToItem(null, root.width, root.height / 2)
            TooltipState.x = pos.x
            TooltipState.y = pos.y
            TooltipState.text = tooltip
        } else {
            TooltipState.text = ""
        }
    }
}