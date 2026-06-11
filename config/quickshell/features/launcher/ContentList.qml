import QtQuick
import "../../services"

Item {
    id: root

    property string query: ""
    property int selectedIndex: 0

    signal launched

    readonly property bool actionMode: query.startsWith(">")
    readonly property string cleanQuery: actionMode ? query.slice(1) : query

    implicitWidth: list.implicitWidth
    implicitHeight: list.implicitHeight

    function selectPrev() {
        if (selectedIndex > 0) selectedIndex--
    }

    function selectNext() {
        const count = actionMode
            ? actionList.filtered.length
            : appList.filtered.length
        if (selectedIndex < count - 1) selectedIndex++
    }

    function launchSelected() {
        if (actionMode) actionList.launchSelected()
        else appList.launchSelected()
    }

    onQueryChanged: selectedIndex = 0

    Item {
        id: list
        implicitWidth: actionMode ? actionList.implicitWidth : appList.implicitWidth
        implicitHeight: actionMode ? actionList.implicitHeight : appList.implicitHeight

        AppList {
            id: appList
            width: root.implicitWidth
            query: root.cleanQuery
            selectedIndex: root.selectedIndex
            visible: true
            opacity: root.actionMode ? 0 : 1
            onLaunched: root.launched()

            Behavior on opacity {
                NumberAnimation {
                    duration: Theme.animFast
                    easing.type: Easing.OutCubic
                }
            }
        }

        ActionList {
            id: actionList
            width: root.implicitWidth
            query: root.cleanQuery
            selectedIndex: root.selectedIndex
            visible: true
            opacity: root.actionMode ? 1 : 0
            onLaunched: root.launched()

            Behavior on opacity {
                NumberAnimation {
                    duration: Theme.animFast
                    easing.type: Easing.OutCubic
                }
            }
        }
    }
}