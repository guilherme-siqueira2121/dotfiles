import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

Row {
    spacing: 4

    Repeater {
        model: Hyprland.workspaces

        delegate: Item {
            required property var modelData

            property bool isActive: Hyprland.focusedWorkspace !== null &&
                Hyprland.focusedWorkspace.id === modelData.id

            width: 24
            height: 24

            Text {
                anchors.centerIn: parent
                text: isActive ? "●" : "○"
                color: isActive ? "#8fb3d9" : "#3a3d5c"
                font.pixelSize: 13
                font.family: "JetBrains Mono Nerd Font"
            }

            TapHandler {
                onTapped: Hyprland.dispatch("workspace " + modelData.id)
            }
        }
    }
}