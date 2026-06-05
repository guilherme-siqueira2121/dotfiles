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
            height: (1 - root.visualPosition) * parent.height
            anchors.bottom: parent.bottom
            radius: 2
            color: Theme.accent
        }

        Behavior on height {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutCubic
            }
        }
    }

    handle: Rectangle {
        x: root.width / 2 - width / 2
        y: root.visualPosition * (root.height - height)
        width: 14
        height: 14
        radius: 7
        color: root.pressed ? Theme.accent : Theme.bg
        border.color: Theme.accent
        border.width: 2
        
        Behavior on color {
            ColorAnimation { duration: Theme.animFast }
        }
    }
}