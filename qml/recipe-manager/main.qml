import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "DatabaseHandler.js" as DatabaseHandler

ApplicationWindow{
    width:900
    height:600
    visible: true

   function addRecipeToDb(recipe) {
       console.log("APPWINDOW.addRecipeToDb:adding recipe '" + recipe.title + "' to database")
       //add recipe to database
       DatabaseHandler.addRecipeToTableModel(tableModel, recipe)

       if(browseLoader.status == Loader.Ready){
           console.log("APPWINDOW.addRecipeToDb(): refreshing browse view")
            browseLoader.item.refreshCategories()
           browseLoader.item.deselectCategories()
        }
       else
           console.log("APPWINDOW.addRecipeToDb(): BrowseLoader is not READY. Unable to refresh")
       DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)

    }
   function cancelDialog(){
        console.log("DIALOGLOADER: Canceling Dialog Window")

        //nothing to cancel; dialog hasn't been loaded
        if(dialogLoader.status !== Loader.Ready)
            return;

        dialogLoader.item.state = "HIDE"
        dialogLoader.source = "" //unloaded component from loader
    }
 //Controller for states
  Item{
        id: appWindow
        width:parent.width
        height:parent.height
        anchors.fill:parent

        Component.onCompleted: {
            browseLoader.asynchronous = true
            browseLoader.source = "BrowseView.qml"
        }

       MainMenu{
          id: mainMenu
          onAddRecipeButtonClick: {
              dialogLoader.asynchronous = true
              dialogLoader.source = "AddRecipeDialog.qml"
          }
       }
       //browse area loader
       Loader{
           id:browseLoader
            height: parent.height
            width: parent.width - mainMenu.width
            anchors{left:mainMenu.right; top: mainMenu.top}
           onStatusChanged: {
               if(browseLoader.status === Loader.Null)
                   console.log("browseLoader.onStatusChanged(): state is currently null")
               else if (browseLoader.status ===- Loader.Error)
                   console.log("browseLoader.onStatusChanged(): error occurred during load")
               else if (browseLoader.status === Loader.Loading)
                   console.log("browseLoader.onStatusChanged(): loading componenet... " +
                               browseLoader.progress*100 + "%.")
               else
                   console.log("browseLoader.onStatusChanged(): successfully loaded component")
            }
       }
       //loads dialogs
       Loader{
           id:dialogLoader
            height: parent.height
            width: parent.width
            anchors{left:mainMenu.right; top: mainMenu.top}
            opacity: 1
           onStatusChanged: {
               if(dialogLoader.status === Loader.Null){
                   console.log("dialogLoader.onStatusChanged(): state is currently null")
                }
               else if (dialogLoader.status ===- Loader.Error)
                   console.log("dialogLoader.onStatusChanged(): error occurred during load")
               else if (dialogLoader.status === Loader.Loading){
                   console.log("dialogLoader.onStatusChanged(): loading componenet... " +
                               dialogLoader.progress*100 + "%.")
                }
               else{
                   console.log("dialogLoader.onStatusChanged(): successfully loaded component")
                }
            }
           onLoaded: {
              console.log("dialogLoader.onLoaded()")
              dialogLoader.item.state = "SHOW"
            }
       }
    }
    Connections{
        ignoreUnknownSignals: true
        target: dialogLoader.status === Loader.Ready ? dialogLoader.item : null
        onCancelButtonClick: cancelDialog()
        onAddRecipeButtonClick:{
            addRecipeToDb(data)
        }
    }
}
