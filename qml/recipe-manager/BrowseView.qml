import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "DatabaseHandler.js" as DatabaseHandler

Item{
   id: browseView
   height: parent ? parent.height : 500
   width: parent ? parent.width : 500
   state: "HIDE"
   function refreshCategories(){
         categoryListView.refresh()
         DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
   }
   function deselectCategories(){
       categoryListView.deselect()
   }
   function loadRecipeList(){
       recipeListLoader.source = "RecipeList.qml"
    }
   function unloadRecipeList(){
       recipeListLoader.source = ""
    }

   //list of categories
    CategoryList{
        id: categoryListView
        onCategorySelected:{
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, category.id)
        }
        onAllClick: {
            //update recipe model to select all categories
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
            categoryListView.deselect()
        }
        anchors{left: parent.left; top:parent.top}
    }
    //load recipeList dynamically
    Loader{
        id: recipeListLoader
        anchors{left:categoryListView.right; top:categoryListView.top}
        width:400
        height: parent.height


        onStatusChanged: {
           if(recipeListLoader.status === Loader.Null)
               console.log("recipeListLoader.onStatusChanged(): state is currently null")
           else if (recipeListLoader.status ===- Loader.Error)
               console.log("recipeListLoader.onStatusChanged(): error occurred during load")
           else if (recipeListLoader.status === Loader.Loading)
               console.log("recipeListLoader.onStatusChanged(): loading componenet... " +
                           recipeListLoader.progress*100 + "%.")
           else
               console.log("recipeListLoader.onStatusChanged(): successfully loaded component")
        }

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
            PropertyChanges {target:browseView; opacity: 1 }
        },
        State {
            name: "HIDE"
            PropertyChanges{target:browseView; opacity: 0}
        }
    ]
    transitions:[
        Transition{
           from:"HIDE"; to:"SHOW"
           NumberAnimation{target: browseView; property: "opacity"; duration: 600}
        }


    ]
    onStateChanged: {
        console.log("BROWSEVIEW.onStateChange(): state is " + browseView.state);
    }
}
