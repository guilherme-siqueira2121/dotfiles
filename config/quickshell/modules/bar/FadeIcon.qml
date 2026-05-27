import QtQuick
import "../../services"

Item {
    id: root

    property string icon: ""
    property color color: Theme.accent

    implicitWidth: 20
    implicitHeight: 20

    Text {
        id: current
        anchors.centerIn: parent
        text: root.icon
        color: root.color
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
        opacity: 1.0

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutCubic
            }
        }
    }

    Text {
        id: previous
        anchors.centerIn: parent
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
        opacity: 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: Theme.animFast
                easing.type: Easing.OutCubic
            }
        }
    }

    onIconChanged: {
        previous.text  = current.text
        previous.color = current.color
        previous.opacity = 1.0

        current.text = root.icon
        current.color = root.color
        current.opacity = 0.0

        Qt.callLater(() => {
            current.opacity  = 1.0
            previous.opacity = 0.0
        })
    }
}