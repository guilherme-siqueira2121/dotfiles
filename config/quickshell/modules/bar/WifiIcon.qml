import QtQuick
import "../../services"

BarIcon {
    Text {
        anchors.centerIn: parent
        text: Network.state === "connected"    ? "󰤢"
            : Network.state === "connecting"   ? "󰤟"
            : Network.state === "disconnected" ? "󰤠"
            : "󰤮"
        color: Network.state === "connected" ? Theme.accent : Theme.muted
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 16
    }
}