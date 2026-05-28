import QtQuick
import "../../services"

Item {
    id: root

    property string icon: ""
    property color color: Theme.accent

    implicitWidth: 20
    implicitHeight: 20

    Text {
        id: textA
        anchors.centerIn: parent
        text: root.icon
        color: root.color
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16

        Behavior on opacity {
            NumberAnimation { duration: Theme.animFast }
        }
    }

    Text {
        id: textB
        anchors.centerIn: parent
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
        opacity: 0

        Behavior on opacity {
            NumberAnimation { duration: Theme.animFast }
        }
    }

    property bool useA: true

    onIconChanged: {
        if (useA) {
            textB.text = root.icon
            textB.color = root.color
            textB.opacity = 1
            textA.opacity = 0
        } else {
            textA.text = root.icon
            textA.color = root.color
            textA.opacity = 1
            textB.opacity = 0
        }
        useA = !useA
    }
}