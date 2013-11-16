import QtQuick 2.0
import "../CustomWidgets"
Page {
    id: itemList
    width: parent.width
    height: parent.height

    signal recipeClicked

    onRecipeClicked: {}

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
            Component.onCompleted: {
                recipeList.recipeClicked.connect(itemList.recipeClicked)
            }

            anchors {top: parent.top; left: categoryListView.right}
        }


    }

}
