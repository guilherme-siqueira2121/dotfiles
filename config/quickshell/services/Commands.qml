pragma Singleton
import QtQuick
import Quickshell

Singleton {
    readonly property var actions: [
        {
            name: "Exit",
            comment: "End Hyprland session",
            icon: "󰍃",
            action: () => Quickshell.execDetached(["hyprctl", "dispatch", "exit"])
        },
        {
            name: "Suspend",
            comment: "Suspend the system",
            icon: "󰒲",
            action: () => Quickshell.execDetached(["systemctl", "suspend"])
        },
        {
            name: "Reboot",
            comment: "Reboot the system",
            icon: "󰜉",
            action: () => Quickshell.execDetached(["systemctl", "reboot"])
        },
        {
            name: "Shutdown",
            comment: "Shut down the system",
            icon: "󰐥",
            action: () => Quickshell.execDetached(["systemctl", "poweroff"])
        },
        {
            name: "Wallpaper",
            comment: "Change wallpaper randomly",
            icon: "󰸉",
            action: () => Quickshell.execDetached(["bash", "-c", "$HOME/dotfiles/bin/change-wall.sh"])
        },
        {
            name: "Theme",
            comment: "Toggle between light and dark",
            icon: "󰔎",
            action: () => ThemeManager.toggle()
        },
    ]

    function query(text) {
        const q = text.trim().toLowerCase()
        if (q === "") return actions
        return actions.filter(a => a.name.toLowerCase().includes(q))
    }
}