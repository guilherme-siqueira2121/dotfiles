import QtQuick
import Quickshell
import "../../services"

Item {
    id: root

    signal launched

    property string query: ""
    property int selectedIndex: 0

    readonly property var filtered: {
        const q = query.trim().toLowerCase()
        if (q === "") return DesktopEntries.applications.values.slice(0, 6)
        return DesktopEntries.applications.values.filter(a =>
            (a.name ?? "").toLowerCase().includes(q) ||
            (a.comment ?? "").toLowerCase().includes(q)
        ).slice(0, 6)
    }

    implicitWidth: 300
    implicitHeight: Math.min(filtered.length, 6) * 52

    function launchSelected() {
        if (filtered.length > 0) launch(filtered[selectedIndex])
    }

    function launch(entry) {
        entry.execute()
        root.launched()
    }

    ListView {
        anchors.fill: parent
        model: root.filtered
        clip: true
        spacing: 2

        delegate: LauncherItem {
            required property var modelData
            required property int index

            iconText: (modelData.name ?? "?").charAt(0).toUpperCase()
            name: modelData.name ?? ""
            comment: modelData.comment ?? ""
            isSelected: index === root.selectedIndex

            onTapped: root.launch(modelData)
            onHoveredChanged: if (hovered) root.selectedIndex = index
        }
    }
}