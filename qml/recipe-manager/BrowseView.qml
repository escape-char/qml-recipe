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

   property var categoriesPage: catPage
   property var recipesPage: recPage

   Component.onCompleted: {
       var browseController = new BrowseController.BrowseController(browseView);
       pageStack.push(catPage)
   }
   function goToView(){
       //pageStack.push(viewPage);

   }
   function getQueryModel(){
       return listPage.getQueryModel();
   }

   function update(){
       console.log("BrowseView.update()");
       listPage.update();

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
