import QtQuick
import Quickshell
import Quickshell.Hyprland

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
                width: isActive ? 6 : 4
                height: width
                radius: width / 2
                color: isActive ? "#8fb3d9" : "#4a5068"

                Behavior on width {
                    NumberAnimation { duration: 150 }
                }

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }
            }

            TapHandler {
                onTapped: Hyprland.dispatch("workspace " + modelData.id)
            }
        }
    }
}