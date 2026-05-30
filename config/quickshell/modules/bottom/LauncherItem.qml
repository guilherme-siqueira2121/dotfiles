import QtQuick
import "../../services"

Rectangle {
    id: root

    required property string iconText
    required property string name
    required property string comment
    required property bool isSelected

    signal tapped
    signal hovered

    width: 300
    height: 50
    radius: Theme.radius
    color: "transparent"

    HoverHandler {
        id: hover
        onHoveredChanged: if (hover.hovered) root.hovered()
    }

    TapHandler {
        onTapped: root.tapped()
    }

    Rectangle {
        anchors.fill: parent
        radius: parent.radius
        color: Theme.overlay
        opacity: root.isSelected || hover.hovered ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutCubic
            }
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
                text: root.iconText
                color: Theme.accent
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 16
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 2

            Text {
                text: root.name
                color: Theme.text
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                font.weight: Font.Medium
            }

            Text {
                text: root.comment
                color: Theme.muted
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
                visible: text !== ""
                elide: Text.ElideRight
                width: 240
            }
        }
    }
}