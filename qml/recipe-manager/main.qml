import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "DatabaseHandler.js" as DatabaseHandler
import Widgets 1.0

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
        }
       else
           console.log("APPWINDOW.addRecipeToDb(): BrowseLoader is not READY. Unable to refresh")
       DatabaseHandler.updateRecipeModelByCategory(recipeModel, -1)

    }

 //Controller for states
  Item{
        id: appWindow
        width:parent.width
        height:parent.height
        anchors.fill:parent

        Component.onCompleted: {
            state = "BROWSE"
        }
        onStateChanged: {
            console.log("APPWINDOW.onStateChanged: state is " + appWindow.state)
        }

       MainMenu{
          id: mainMenu
          onAddRecipeButtonClick: {
              if(browseLoader.status === Loader.Ready){
                  //browseLoader.item.unloadRecipeList()
               }
              appWindow.state = "ADD-RECIPE"
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
               else{
                   console.log("browseLoader.onStatusChanged(): successfully loaded component")
                   browseLoader.item.state = "SHOW"
                    browseLoader.item.refreshCategories()
                   browseLoader.item.deselectCategories()
                   browseLoader.item.loadRecipeList()
                }
            }
       }
       //loads dialogs
       Loader{
           id:dialogLoader
            height: parent.height
            width: parent.width
           anchors{left:mainMenu.right; top: mainMenu.top}
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
                   dialogLoader.state = "SHOW"
                }
            }
           onLoaded: {
              console.log("dialogLoader.onLoaded()")
              dialogLoader.item.state = "SHOW"
            }
       }
        states: [
            //browse state
            State{
                name: "BROWSE"
                PropertyChanges{target: browseLoader;asynchronous: true; source:"BrowseView.qml"}
            },
            State{
                name:"ADD-RECIPE"
                PropertyChanges{target: dialogLoader; asynchronous: true;  source:"AddRecipeDialog.qml"}
            }
        ]
    }
    Timer{
        id:browseTimer
        interval: 650
        repeat: false
        running: false
        onTriggered: {
            console.log("triggered browse timer")
            appWindow.state = "BROWSE"
        }


    }
    Connections{
        ignoreUnknownSignals: true
        target: dialogLoader.status === Loader.Ready ? dialogLoader.item : null
        onCancelButtonClick: {
            dialogLoader.item.state = "HIDE"
        }
        onAddRecipeButtonClick:{
            addRecipeToDb(data)
            dialogLoader.item.state = "HIDE"
        }
        onStateChanged:{
            if(dialogLoader.item.state === "HIDE"){
                browseTimer.start()
            }
        }
    }
}
