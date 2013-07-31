import QtQuick 2.0

Rectangle {
    id: recipeItem
    height: parent.height
    width: parent.width
    color: "#ffffff"

    Rectangle {
        id: recipeItemContent
        height: parent.height - 41

        Text {
            height: 20
            width: parent.width
            //text: recipeList.currentItem.recipeData.title
            color: "#444444"
            font {pointSize: 22; bold: true}
        }
    }

    ActionBar {
        anchors.top: recipeItemContent.bottom
    }
}
