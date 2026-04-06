import QtQuick
import Quickshell
import QtQuick.Layouts

PanelWindow {
    id: bar

    anchors.top: true
    width: Screen.width
    height: 30

    color: "#1e1e2e"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10


        Text {
            text: "Meu Sistema"
            color: "#cdd6f4"
        }

        Item {
            Layout.fillWidth: true
        }

        ClockText {}
    }
}