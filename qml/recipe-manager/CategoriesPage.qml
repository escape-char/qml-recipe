import QtQuick 2.0
import "../CustomWidgets"
Page {
    id: itemlist
    width: parent.width
    height: parent.height

    signal categoryChosen(variant category)

    function update(){
        recipeList.update();
        categoryListView.update();
    }
    function getQueryModel(){
        return recipeList.queryModel;
    }


    Rectangle {
        anchors.fill: parent

        CategoryList{
            id: categoryListView

            onCategorySelect:{
                console.log("RecipeListPage.onCategorySelect()");
                console.log("RecipeListPage.onCategorySelect(): filter by category id: " + category.id);

               categoryChosen(category);
            }
           // onAllClick: {
                //update recipe model to select all categories
            //    DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
            //    categoryListView.deselect()
            //}

            anchors {top: parent.top; left: parent.left}
        }
        RecipeListDetailed {
            id: recipeList
            height: parent.height
            width: parent.width - categoryListView.width
            anchors {top: parent.top; left: categoryListView.right}
        }

    }

}
