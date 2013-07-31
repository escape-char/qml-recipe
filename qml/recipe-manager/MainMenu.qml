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
        id: centerButtons
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

        MainMenuItem {
            icon: FontAwesome.Icon.Book
            label: "Browse"
            anchors.top: border1.bottom
        }
  }
}
