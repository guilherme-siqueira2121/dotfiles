import QtQuick
import "../../services"

Item {
    id: root

    implicitWidth: 300
    implicitHeight: row.implicitHeight + 16

    property alias text: input.text
    property bool commandMode: text.startsWith(">")

    signal submitted
    signal moveUp
    signal moveDown

    function activate() { input.forceActiveFocus() }
    function clear() { input.text = "" }

    Rectangle {
        anchors.fill: parent
        color: Theme.overlay
        radius: Theme.radius

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 8

            Text {
                text: root.commandMode ? "󰆍" : "󰍉"
                color: root.commandMode ? Theme.accent : Theme.muted
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 14
                anchors.verticalCenter: parent.verticalCenter

                Behavior on color {
                    ColorAnimation { duration: Theme.animFast }
                }
            }

            TextInput {
                id: input
                width: root.implicitWidth - 48
                color: Theme.text
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                clip: true
                anchors.verticalCenter: parent.verticalCenter

                Keys.onReturnPressed: root.submitted()
                Keys.onEscapePressed: root.clear()
                Keys.onUpPressed: root.moveUp()
                Keys.onDownPressed: root.moveDown()

                Text {
                    anchors.fill: parent
                    text: root.commandMode ? "Search actions..." : "Search apps..."
                    color: Theme.muted
                    font: parent.font
                    visible: parent.text === ""
                }
            }

            Rectangle {
                visible: !root.commandMode
                anchors.verticalCenter: parent.verticalCenter
                color: Theme.surface
                radius: 4
                implicitWidth: badge.implicitWidth + 8
                implicitHeight: badge.implicitHeight + 4

                Text {
                    id: badge
                    anchors.centerIn: parent
                    text: "> actions"
                    color: Theme.muted
                    font.family: "JetBrains Mono Nerd Font"
                    font.pixelSize: 9
                }
            }
        }
    }
}