import QtQuick
import "../services"

Item {
    id: root

    property string icon: ""
    property color color: Theme.accent

    implicitWidth: 20
    implicitHeight: 20

    property bool useA: true

    onIconChanged: {
        if (useA) {
            textB.text = root.icon
            textB.color = root.color
            textA.opacity = 0
            textB.opacity = 1
        } else {
            textA.text = root.icon
            textA.color = root.color
            textB.opacity = 0
            textA.opacity = 1
        }
        useA = !useA
    }

    Text {
        id: textA
        anchors.centerIn: parent
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
        text: root.icon
        color: root.color
        opacity: 1

        Behavior on opacity {
            NumberAnimation { duration: Theme.animFast }
        }
    }

    Text {
        id: textB
        anchors.centerIn: parent
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
        text: root.icon
        color: root.color
        opacity: 0

        Behavior on opacity {
            NumberAnimation { duration: Theme.animFast }
        }
    }
}