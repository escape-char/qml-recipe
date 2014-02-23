import QtQuick 2.0
import "../CustomWidgets"

Page {
    id: itemList
    property int curWidth: parent ? parent.width : 0
    property int curHeight: parent ? parent.width : 0

    width: curWidth
    height: curHeight
    property variant recipeListView: recipeList
    property variant recipeView: recipeItem

    RecipeListCompact{
        id:recipeList
        anchors{top:parent.top; left:parent.left}
    }

    RecipeItem{
        id: recipeItem
        width: curWidth - recipeList.width
        height: curHeight
        anchors {top: parent.top; left: recipeList.right}

    }
}
