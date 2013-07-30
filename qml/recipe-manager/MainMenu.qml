import QtQuick 2.0
Rectangle{
   id: mainMenu
   width: 70
   color:"#444"
   height: parent.height

   signal recipeBtnClick()

      //filler container for middle buttons
       Rectangle{
            id: centerButtons
            width:parent.width
            height: parent.height * 0.70
            anchors.centerIn: parent
            color: parent.color


            //groceries button
            CustomButton{
                width: parent.width
                label: "Groceries"
                id: groceriesButton
                border.width: 0
                anchors.top: browseButton.bottom
                anchors.centerIn: parent
            }
            //browse button
            CustomButton{
                width: parent.width
                label:"Browse"
                id: browseButton
                border.width: 0
                anchors.bottom: groceriesButton.top
            }
           CustomButton{
                width: parent.width
                label:"Search"
                id: searchButton
                border.width: 0
                anchors.top: groceriesButton.bottom
            }
     }
   //add recipe
    CustomButton{
        id:addRecipeBtn
        label: "Add"
        width: parent.width
        height: 70
        anchors.bottom: centerButtons.top
        anchors.bottomMargin: 5
    }
    //settings
    CustomButton{
        id:settingsBtn
        label: "Setting"
        width: parent.width
        height: 70
        anchors.top: centerButtons.bottom
        anchors.bottomMargin: 5
    }
}
