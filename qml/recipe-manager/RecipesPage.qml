import QtQuick 2.0
import "../CustomWidgets"

Page {
    id: itemList
    property int curWidth: parent ? parent.width : 0
    property int curHeight: parent ? parent.width : 0

    width: curWidth
    height: curHeight

    signal backButtonClicked

    RecipeListCompact{
        id:recipeList
        anchors{top:parent.top; left:parent.left}

        onBackButtonClicked: itemList.backButtonClicked()
    }

    RecipeItem{
        id: recipeItem
        width: curWidth - recipeList.width
        height: curHeight

        /*onCategorySelected:{
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, category.id)
        }
        onAllClick: {
            //update recipe model to select all categories
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
            categoryListView.deselect()
        } */
        anchors {top: parent.top; left: recipeList.right}

    }
}
