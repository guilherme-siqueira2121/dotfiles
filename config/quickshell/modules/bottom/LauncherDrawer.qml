import QtQuick
import ".."
import "../../services"

Drawer {
    id: root
    direction: "bottom"

    onOpenChanged: {
        if (open) searchBar.focus()
        else searchBar.clear()
    }

    Column {
        spacing: 8

        AppList {
            id: appList
            width: searchBar.implicitWidth
            query: searchBar.text
        }

        Rectangle {
            width: searchBar.implicitWidth
            height: 1
            color: Theme.border
        }

        SearchBar {
            id: searchBar

            onSubmitted: appList.launchSelected()

            onMoveUp: appList.selectPrev()
            onMoveDown: appList.selectNext()
        }
    }
}