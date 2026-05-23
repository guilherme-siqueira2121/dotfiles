import QtQuick
import Quickshell
import Quickshell.Io
import "../../services"

Item {
    id: root

    signal launched

    implicitHeight: Math.min(filtered.length, 6) * 52

    property string query: ""
    property int selectedIndex: 0

    onQueryChanged: selectedIndex = 0

    function selectPrev() {
        if (selectedIndex > 0) selectedIndex--
    }

    function selectNext() {
        if (selectedIndex < filtered.length - 1) selectedIndex++
    }

    function launchSelected() {
        if (filtered.length > 0) launch(filtered[selectedIndex])
    }

    function launch(entry) {
        Quickshell.execDetached({
            command: entry.command
        })
        root.launched()
    }

    readonly property var allApps: DesktopEntries.applications.values

    readonly property var filtered: {
        const q = query.trim().toLowerCase()
        if (q === "") return allApps.slice(0, 6)
        return allApps.filter(a =>
            (a.name ?? "").toLowerCase().includes(q) ||
            (a.comment ?? "").toLowerCase().includes(q)
        ).slice(0, 6)
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
            color: "transparent"

            property bool isSelected: index === root.selectedIndex
            property bool isHovered: itemHover.hovered

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
                onTapped: root.launch(modelData)
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
                        text: (modelData.name ?? "?").charAt(0).toUpperCase()
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
                        text: modelData.name ?? ""
                        color: Theme.text
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 12
                        font.weight: Font.Medium
                    }

                    Text {
                        text: modelData.comment ?? ""
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