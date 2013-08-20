import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

ApplicationWindow{
    width:1024
    height:680
    visible: true

 //Controller for states
  Item{
        id: appWindow
        width:parent.width
        height:parent.height
        anchors.fill:parent

       MainMenu{
          id: mainMenu
       }

       BrowseView{
            id: recipeBrowseView
            height:parent.height
            width:parent.width- mainMenu.width
            anchors.left: mainMenu.right
            anchors.top: mainMenu.top
        }
        states: [
            //Add Recipe State
            State {
                name: "ADD_RECIPE"
                PropertyChanges {target: addRecipeDialog;state:"SHOW"}
            },
            //Browse Recipes State
            State{
                name:"BROWSE"
                PropertyChanges {target:recipeBrowseView; state: "SHOW"}
            },
          //Groceries State
          State{
                name: "GROCERIES"
           },
          //Settings State
          State{
                name: "SETTINGS"
          }
        ]
  }
}
