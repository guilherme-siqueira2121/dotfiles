import QtQuick
import Quickshell
import Quickshell.Wayland
import "../services"

PanelWindow {
    id: root

    anchors.left: true
    anchors.top: true
    anchors.bottom: true

    implicitWidth: TooltipState.text !== ""
        ? label.implicitWidth + 24
        : 1

    color: "transparent"
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    mask: Region {
        x: Theme.barWidth + 8
        y: tooltipBox.y
        width: tooltipBox.visible ? tooltipBox.width : 0
        height: tooltipBox.visible ? tooltipBox.height : 0
    }

    Rectangle {
        id: tooltipBox
        visible: TooltipState.text !== ""
        x: Theme.barWidth + 8
        y: TooltipState.y - height / 2
        width: label.implicitWidth + 16
        height: label.implicitHeight + 10
        color: Theme.surface
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        opacity: visible ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutCubic
            }
        }

        Text {
            id: label
            anchors.centerIn: parent
            text: TooltipState.text
            color: Theme.text
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 11
        }
    }
}