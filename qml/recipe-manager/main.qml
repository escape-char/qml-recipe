import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

ApplicationWindow{
    width:900
    height:600
    visible: true

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
               if(dialogLoader.status === Loader.Null)
                   console.log("dialogLoader.onStatusChanged(): state is currently null")
               else if (dialogLoader.status ===- Loader.Error)
                   console.log("dialogLoader.onStatusChanged(): error occurred during load")
               else if (dialogLoader.status === Loader.Loading)
                   console.log("dialogLoader.onStatusChanged(): loading componenet... " +
                               dialogLoader.progress*100 + "%.")
               else
                   console.log("dialogLoader.onStatusChanged(): successfully loaded component")
            }
           onLoaded: {
              console.log("dialogLoader.onLoaded()")
              dialogLoader.item.state = "SHOW"
            }
       }
    }

}
