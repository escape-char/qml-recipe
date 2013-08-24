import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "DatabaseHandler.js" as DatabaseHandler

Item{
   height: parent.height
   width: parent.width
   function refreshCategories(){
         categoryListView.refresh()
         DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
   }
   function deselectCategories(){
       categoryListView.deselect()
   }


    CategoryList{
        id: categoryListView
        onCategorySelected:{
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, category.id)
        }
        onAllClick: {
            //update recipe model to select all categories
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
        }
        anchors{left: parent.left; top:parent.top}
    }

    RecipeList{
            id:recipeList
            anchors{left:categoryListView.right; top:categoryListView.top}
    }
    /*
    //right pane
    //view recipe
    Rectangle{
        id: recipePane
        signal recipeChanged()
        color: "red"
        height:parent.height
        width: 100

        RecipeItem {
            id: recipeItem
            onLoaded: {
                recipeItem.recipe = recipePane.currentRecipe
            }
        }
       // onCurrentRecipeChanged: {
           // recipeItem.recipe = recipePane.currentRecipe
        //}
    }
*/

    states: [
        State {
            name: "SHOW"
            PropertyChanges {
            }
        },
        State {
            name: "HIDE"
            PropertyChanges {
            }
        }
    ]
}
