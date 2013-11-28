import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "../../js/DatabaseHandler.js" as DatabaseHandler
import "../CustomWidgets"

Item{
   id: browseView
   height: parent ? parent.height : 500
   width: parent ? parent.width : 500
   objectName: "Browse"
   state: "HIDE"

   signal chosenCategory();

   function goToView(){
       //pageStack.push(viewPage);

   }
    PageStack {
        id: pageStack
        height: parent.height
        width: parent.width
    }

    RecipeListPage {
        id: listPage
       onCategoryChosen: {
           console.log("BrowseView.onCategorySelect()");


           /*

           //create table Model dynamically
           var tableModel = Qt.createQmlObject(
                       "import QtQuick 2.0; import Widgets 1.0; SqlQueryModel{}",
                        browseView,
                       "./");
           console.log("BrowseView.onCategorySelect(): filter by category id: " + category.id);
           //Data
           DatabaseHandler.filterByCategory(tableModel, category.id);
           listPage.update()
           //goToView()
           */
       }
    }

    RecipeViewPage {
        id: viewPage
    }

    Component.onCompleted: {
        pageStack.push(listPage)
        listPage.categoryChosen.connect(chosenCategory);
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
