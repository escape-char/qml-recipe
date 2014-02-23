import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "../../js/DatabaseHandler.js" as DatabaseHandler
import "../../js/BrowseController.js" as BrowseController

import "../CustomWidgets"

Item{
   id: browseView
   height: parent ? parent.height : 500
   width: 300
   objectName: "Browse"
   state: "HIDE"

   signal chosenCategory(variant category);

   property var browseController
   property var categoriesPage: catPage
   property var recipesPage: recPage

   Component.onCompleted: {
       browseController = new BrowseController.BrowseController(browseView);
       pageStack.push(catPage)
   }
   function push(p){
       console.log("go to recipe page")
       pageStack.push(p);

   }
   function pop(){
       pageStack.pop();
   }

   function getRecipeQueryModel(){
       return browseController.recipeQueryModel();
   }
   function getCategoryQueryModel(){
       return browseController.categoryQueryModel();
   }

    PageStack {id: pageStack; height: parent.height;width: parent.width}

    CategoriesPage {
        id: catPage
        anchors.fill:parent
    }

    RecipesPage {
        id: recPage
        anchors.fill:parent
    }

    states: [
        State {
            name: "LIST"
        },
        State{
            name: "VIEW"
        }

    ]
}
