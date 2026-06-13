import QtQuick
import "../../components"
import "../../services"

Item {
    id: root

    signal launched

    property string query: ""
    property int selectedIndex: 0

    readonly property var filtered: Commands.query(query)

    implicitWidth: 300
    implicitHeight: filtered.length > 0 ? Math.min(filtered.length, 6) * 52 : 52

    function launchSelected() {
        if (filtered.length > 0) {
            filtered[selectedIndex].action()
            root.launched()
        }
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
            iconText: modelData.icon
            name: modelData.name
            comment: modelData.comment
            isSelected: index === root.selectedIndex

            onTapped: {
                modelData.action()
                root.launched()
            }
            onHovered: root.selectedIndex = index

            Component.onCompleted: {
                delegate.opacity = 0
                delegate.scale = 0.85
                entryAnim.restart()
            }

            Connections {
                target: Animations
                function onLauncherOpened() {
                    delegate.opacity = 0
                    delegate.scale = 0.85
                    entryAnim.restart()
                }
                function onActionModeActivated() {
                    delegate.opacity = 0
                    delegate.scale = 0.85
                    entryAnim.restart()
                }
            }

            ParallelAnimation {
                id: entryAnim

                SequentialAnimation {
                    PauseAnimation { duration: delegate.index * 40 }
                    NumberAnimation {
                        target: delegate
                        property: "opacity"
                        from: 0; to: 1
                        duration: Theme.animNormal
                        easing.type: Easing.OutCubic
                    }
                }

                SequentialAnimation {
                    PauseAnimation { duration: delegate.index * 40 }
                    NumberAnimation {
                        target: delegate
                        property: "scale"
                        from: 0.85; to: 1.0
                        duration: Theme.animNormal
                        easing.type: Easing.OutBack
                    }
                }
            }
        }
    }

    Text {
        anchors.centerIn: parent
        visible: root.filtered.length === 0
        text: "No actions found"
        color: Theme.muted
        font.family: "JetBrains Mono Nerd Font"
        font.pixelSize: 11
    }
}