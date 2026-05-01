import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../services"

Column {
    spacing: 12

    Repeater {
        model: Hyprland.workspaces

        delegate: Item {
            required property var modelData

            width: 28
            height: 28

            property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id

            Rectangle {
                anchors.centerIn: parent
                width: isActive ? 8 : 5
                height: width
                radius: width / 2
                color: isActive ? Theme.accent : Theme.muted

                Behavior on width {
                    NumberAnimation { duration: Theme.animFast }
                }
                Behavior on color {
                    ColorAnimation { duration: Theme.animFast }
                }
            }

            TapHandler {
                onTapped: Hyprland.dispatch("workspace " + modelData.id)
            }
        }
    }
}