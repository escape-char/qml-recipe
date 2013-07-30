import QtQuick 2.0
Rectangle{
   id: mainMenu
   width: 80
   color:"black"
   height: parent.height
   signal recipeBtnClick()

      //filler container for middle buttons
       Rectangle{
            id: centerButtons
            width:parent.width
            height: parent.height * 0.70
            color: "black"
            anchors.centerIn: parent


            //groceries button
            Button{
                width: parent.width
                label: "Groceries"
                id: groceriesButton
                color: "black"
                border.width: 0
                anchors.top: browseButton.bottom
                anchors.centerIn: parent
            }
        //browse button
            Button{
                width: parent.width
                label:"Browse"
                id: browseButton
                color: "black"
                border.width: 0
                anchors.bottom: groceriesButton.top
            }
            //Search button
           Button{
                width: parent.width
                label:"Search"
                id: searchButton
                color: "black"
                border.width: 0
                anchors.top: groceriesButton.bottom
            }
     }
   //add recipe
    Button{
        id:addRecipeBtn
        label: "Add"
        defaultColor: "black"
        width: parent.width
        height: 70
        anchors.bottom: centerButtons.top
        anchors.bottomMargin: 5
        onButtonClick: recipeBtnClick()
    }
    //settings
    Button{
        id:settingsBtn
        label: "Setting"
        defaultColor: "black"
        width: parent.width
        height: 70
        anchors.top: centerButtons.bottom
        anchors.bottomMargin: 5
    }
}
