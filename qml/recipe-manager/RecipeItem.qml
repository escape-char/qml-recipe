import QtQuick 2.0
import "../CustomWidgets"

Rectangle {
    id: recipeItem
    height: parent.height
    width: parent.width
    color: "#ffffff"


    //holds data for recipe
    property variant recipe

    Rectangle {
        height: parent.height;
        width: 1
        color: "#ccc"
        anchors {top: parent.top; left: parent.left}
    }

    signal loaded()

    Component.onCompleted: {
        loaded()
    }

    ActionBar {
        id: topBar
        anchors.top: recipeItemContent.top
    }

    Rectangle {
        id: recipeItemContent
        height: parent.height - topBar*2

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
