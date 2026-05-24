pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property var actions: [
        {
            name: "Sair",
            comment: "Encerrar sessão Hyprland",
            icon: "󰍃",
            action: () => Quickshell.execDetached(["hyprctl", "dispatch", "exit"])
        },
        {
            name: "Suspender",
            comment: "Suspender o sistema",
            icon: "󰒲",
            action: () => Quickshell.execDetached(["systemctl", "suspend"])
        },
        {
            name: "Reiniciar",
            comment: "Reiniciar o sistema",
            icon: "󰜉",
            action: () => Quickshell.execDetached(["systemctl", "reboot"])
        },
        {
            name: "Desligar",
            comment: "Desligar o sistema",
            icon: "󰐥",
            action: () => Quickshell.execDetached(["systemctl", "poweroff"])
        },
        {
            name: "Wallpaper",
            comment: "Trocar wallpaper aleatoriamente",
            icon: "󰸉",
            action: () => Quickshell.execDetached(["bash", "-c", "$HOME/dotfiles/bin/change-wall.sh"])
        },
    ]

    function query(text) {
        const q = text.trim().toLowerCase()
        if (q === "") return actions
        return actions.filter(a =>
            a.name.toLowerCase().includes(q) ||
            a.comment.toLowerCase().includes(q)
        )
    }
}