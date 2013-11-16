import QtQuick 2.0

Rectangle{
   id: mainMenu
   width: 70
   height: parent.height
   color: "black"

   property color dividerColor: "#2B2B2B"

   //Right Border
   Rectangle {
       height: parent.height; width: 1
       anchors.left: parent.right
       color: "#CFCFCF"
   }
}
