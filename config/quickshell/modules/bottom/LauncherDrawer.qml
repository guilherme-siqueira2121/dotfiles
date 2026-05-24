import QtQuick
import ".."
import "../../services"

Drawer {
    id: root
    direction: "bottom"

    signal launched

    onOpenChanged: {
        if (open) searchBar.activate()
        else searchBar.clear()
    }

    Column {
        spacing: 8

        ContentList {
            id: contentList
            width: searchBar.implicitWidth
            query: searchBar.text
            onLaunched: root.launched()
        }

        Rectangle {
            width: searchBar.implicitWidth
            height: 1
            color: Theme.border
        }

        SearchBar {
            id: searchBar
            onSubmitted: contentList.launchSelected()
            onMoveUp: contentList.selectPrev()
            onMoveDown: contentList.selectNext()
        }
    }
}