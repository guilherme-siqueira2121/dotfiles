import QtQuick
import "../../core"
import "../../services"

Drawer {
    direction: "top"

    Column {
        spacing: 12

        Clock {}

        Rectangle {
            width: parent.implicitWidth
            height: 1
            color: Theme.border
        }

        Calendar {}
    }
}