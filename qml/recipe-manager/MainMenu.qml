import QtQuick 2.0
import "fontawesome.js" as FontAwesome

Rectangle{
   id: mainMenu
   width: 70
   color:"#333333"
   height: parent.height

   property string dividerColor: "#2B2B2B"
   signal recipeBtnClick()

  //filler container for middle buttons
   Rectangle{
        width:parent.width
        height: parent.height * 0.70
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
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
