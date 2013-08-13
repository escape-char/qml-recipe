import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

SplitView{
    height: parent.height
    width: parent.width
    resizing:true

    Rectangle{
        Layout.minimumWidth:150
        Layout.maximumWidth:200
        CategoryList{

        }
    }
    Rectangle{
        Layout.minimumWidth:300
        Layout.maximumWidth:400
        RecipeList{
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
    states: [
        State {
            name: "SHOW"
            PropertyChanges {
                target: mainSplitView
            }
        },
        State {
            name: "HIDE"
            PropertyChanges {
            }
        }
    ]

}
