import QtQuick 2.0
import "../CustomWidgets"

Rectangle {
    id: recipeItem
    height: parent.height
    width: parent.width
    color: "#ffffff"

    //holds data for recipe
    property variant recipe

    signal loaded()

    Component.onCompleted: {
        loaded()
    }

    Rectangle {
        id: recipeItemContent
        height: parent.height - 41

        Text {
            height: 20
            width: parent.width
            //text: recipe.title
            color: "#444444"
            font {pointSize: 22; bold: true}
        }
    }

    ActionBar {
        anchors.top: recipeItemContent.bottom
    }
}
