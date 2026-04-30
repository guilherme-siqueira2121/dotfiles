import QtQuick
import Quickshell
import Quickshell.Wayland
import "bar"
import "top"
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

    mask: Region {
        Region {
            x: 0
            y: 0
            width: Theme.barWidth
            height: root.height
            intersection: Intersection.Subtract
        }

        Region {
            x: 0
            y: 0
            width: root.width
            height: Theme.barBorder
            intersection: Intersection.Subtract
        }

        Region {
            x: root.width - Theme.barBorder
            y: 0
            width: Theme.barBorder
            height: root.height
            intersection: Intersection.Subtract
        }

        Region {
            x: 0
            y: root.height - Theme.barBorder
            width: root.width
            height: Theme.barBorder
            intersection: Intersection.Subtract
        }
    }

    Bar {
        id: bar
    }

    ClockDrawer {
        open: topBorder.hovered
    }

    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: Theme.barBorder
        color: Theme.bg
    }

    Rectangle {
    anchors {
        top: parent.top
        bottom: parent.bottom
        right: parent.right
    }

    width: Theme.barBorder
    color: Theme.bg
    }

    Rectangle {
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }

        height: Theme.barBorder
        color: Theme.bg
    }

    Rectangle {
    id: topBorder
    anchors {
        top:   parent.top
        left:  parent.left
        right: parent.right
    }
    height: Theme.barBorder
    color:  Theme.bg

    HoverHandler { id: topHover }
    property bool hovered: topHover.hovered
    }
}