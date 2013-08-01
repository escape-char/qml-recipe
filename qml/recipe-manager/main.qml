import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

ApplicationWindow{
    id: appWindow
    width:1024
    height:680
    visible: true
    Dialog{id: addRecipeDialog}

    MainMenu{
        id: mainMenu
        onAddRecipeButtonClick: addRecipeDialog.show()
    }

    BrowseView{}
}
