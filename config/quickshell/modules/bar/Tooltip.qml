import QtQuick
import QtQuick.Controls
import "../../services"

Popup {
    id: root

    required property Item target
    required property string text
    property int delay: 600

    visible: false
    modal: false
    closePolicy: Popup.NoAutoClose
    padding: 0
    background: Item {}

    Timer {
        id: showTimer
        interval: root.delay
        onTriggered: root.visible = true
    }

    function updatePosition() {
        Qt.callLater(() => {
            const pos = target.mapToItem(parent, 0, 0)
            x = pos.x + target.width + 8
            y = pos.y + target.height / 2 - height / 2
        })
    }

    onVisibleChanged: {
        if (visible) updatePosition()
    }

    Connections {
        target: root.target
        function onHoveredChanged() {
            if (root.target.hovered) {
                showTimer.start()
            } else {
                showTimer.stop()
                root.visible = false
            }
        }
    }

    contentItem: Rectangle {
        implicitWidth: label.implicitWidth + 16
        implicitHeight: label.implicitHeight + 8
        color: Theme.surface
        radius: Theme.radius
        border.color: Theme.border
        border.width: 1

        Text {
            id: label
            anchors.centerIn: parent
            text: root.text
            color: Theme.text
            font.family: "JetBrains Mono Nerd Font"
            font.pixelSize: 11
        }
    }
}