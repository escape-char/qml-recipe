import QtQuick 2.0
import QtQuick.Controls 1.0
Rectangle{
   id: mainMenu
   width: 80
   color:"black"
   height: parent.height

       //center button container
       Rectangle{
            id: centerButtons
            width:parent.width
            height: parent.height * 0.70
            color: "blue"
            anchors.centerIn: parent
        }
       //add recipe
        Button{
            id:addRecipeBtn
            text: "Add"
            width: parent.width
            height: 70
            anchors.bottom: centerButtons.top
            anchors.bottomMargin: 5

        }
        //settings
        Button{
            id:settingsBtn
            text: "Setting"
            width: parent.width
            height: 70
            anchors.top: centerButtons.bottom
            anchors.bottomMargin: 5

        }
}
