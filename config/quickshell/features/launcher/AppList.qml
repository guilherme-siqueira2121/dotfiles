import QtQuick
import Quickshell
import "../../components"
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
            (a.name ?? "").toLowerCase().includes(q)
        ).slice(0, 6)
    }

    implicitWidth: 300
    implicitHeight: filtered.length > 0 ? Math.min(filtered.length, 6) * 52 : 52

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
            id: delegate
            required property var modelData
            required property int index

            width: ListView.view.width
            iconText: (modelData.name ?? "?").charAt(0).toUpperCase()
            iconName: modelData.icon ?? ""
            name: modelData.name ?? ""
            comment: modelData.comment ?? ""
            isSelected: index === root.selectedIndex

            onTapped: root.launch(modelData)
            onHovered: root.selectedIndex = index

            Component.onCompleted: {
                delegate.opacity = 0
                delegate.scale = 0.85
                entryAnim.restart()
            }

            Connections {
                target: DrawerVisibilities
                function onLauncherChanged() {
                    if (DrawerVisibilities.launcher) {
                        delegate.opacity = 0
                        delegate.scale = 0.85
                        entryAnim.restart()
                    }
                }
            }

            ParallelAnimation {
                id: entryAnim

                SequentialAnimation {
                    PauseAnimation { duration: delegate.index * 200 }
                    NumberAnimation {
                        target: delegate
                        property: "opacity"
                        from: 0; to: 1
                        duration: 1000
                        easing.type: Easing.OutCubic
                    }
                }

                SequentialAnimation {
                    PauseAnimation { duration: delegate.index * 200 }
                    NumberAnimation {
                        target: delegate
                        property: "scale"
                        from: 0.85; to: 1.0
                        duration: 1000
                        easing.type: Easing.OutBack
                    }
                }
            }
        }
    }

    Text {
        anchors.centerIn: parent
        visible: root.filtered.length === 0
        text: "No apps found"
        color: Theme.muted
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 11
    }
}