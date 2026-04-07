import QtQuick

Item {
    property alias icon: iconText
    property string command: ""

    width: 40
    height: 40

    Text {
        id: iconText
        anchors.centerIn: parent
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
    }

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: hover.containsMouse ? "#161830" : "transparent"
        Behavior on color { ColorAnimation { duration: 120 } }
    }

    HoverHandler { id: hover }

    TapHandler {
        onTapped: {
            if (command !== "")
                Qt.openUrlExternally("") // placeholder
        }
    }
}