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

    mask: regions

    DrawerVisibilities {
        id: visibilities
    }

    Regions {
        id: regions
        bar: bar
        panels: panels
        win: root
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
        panels: panels
    }
}