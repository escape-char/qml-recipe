import QtQuick 2.0
import "fontawesome.js" as FontAwesome

Rectangle{
   id: mainMenu
   width: 70
   color:"#333333"
   height: parent.height
   signal addRecipeButtonClick()

   property string dividerColor: "#2B2B2B"

   //add recipes button
    MainMenuItem{
        id: addRecipeButton
        icon: FontAwesome.Icon.PlusSign
        label: "Add Recipe"
        isActive: false
        anchors.bottom: middleButtonsContainer.top
        onMainMenuItemClick: addRecipeButtonClick()
    }

  //filler container for middle buttons
   Rectangle{
       id: middleButtonsContainer
        width:parent.width
        height: parent.height * 0.70
        anchors.centerIn:parent
        color: parent.color

        Rectangle {
            id: border1
            height: 1; width: parent.width;
            color: dividerColor
            anchors.top: parent.top
        }

        //Browse Menu Item
        MainMenuItem {
            icon: FontAwesome.Icon.Book
            label: "Browse"
            isActive: true
            anchors.top: border1.bottom
        }
  }
   //Right Border
   Rectangle {
       height: parent.height; width: 1
       anchors.left: parent.right
       color: "#CFCFCF"
   }
}
