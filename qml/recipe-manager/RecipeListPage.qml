import QtQuick 2.0

Page {
    id: itemlist
    width: parent.width
    height: parent.height
    Rectangle {
        anchors.fill: parent

        CategoryList{
            id: categoryListView
            /*onCategorySelected:{
                DatabaseHandler.updateRecipeModelByCategory(recipeModel, category.id)
            }
            onAllClick: {
                //update recipe model to select all categories
                DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
                categoryListView.deselect()
            }*/
            anchors {top: parent.top; left: parent.left}
        }
        RecipeList {
            id: recipeList
            height: parent.height
            width: parent.width - categoryListView.width
            anchors {top: parent.top; left: categoryListView.right}
        }


    }

}
