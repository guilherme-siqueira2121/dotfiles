import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Item {
    id: root

    // Propriedades públicas
    property alias icon: iconText
    property string label: ""
    property string command: ""
    property bool expanded: false
    property bool isPower: false
    property bool hovered: hoverHandler.containsMouse

    signal clicked()

    // Dimensões
    width: expanded ? 158 : 40
    height: 40

    Behavior on width {
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }

    // Processo para executar comandos
    Process {
        id: proc
        command: ["bash", "-c", root.command]
        running: false
    }

    // Fundo pill — reage ao hover individual
    Rectangle {
        id: pill
        anchors.fill: parent
        radius: 12
        color: {
            if (hoverHandler.containsMouse && root.isPower)
                return "#f0d0d4"
            if (hoverHandler.containsMouse)
                return "#d0d4f0"
            return "transparent"
        }

        Behavior on color {
            ColorAnimation { duration: 150 }
        }

        // Layout interno: ícone + label
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 8

            // Ícone
            Text {
                id: iconText
                Layout.preferredWidth: 20
                horizontalAlignment: Text.AlignHCenter
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 16
                // cor e texto definidos pelo pai via alias
            }

            // Label com fade-in ao expandir
            Text {
                id: labelText
                Layout.fillWidth: true
                text: root.label
                color: root.isPower ? "#9090b8" : "#5a5e8a"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 11
                font.weight: Font.Medium
                elide: Text.ElideRight
                opacity: root.expanded ? 1.0 : 0.0
                visible: root.expanded

                Behavior on opacity {
                    NumberAnimation {
                        duration: 160
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }

    HoverHandler {
        id: hoverHandler
    }

    TapHandler {
        onTapped: {
            if (root.isPower) {
                root.clicked()
            } else if (root.command !== "") {
                proc.running = true
            }
        }
    }
}
