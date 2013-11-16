import QtQuick 2.0


Page {
    id: itemlist
    width: parent.width
    height: parent.height

    RecipeListCompact{
        id: recipeList
        width: 300
        anchors {top: parent.top; left: parent.left}
    }

    RecipeItem{
        id: recipeItem
        width: parent.width - recipeList.width
        /*onCategorySelected:{
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, category.id)
        }
        onAllClick: {
            //update recipe model to select all categories
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
            categoryListView.deselect()
        }*/
        anchors {top: parent.top; left: recipeList.right}

    }
}
