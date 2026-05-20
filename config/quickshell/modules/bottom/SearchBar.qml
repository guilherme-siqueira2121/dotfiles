import QtQuick
import "../../services"

Item {
    id: root

    implicitWidth: row.implicitWidth  + 24
    implicitHeight: row.implicitHeight + 16

    property alias text: input.text
    property bool commandMode: text.startsWith(">")

    signal submitted

    Rectangle {
        anchors.fill: parent
        color: Theme.overlay
        radius: Theme.radius

        Row {
            id: row
            anchors.centerIn: parent
            spacing: 8

            Text {
                text:  root.commandMode ? "󰆍" : "󰍉"
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
                width: 220
                color: Theme.text
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                clip: true
                anchors.verticalCenter: parent.verticalCenter

                Keys.onReturnPressed: root.submitted()
                Keys.onEscapePressed: input.text = ""

                Text {
                    anchors.fill: parent
                    text: "Buscar aplicativos..."
                    color: Theme.muted
                    font: parent.font
                    visible: parent.text === ""
                }
            }
        }
    }
}