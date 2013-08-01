import QtQuick 2.0
import ".."

Rectangle {
    id: categoryDelegate
    width: parent.width
    height: 30
    color: "transparent"
    property variant category


    CategoryItem {
        label: name
        hasIcon: false
    }
}
