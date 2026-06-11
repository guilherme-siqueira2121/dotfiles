import QtQuick
import Quickshell
import "../services"

Rectangle {
    id: root

    required property string iconText
    required property string name
    required property string comment
    required property bool isSelected

    property string iconName: ""

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
        anchors.right: parent.right
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 10

        Rectangle {
            width: 32
            height: 32
            radius: 8
            color: Theme.surface
            anchors.verticalCenter: parent.verticalCenter

            readonly property string resolvedIcon: root.iconName !== ""
                ? Quickshell.iconPath(root.iconName, true)
                : ""

            Image {
                anchors.fill: parent
                anchors.margins: 4
                source: parent.resolvedIcon
                visible: parent.resolvedIcon !== ""
                smooth: true
                mipmap: true
            }

            Text {
                anchors.centerIn: parent
                text: root.iconText
                color: Theme.accent
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 16
                visible: parent.resolvedIcon === ""
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - 32 - parent.spacing - parent.anchors.leftMargin - parent.anchors.rightMargin
            spacing: 2

            Text {
                text: root.name
                color: Theme.text
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 12
                font.weight: Font.Medium
                elide: Text.ElideRight
                width: parent.width
            }

            Text {
                text: root.comment
                color: Theme.muted
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 10
                visible: text !== ""
                elide: Text.ElideRight
                width: parent.width
            }
        }
    }
}