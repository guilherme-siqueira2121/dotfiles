import QtQuick
import "../../components"
import "../../services"

BarIcon {
    FadeIcon {
        anchors.centerIn: parent
        icon: Network.state === "connected"    ? "󰤢"
            : Network.state === "connecting"   ? "󰤟"
            : Network.state === "disconnected" ? "󰤠"
            : "󰤮"
        color: Network.state === "connected" ? Theme.accent : Theme.muted
    }
}