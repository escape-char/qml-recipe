import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "../../js/DatabaseHandler.js" as DatabaseHandler

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
