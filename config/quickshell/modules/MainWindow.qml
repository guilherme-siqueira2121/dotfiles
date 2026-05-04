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

    mask: Regions {
        bar: bar
        panels: panels
        win: root
    }

    DrawerVisibilities {
        id: visibilities
    }

    Bar {
        id: bar
    }

    Panels {
        id: panels
        visibilities: visibilities
        bar: bar
    }

    Interactions {
        visibilities: visibilities
        bar: bar
    }
}