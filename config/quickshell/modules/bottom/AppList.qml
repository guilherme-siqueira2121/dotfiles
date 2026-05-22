import QtQuick
import Quickshell.Io
import "../../services"

Item {
    id: root

    implicitHeight: Math.min(filtered.length, 6) * 52

    property string query: ""
    property bool commandMode: query.startsWith(">")
    property int selectedIndex: 0

    onQueryChanged: selectedIndex = 0

    function selectPrev() {
        if (selectedIndex > 0)
            selectedIndex--
    }

    function selectNext() {
        if (selectedIndex < filtered.length - 1)
            selectedIndex++
    }

    function launchSelected() {
        if (filtered.length > 0)
            launch(filtered[selectedIndex].exec)
    }

    readonly property var commands: [
        { name: "Sair", comment: "Encerrar sessão", icon: "󰍃", exec: "hyprctl dispatch exit" },
        { name: "Suspender", comment: "Suspender sistema", icon: "󰒲", exec: "systemctl suspend" },
        { name: "Reiniciar", comment: "Reiniciar sistema", icon: "󰜉", exec: "systemctl reboot" },
        { name: "Desligar", comment: "Desligar sistema", icon: "󰐥", exec: "systemctl poweroff" },
    ]

    property var allApps: []

    Process {
        id: loadApps
        command: ["bash", "-c", "python3 $HOME/dotfiles/bin/list-apps.py"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                try { root.allApps = JSON.parse(text) } catch(e) {}
            }
        }
    }

    readonly property var filtered: {
        if (commandMode) {
            const q = query.slice(1).trim().toLowerCase()
            return q === ""
                ? commands
                : commands.filter(c => c.name.toLowerCase().includes(q))
        }
        const q = query.trim().toLowerCase()
        if (q === "") return allApps.slice(0, 6)
        return allApps.filter(a =>
            a.name.toLowerCase().includes(q) ||
            a.comment.toLowerCase().includes(q)
        ).slice(0, 6)
    }

    Process {
        id: execProc
        property string cmd: ""
        command: ["bash", "-c", cmd]
        running: false
    }

    function launch(exec) {
        execProc.cmd = exec
        execProc.running = true
    }

    ListView {
        anchors.fill: parent
        model: root.filtered
        clip: true
        spacing: 2

        delegate: Rectangle {
            required property var modelData
            required property int index

            width: root.width
            height: 50
            radius: Theme.radius

            property bool isSelected: index === root.selectedIndex
            property bool isHovered: itemHover.hovered

            color: "transparent"

            Rectangle {
                anchors.fill: parent
                radius: parent.radius
                color: Theme.overlay

                opacity: parent.isSelected || parent.isHovered ? 1.0 : 0.0

                Behavior on opacity {
                    NumberAnimation {
                        duration: Theme.animFast
                        easing.type: Easing.OutCubic
                    }
                }
            }

            HoverHandler {
                id: itemHover
                onHoveredChanged: if (hovered) root.selectedIndex = index
            }

            TapHandler {
                onTapped: root.launch(modelData.exec)
            }

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 8
                spacing: 10

                Rectangle {
                    width: 32
                    height: 32
                    radius: 8
                    color: Theme.surface
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        anchors.centerIn: parent
                        text: modelData.name.charAt(0).toUpperCase()
                        color: Theme.accent
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 14
                        font.weight: Font.Bold
                    }
                }

                Column {
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 2

                    Text {
                        text: modelData.name
                        color: Theme.text
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 12
                        font.weight: Font.Medium
                    }

                    Text {
                        text: modelData.comment
                        color: Theme.muted
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 10
                        visible: text !== ""
                        elide: Text.ElideRight
                        width: root.width - 60
                    }
                }
            }
        }
    }
}