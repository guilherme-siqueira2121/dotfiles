import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

// ShellRoot é o elemento raiz obrigatório de todo config Quickshell
ShellRoot {

    // PanelWindow cria uma janela ancorada na tela (a barra em si)
    PanelWindow {
        // Ancorar no topo da tela
        anchors {
            top: true
            left: true
            right: true
        }

        // Altura da barra
        height: 26

        // Excluir a área da barra do espaço disponível para janelas
        exclusionMode: ExclusionMode.Normal

        // Cor de fundo
        color: "#0d0f1a"

        // Layout horizontal para os módulos
        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 8
            anchors.rightMargin: 8

            // Lado esquerdo - vazio por enquanto
            Item {
                Layout.fillWidth: true
            }

            // Centro - Relógio
            Text {
                id: clock

                // Atualiza o texto a cada segundo
                text: Qt.formatTime(new Date(), "hh:mm")

                color: "#8fb3d9"
                font.family: "JetBrains Mono Nerd Font"
                font.pixelSize: 13
                font.weight: Font.Medium

                // Timer para atualizar o relógio
                Timer {
                    interval: 1000   // 1 segundo
                    running: true
                    repeat: true
                    onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm")
                }
            }

            // Lado direito - vazio por enquanto
            Item {
                Layout.fillWidth: true
            }
        }
    }
}
