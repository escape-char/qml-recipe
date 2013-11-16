import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "../../js/DatabaseHandler.js" as DatabaseHandler
import "../CustomWidgets"

Item{
   id: browseView

   property int curWidth: parent ? parent.width : 0
   property int curHeight: parent ? parent.height : 0

   height: curHeight
   width: curWidth

   state: "HIDE"
   function refreshCategories(){
         categoryListView.refresh()
         DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)
   }
   function deselectCategories(){
       categoryListView.deselect()
   }
   /*
   function loadRecipeList(){
       recipeListLoader.source = "RecipeList.qml"
    }
    */
   function unloadRecipeList(){
       recipeListLoader.source = ""
    } 
    PageStack {
        id: pageStack
        height: curHeight
        width: curWidth
    }

    RecipeListPage {
        id: listPage
        height: curHeight
        width: curWidth
        onRecipeClicked: {
            pageStack.push(viewPage);
        }


    }

    RecipeViewPage {
        id: viewPage
        height: curHeight
        width: curWidth
        onBackButtonClicked: {
           console.log(pageStack.depth)
           viewPage = pageStack.pop(viewPage);
            console.log(pageStack.depth)
            console.log(pageStack.currentPage.toString())
        }
    }

    Component.onCompleted: {
        console.log("---------------");
        console.log("PUSHED LIST PAGE");
        pageStack.push(listPage);
        console.log("---------------");
    }


}
