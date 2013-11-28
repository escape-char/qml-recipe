import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "../../js/DatabaseHandler.js" as DatabaseHandler
import "../../js/mediator.js" as RecipeMediator
import "../CustomWidgets"
import Widgets 1.0

Item{
    id:appWindow
    height: 600
    width:1024
    visible:true
    property var mediator;

    property var menu: mainMenu;
    property var browse: browseLoader
    property var dialog: dialogLoader

    Component.onCompleted: {
        mediator = new RecipeMediator.Mediator(appWindow);
        appWindow.state  = "BROWSE"

    }


    RecipeMainMenu{
       id: mainMenu
       /*
       onAddRecipeButtonClick: {
           console.log("AppWindow: clicked add recipe")
           if(browseLoader.status === Loader.Ready){
               //browseLoader.item.unloadRecipeList()
            }
           appWindow.state = "ADD-RECIPE"
       }
       */
    }

    //browse area loader
    Loader{
        id:browseLoader
         height: parent.height
         width: parent.width - mainMenu.width
         anchors{left:mainMenu.right; top: mainMenu.top}

    }
    //loads dialogs
    Loader{
        id:dialogLoader
        width: parent.width - mainMenu.width
        anchors.left: mainMenu.right
        height: parent.height
    }

    states: [
        //browse state
        State{
            name: "BROWSE"
        }        ,
        State{
            name:"DIALOG"
        },
        State{
            name:"GROCERY"
        }
    ]
    /*
    //connection with dialogLoader
    Connections{
        ignoreUnknownSignals: true
        target: dialogLoader.status === Loader.Ready ? dialogLoader.item : null
        onCancelClick: {
            console.log("APPWINDOW:DIALOGLOADER:onCancelClick()")
            dialogLoader.item.state = "HIDE"
        }
        onSaveRecipe:{
            console.log("APPWINDOW:DIALOGLOADER:onSubmitClick()")
            var tableModel = Qt.createQmlObject("import QtQuick 2.0; import Widgets 1.0; SqlTableModel{}",
                                                dialogLoader, "./");
           DatabaseHandler.addRecipeToTableModel(tableModel, r)
        }
        onExitClick:{
            console.log("APPWINDOW:DIALOGLOADER:onSubmitClick()")
        }
        onStateChanged:{
            if(dialogLoader.item.state === "HIDE"){
                dialogLoader.source=""
                appWindow.state = "BROWSE"
            }
        }
    }
    //connection with browseload
    Connections{
        ignoreUnknownSignals: true
        target: browseLoader.status === Loader.Ready ? browseLoader.item : null
        onStateChanged:{
        }
     }
     */
}
