import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "js/DatabaseHandler.js" as DatabaseHandler

Item{
   id: browseView
   height: parent ? parent.height : 500
   width: parent ? parent.width : 500
   state: "HIDE"

   /*function refreshCategories(){
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
    } */

    PageStack {
        id: pageStack
        height: parent.height
        width: parent.width
    }

    RecipeListPage {
        id: listPage
    }

    RecipeViewPage {
        id: viewPage
    }

    Component.onCompleted: {
        pageStack.push(listPage)
    }


    MouseArea {
        id: mousearea
        anchors.fill: parent
        onClicked: {
            pageStack.push(viewPage)
        }
    }



   //list of categories
    /*CategoryList{
        id: categoryListView
        onCategorySelected:{
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, category.id)
        }
        onAllClick: {
            //update recipe model to select all categories
            DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
            categoryListView.deselect()
        }

    }*/


    //load recipeList dynamically
    /*Loader{
        id: recipeListLoader
        anchors{left: parent.left; top:parent.top}
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

    }*/
    //right pane
    //view recipe
    /*Rectangle{
        id: recipePane
        signal recipeChanged()
        color: "red"
        height:parent.height
        width: parent.width - recipeList.width

        anchors {
            top:parent.top; left: recipeList.right;
        }

        RecipeItem {
            id: recipeItem
            onLoaded: {
                recipeItem.recipe = recipePane.currentRecipe
            }
        }
       // onCurrentRecipeChanged: {
           // recipeItem.recipe = recipePane.currentRecipe
        //}
    } */

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
           NumberAnimation{target: browseView; property: "opacity"; duration: 0}
        }


    ]
    onStateChanged: {
        console.log("BROWSEVIEW.onStateChange(): state is " + browseView.state);
    }
}
