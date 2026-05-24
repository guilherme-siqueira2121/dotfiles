import QtQuick
import "../../services"

Item {
    id: root

    signal launched

    property string query: ""
    property int selectedIndex: 0

    readonly property var filtered: Commands.query(query)

    implicitWidth: 300
    implicitHeight: Math.min(filtered.length, 6) * 52

    function launchSelected() {
        if (filtered.length > 0) {
            filtered[selectedIndex].action()
            root.launched()
        }
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
                onTapped: {
                    modelData.action()
                    root.launched()
                }
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
                        text: modelData.icon
                        color: Theme.accent
                        font.family: "JetBrains Mono Nerd Font"
                        font.pixelSize: 16
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