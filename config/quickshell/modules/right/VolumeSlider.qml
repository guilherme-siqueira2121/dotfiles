import QtQuick
import "../../services"

SystemSlider {
    level: 50
    getCommand: ["bash", "-c", "pamixer --get-volume 2>/dev/null || echo 50"]
    setCommand: ["bash", "-c", "pamixer --set-volume " + String(level)]
    pollInterval: 2000
}