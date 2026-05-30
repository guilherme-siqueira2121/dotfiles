import QtQuick
import "../../services"

Item {
    id: root

    signal launched

    property string query: ""
    property int selectedIndex: 0

    readonly property var filtered: Commands.query(query)

    implicitWidth: 300
    implicitHeight: Math.min(filtered.length, 6) * 52

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
            required property var modelData
            required property int index

            iconText:   modelData.icon
            name:       modelData.name
            comment:    modelData.comment
            isSelected: index === root.selectedIndex

            onTapped: {
                modelData.action()
                root.launched()
            }
            onHoveredChanged: if (hovered) root.selectedIndex = index
        }
    }
}