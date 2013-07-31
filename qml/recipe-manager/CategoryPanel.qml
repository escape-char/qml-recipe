import QtQuick 2.0

Rectangle {
    property string backgroundColor: "#C4C4C4"
    id: categories
    height: parent.height
    width: parent.width
    color: backgroundColor

    Rectangle {
        id: categoriesContent
        height: parent.height - 41; width: parent.width - 3
        color: backgroundColor
    }

    ActionBar {
        anchors.top: categoriesContent.bottom
    }
}
