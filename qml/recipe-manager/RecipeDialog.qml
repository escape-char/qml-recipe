import QtQuick 2.0
import QtQuick.Controls 1.0
import Widgets 1.0
import "../CustomWidgets"

Dialog {
    id: recipeDialog
    clip: true
    anchors.fill: parent
    contentHeight: 700
    contentWidth: 550
    objectName: "RecipeDialog"


    property int labelPadding: 5
    property int leftMargin: 20
    property int topMargin: 15
    property int fontSize: 14
    property int inputWidth: 350
    property int labelWidth: 40
    property int inputHeight: 20
    property color labelColor: "#888"

    signal saveRecipe(variant r)


    //holds recipe data
    property var recipe: {
        "title": "",
         "categories": [],
         "ingredients": [],
         "directions": [],
        "description":"",
        "image": "",
        "duration": "0:0",
        "difficulty": 0,
        "rating": 0
    }

    Grid {
        id:mainGrid
        columns: 2
        columnSpacing: 90
        rowSpacing: 18
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: leftMargin
        anchors.topMargin: topMargin

        //title label
        Text{
            width: labelWidth
            height: 10
            text: "Title"
            color: labelColor
            font{bold: false;pointSize: 12}
        }
        //title field
        TextField{
            id:titletField
            placeholderText: "Enter a title"
            width: inputWidth
            height: 30
            text: recipe.title
            maximumLength: 100
        }

        //Rating label
        Text{
            width: labelWidth
            height: 20
            text: "Rating"
            color: labelColor

            font{bold: false; pointSize: 12}
        }
        Rating{
            id: rating
            width: 205
            height: 40
            fillColor: "gold"
            selected:  recipe.rating
            size:15
        }
        //categorylabel
        Text{
            width: labelWidth
            height: 50
            text: "Categories"
            color: labelColor

            font{bold: false; pointSize: 12}
        }
        //category field
        TextArea{
            id: categoryField
            width: inputWidth
            height: 30
            text: recipe.categories.toString()
        }

        //description label
        Text{
            width: labelWidth
            height: 50
            text: "Description"
            color: labelColor

            font{pointSize: 12}
        }
        //description field
        TextArea{
            id: descrField
            width: inputWidth
            height: 100
            text: recipe.description
        }
    }

    Item{
        id: imageSection
        anchors.top:mainGrid.bottom
        anchors.left:mainGrid.left
        width:parent.width
        height: 50

        anchors.topMargin: 40
        //image label
        Text{
            id:imageLabel
            width: labelWidth + 90
            height: 50
            text: "Image"
            color: labelColor

            font{pointSize: 12}
        }
        //image field
        TextField{
            id:imageField
            placeholderText: "Choose an image"
            anchors.left:imageLabel.right
            anchors.top: imageLabel.top
            width: 250
            height: 30
            text: recipe.image
            maximumLength: 50
        }
        CustomButton{
            id:imageButton
            anchors.left:imageField.right
            anchors.top: imageField.top
            height: imageField.height - 2
            label: "Browse..."
            width: 70
        }

    }
    Rectangle{
        id:divider1
        height: 1
        width: contentWidth
        visible:true
        anchors{top:imageSection.bottom; left:imageSection.left}
        color: "#ccc"
    }


    Grid{
       id: grid2
        columns: 2
        columnSpacing: contentWidth /4
        anchors.top: divider1.bottom
        anchors.left: divider1.left
        anchors.margins: 20

        //difficulty  label
        Text{
            id:difficultyLabel
            width: labelWidth
            height: 30
            text: "Difficulty"
            color: labelColor

            font{pointSize: 12}
        }
        //Duration Label
        Text{
            id:durationLabel
            width: labelWidth
            height: 30
            text: "Duration"
            color: labelColor

            font{pointSize: 12}
        }

        //difficulty combobox
        ComboBox{
            id:diffCombo
            //model:["None", "Easy", "Medium", "Hard"]
            width:100
            //currentIndex: recipe.rating
        }

        Item{
            height: 30
            width: contentWidth
            //hr spinner
            SpinBox{
                id: hourSpin
                decimals: 0
                maximumValue: 99
                suffix: "hr"
                value: parseInt(recipe.duration.split(":")[0])

            }
            SpinBox{
                id:minuteSpin
                anchors{left:hourSpin.right; top:hourSpin.top}
                decimals:0
                suffix: "min"
                maximumValue: 59
                value: parseInt(recipe.duration.split(":")[1])
            }
        }
    }

    Rectangle{
        id:divider2
        height: 2
        width: contentWidth
        visible:true
        anchors{top:grid2.bottom; left:parent.left}
        anchors.topMargin: 20

        color:"lightgray"
    }

    Grid{
        id: grid3
        columns: 2
        columnSpacing: contentWidth /4
        anchors.top: divider2.bottom
        anchors.left: divider2.left
        anchors.margins: 20

        //ingredients  label
        Text{
            id:ingredientsLabel
            width: labelWidth
            height: 30
            text: "Ingredients"
            color: labelColor

            font{pointSize: 12}
        }

        //Directions Label
        Text{
            id:directionsLabel
            width: labelWidth
            height: 30
            text: "Directions"
            color: labelColor

            font {pointSize: 12}
        }
        AddItemView{
            id: ingredList
            height: 200
            items: recipe.ingredients

        }
        AddItemView{
            id: dirlist
            height: 200
            items: recipe.directions
        }
    }

    onSubmitClick: {
        recipe.title = titletField.text
        recipe.rating = rating.selected
        recipe.categories=categoryField.text.split(",")
        recipe.description = descrField.text
        recipe.image = imageField.text
        recipe.directions = dirlist.items
        recipe.ingredients = ingredList.items
        recipe.duration =  hourSpin.value + ":" + minuteSpin.value
        recipe.difficulty= diffCombo.currentIndex

        saveRecipe(recipe)
    }

}
