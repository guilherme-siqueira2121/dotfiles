import QtQuick
import "../../services"

SystemSlider {
    level: 100
    sliderFrom: 1
    getCommand: ["bash", "-c", "brightnessctl -m | awk -F, '{print $4}' | tr -d '%'"]
    setCommand: ["bash", "-c", "brightnessctl set " + String(level) + "%"]
    pollInterval: 3000
}