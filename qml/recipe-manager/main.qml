import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

ApplicationWindow{
    width:1024
    height:680
    visible: true
//need rectangle in order to use states
  Rectangle{
        id: appWindow
        width:parent.width
        height:parent.height
        anchors.fill:parent

       Dialog{id:addRecipeDialog}
       MainMenu{
          id: mainMenu
          onAddRecipeButtonClick: { appWindow.state = "ADD_RECIPE"}
          onGroceriesButtonClick: {appWindow.state = "GROCERIES"}
          onBrowseButtonClick: {appWindow.state = "BROWSE"}
          onSettingsButtonClick:{appWindow.state = "SETTINGS"}
       }
       BrowseView{
            id: recipeBrowseView
            width:parent.width - mainMenu.width
            anchors.left: mainMenu.right
        }
       GroceriesView{
         id: groceriesView
         width: parent.width - mainMenu.width
         anchors.left: mainMenu.right
        }
       SettingsView{
           id:settingsView
        }

        states: [
            State {
                name: "ADD_RECIPE"
                PropertyChanges {target: addRecipeDialog;state:"SHOW"}
            },
            State{
                name:"BROWSE"
                PropertyChanges {target:recipeBrowseView; state: "SHOW"}
                PropertyChanges {target: groceriesView;state:"HIDE"}
            },
          State{
                name: "GROCERIES"
                PropertyChanges {target: groceriesView;state:"SHOW"}
                PropertyChanges {target:recipeBrowseView; state:"HIDE"}
                PropertyChanges {target:recipeBrowseView; state:"HIDE"}
           },
          State{
                name: "SETTINGS"
                PropertyChanges {target: settingsView;state:"SHOW"}
        }
        ]
  }
}
