import QtQuick 2.0
import QtQuick.Controls 1.0
Dialog {
    contentHeight: 600
    contentWidth:500
    clip:true

    //dialog background
    Rectangle{
        id: background
        width:parent.width - 25
        height: parent.height -25
        anchors.centerIn:parent
    }
    //dialog title
    Text{
        id: dialogTitle
        height: 50
        anchors{top:background.top; left:background.left}
        text: "Add Recipe"
        font{pointSize: 16; bold: true}
    }
    //scrollable area
    ScrollArea{
        id:scrollArea
        anchors{top:dialogTitle.bottom; left:dialogTitle.left}
        width:background.width
        height: background.height - dialogTitle.height
        Rectangle{
            id:form
            height:childrenRect.height + 20
            width:  parent.width
            anchors{top:parent.top; left:parent.left}

            //recipe image
            Image{
                id: recipeImage
                anchors{topMargin: 15; top:parent.top; left:parent.left}
                height:125
                width:125
                source: "../../images/no-image.jpg"
            }
            //addrecipe button
            CustomButton{
                id:addImage
                anchors{topMargin: 10; top:recipeImage.bottom; left: recipeImage.left}
                width: recipeImage.width
                height: 30
                radius: 3
                label: "Choose Image"
           }
            //Title label
            Text{
               id:titleLabel
               text: "Title"
               anchors{leftMargin: 25; top:recipeImage.top; left:recipeImage.right}
               font{pointSize: 14}
            }
            //Title field
           TextField{
               id:titleField
               anchors{topMargin: 10; top: titleLabel.bottom; left: titleLabel.left}
               placeholderText: "Enter a Title"
               width: 250
            }
            //Category label
            Text{
               id: categoriesLabel
               text: "Categories"
               anchors{topMargin: 15; top:titleField.bottom; left:titleField.left}
               font{pointSize: 14}
            }
            //Category field
           TextField{
               id:categoriesField
               anchors{topMargin: 10; top: categoriesLabel.bottom; left: categoriesLabel.left}
               placeholderText: "Enter categories separated by commas"
               width: 250
            }
            //Ingredients label
            Text{
               id:ingredientsLabel
               text: "Ingredients"
               anchors{topMargin: 15; top:categoriesField.bottom; left:categoriesField.left}
               font{pointSize: 14}
            }
           //ingredients
           AddItemView{
               id:addIngredients
               anchors{topMargin: 10; top: ingredientsLabel.bottom; left: ingredientsLabel.left}
            }
            //Directions label
            Text{
               id:directionsLabel
               text: "Directions"
               anchors{topMargin: 35; top:addIngredients.bottom; left:addIngredients.left}
               font{pointSize: 14}
            }
           //ingredients
           AddItemView{
               id:addDirections
               anchors{topMargin: 10; top: directionsLabel.bottom; left: directionsLabel.left}
            }
           //description label
            Text{
               id:descriptionLabel
               text: "Description"
               anchors{topMargin: 35; top:addDirections.bottom; left:addDirections.left}
               font{pointSize: 14}
            }

           //description
           TextArea{
               id:description
               height:100
               width:300
               anchors{topMargin: 10; top:descriptionLabel.bottom; left:descriptionLabel.left}
            }
           //add Recipe Button
           CustomButton{
               id:addRecipeButton
               label:"Add Recipe"
               height:30
               anchors{topMargin:35; top:description.bottom; right: description.right}

            }
           //Cancel Button
           CustomButton{
               id:cancelButton
               label:"Cancel"
               height:30
               defaultColor: Qt.lighter("gray")
               anchors{rightMargin: 25; top:addRecipeButton.top; right: addRecipeButton.left}

            }

        }
    }
}
