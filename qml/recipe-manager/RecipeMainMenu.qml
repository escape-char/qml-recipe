import QtQuick 2.0
import "../CustomWidgets"

MainMenu{
   id: mainMenu
   signal addRecipeButtonClick()
   signal groceriesButtonClick()
   signal browseButtonClick()
   signal settingsButtonClick()

   //add recipes button
    MainMenuItem{
        id: addRecipeButton
        icon: FontAwesome.Icon.PlusSign
        label: "Add Recipe"
        anchors.bottom: middleContainer.top
        backgroundColor: parent.color
        onMainMenuItemClick: addRecipeButtonClick()
    }

   //middle container holding add recipes, groceries
   Rectangle{
       id: middleContainer
        width:parent.width
        height: parent.height * 0.70
        anchors.centerIn: parent
        color: parent.color

        //Groceries menu item
        MainMenuItem {
            id:groceriesButton
            icon: FontAwesome.Icon.ShoppingCart
            label: "Groceries"
            anchors.centerIn:parent
            onMainMenuItemClick:groceriesButtonClick()
            backgroundColor: parent.color
        }
        //Browse Menu Item
        MainMenuItem {
            id:browseButton
            icon: FontAwesome.Icon.Book
            label: "Browse"
            anchors.bottom: groceriesButton.top
            onMainMenuItemClick: browseButtonClick()
            backgroundColor: parent.color
        }

        Rectangle {
            id: border1
            height: 1; width: parent.width;
            color: dividerColor
            anchors.bottom:browseButton.top;
        }

  }
   //settings button
    MainMenuItem {
        id:settingsButton
        icon: FontAwesome.Icon.Cogs
        label: "Settings"
        anchors.top: middleContainer.bottom
        onMainMenuItemClick:settingsButtonClick()
        backgroundColor: parent.color
    }
}
