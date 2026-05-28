import QtQuick
import Quickshell
import Quickshell.Wayland
import "bar"
import "../services"

PanelWindow {
    id: root

    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true

    color: "transparent"
    WlrLayershell.exclusionMode: ExclusionMode.Ignore
    WlrLayershell.layer: WlrLayer.Overlay

    WlrLayershell.keyboardFocus: DrawerVisibilities.launcher
        ? WlrKeyboardFocus.OnDemand
        : WlrKeyboardFocus.None

    mask: regions

    Regions {
        id: regions
        bar: bar
        panels: panels
        win: root
    }

    Bar { id: bar }

    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: Theme.barBorder
        color:  Theme.bg
    }

    Rectangle {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: Theme.barBorder
        color: Theme.bg
    }

    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: Theme.barBorder
        color: Theme.bg
    }

    Panels {
        id: panels
        bar: bar
    }

    Interactions {
        bar: bar
        panels: panels
    }

    Rectangle {
        id: tooltipBox
        visible: TooltipState.text !== ""
        x: Theme.barWidth + 8
        y: TooltipState.y - height / 2
        width: tooltipLabel.implicitWidth + 16
        height: tooltipLabel.implicitHeight + 10
        color: Theme.surface
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1
        z: 200

        opacity: visible ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutCubic
            }
        }

        Text {
            id: tooltipLabel
            anchors.centerIn: parent
            text: TooltipState.text
            color: Theme.text
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 11
        }
    }
}