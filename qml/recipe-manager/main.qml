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
    SplitView{
        id: mainSplitView
        height:parent.height
        width: parent.width - mainMenu.width
        anchors.left: mainMenu.right
        visible:true
        resizing: true
        orientation: Qt.Horizontal

        //categories pane
        Rectangle{
            height: parent.height
            width: 145
            //Layout.minimumWidth: 150
            //Layout.maximumWidth: 200
            CategoryPanel{}
        }
        //Recipes List pane
        Rectangle{
            id: recipeListPane

            height:parent.height
            width: 320
            Layout.minimumWidth:200
            Layout.maximumWidth:620
            RecipeList {
                id: recipeList
                onLoaded: {
                    recipePane.currentRecipe = recipeList.currentRecipe
                }
                onItemClicked: {
                    recipePane.currentRecipe = recipeList.currentRecipe
                }
            }
        }
        //Recipe View panel
        Rectangle{
            id: recipePane

            property variant currentRecipe

            signal recipeChanged()

            color: "lightgray"
            height:parent.height;
            Layout.minimumWidth: 300
            Layout.fillWidth: true



            RecipeItem {
                id: recipeItem
                onLoaded: {
                    recipeItem.recipe = recipePane.currentRecipe
                }
            }

            onCurrentRecipeChanged: {
                recipeItem.recipe = recipePane.currentRecipe
            }
        }
    }
}
