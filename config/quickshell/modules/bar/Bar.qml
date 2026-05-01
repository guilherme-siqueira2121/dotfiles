import QtQuick
import "../../services"

Rectangle {
    anchors {
        top: parent.top
        bottom: parent.bottom
        left: parent.left
    }

    width: Theme.barWidth
    color: Theme.bg
    border.color: Theme.border
    border.width: 1

    Column {
        anchors {
            top: parent.top
            topMargin: 16
            horizontalCenter: parent.horizontalCenter
        }

        Workspaces {}
    }
}