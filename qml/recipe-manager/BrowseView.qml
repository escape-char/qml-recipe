import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "../../js/DatabaseHandler.js" as DatabaseHandler
import "../CustomWidgets"

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
}
