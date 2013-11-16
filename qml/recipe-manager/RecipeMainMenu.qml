import QtQuick 2.0
import "../../js/fontawesome.js" as FontAwesome
import "../CustomWidgets"

MainMenu{
   id: mainMenu
   width: 65
   height: parent.height
   color: "#91353B"
   z: 1
   signal addRecipeButtonClick()
   signal groceriesButtonClick()
   signal browseButtonClick()
   signal settingsButtonClick()

   property string dividerColor: "#732A2F"

   //add recipe button
    MainMenuButton{
        id: addRecipeButton
        icon: FontAwesome.Icon.PlusSign
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        onMainMenuItemClick: addRecipeButtonClick()
    }

   //middle container holding add recipes, groceries
   Rectangle{
        id: middleContainer
        width:  parent.width
        height: parent.height - 60
        color: parent.color
        anchors.top: addRecipeButton.bottom
        anchors.topMargin: 40

        //Browse Menu Item
        MainMenuItem {
            id:browseButton
            icon: FontAwesome.Icon.Book
            isActive: true;
            anchors.top: parent.top
            onMainMenuItemClick: browseButtonClick()
        }

        Rectangle {
            id: border1
            height: 1; width: parent.width;
            color: dividerColor
            anchors.top:browseButton.top;
        }

        //Groceries menu item
        MainMenuItem {
            id:groceriesButton
            icon: FontAwesome.Icon.ShoppingCart
            anchors.top:  browseButton.bottom
            onMainMenuItemClick:groceriesButtonClick()

        }

        Rectangle {
            id: border2
            height: 1; width: parent.width;
            color: dividerColor
            anchors.top:groceriesButton.top;
        }

        Rectangle {
            id: border3
            height: 1; width: parent.width;
            color: dividerColor
            anchors.bottom:groceriesButton.bottom;
        }

  }
   //settings button
    MainMenuButton {
        id:settingsButton
        icon: FontAwesome.Icon.Cog
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        onMainMenuItemClick:settingsButtonClick()
    }
}
