import QtQuick
import QtQuick.Controls
import "../../services"

Slider {
    id: root

    orientation: Qt.Vertical
    implicitWidth: 28
    implicitHeight: 120

    background: Rectangle {
        x: root.width / 2 - width / 2
        y: 0
        width: 4
        height: root.height
        radius: 2
        color: Theme.overlay

        Rectangle {
            width: parent.width
            height: root.visualPosition * parent.height
            anchors.bottom: parent.bottom
            radius: 2
            color: Theme.accent
        }
    }

    handle: Rectangle {
        x: root.width / 2 - width / 2
        y: root.visualPosition * (root.height - height)
        width: 14
        height: 14
        radius: 7
        color: Theme.bg
        border.color: Theme.accent
        border.width: 2

        Behavior on y {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutCubic
            }
        }
    }
}