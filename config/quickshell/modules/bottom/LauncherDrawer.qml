import QtQuick
import ".."
import "../../services"

Drawer {
    direction: "bottom"

    Column {
        spacing: 8

        AppList {
            id: appList
            query: searchBar.text
        }

        Rectangle {
            width: searchBar.implicitWidth
            height: 1
            color: Theme.border
        }

        SearchBar {
            id: searchBar
            onSubmitted: {
                if (appList.filtered.length > 0)
                    appList.launch(appList.filtered[0].exec)
            }
        }
    }
}