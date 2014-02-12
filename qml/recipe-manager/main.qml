import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "../../js/DatabaseHandler.js" as DatabaseHandler
import "../../js/mediator.js" as RecipeMediator
import "../CustomWidgets"
import Widgets 1.0

Item{
    id:appWindow
    height: 750
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

}
