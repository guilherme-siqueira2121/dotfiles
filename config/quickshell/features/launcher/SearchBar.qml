import QtQuick
import QtQuick.Layouts
import "../../components"
import "../../services"

Item {
    id: root

    implicitWidth: 300
    implicitHeight: layout.implicitHeight + 16

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

        RowLayout {
            id: layout
            anchors.centerIn: parent
            width: parent.width - 16
            spacing: 8

            FadeIcon {
                icon: root.commandMode ? "󰆍" : "󰍉"
                color: root.commandMode ? Theme.accent : Theme.muted
                Layout.alignment: Qt.AlignVCenter
            }

            TextInput {
                id: input
                Layout.fillWidth: true
                color: Theme.text
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                clip: true
                Layout.alignment: Qt.AlignVCenter

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

                    Behavior on opacity {
                        NumberAnimation { duration: Theme.animFast }
                    }
                }
            }

            Item {
                implicitWidth: badge.implicitWidth + 8
                implicitHeight: badge.implicitHeight + 4
                Layout.alignment: Qt.AlignVCenter
                opacity: root.commandMode ? 0 : 1
                scale: root.commandMode ? 0.85 : 1.0

                Behavior on opacity {
                    NumberAnimation {
                        duration: Theme.animFast
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: Theme.animFast
                        easing.type: Easing.OutBack
                    }
                }

                Rectangle {
                    anchors.fill: parent
                    color: Theme.surface
                    radius: 4

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
}