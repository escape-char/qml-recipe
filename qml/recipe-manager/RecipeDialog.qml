import QtQuick 2.0
import QtQuick.Controls 1.0
import Widgets 1.0
import "../CustomWidgets"

Dialog {
    id: recipeDialog
    clip:true
    anchors.fill: parent
    contentHeight: 450
    contentWidth: 550

    titleText: "Add a Recipe"

    property int labelPadding: 5
    property int leftMargin: 20
    property int topMargin: 15
    property int fontSize: 14
    property int inputWidth: 350
    property int labelWidth: 40
    property int inputHeight: 10

    //holds recipe data
    property var recipe: {
        "title": "",
        "categories": "",
        "ingredients": [],
        "directions": [],
        "description":"",
        "image": "",
        "duration": -1,
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
            color: "#1C1C1C"
            font{bold: true;pointSize: 14}
        }
        //title field
        TextField{
            placeholderText: "Enter a title"
            width: inputWidth
            maximumLength: 100
        }
        //Rating label
        Text{
            width: labelWidth
            height: 20
            text: "Rating"
            color: "#1C1C1C"

            font{bold: true;pointSize: 14}
        }
        Rating{
            width: 205
            height: 40
            fillColor: "gold"
            size:15
        }

        //description label
        Text{
            width: labelWidth
            height: 50
            text: "Description"
            color: "#1C1C1C"

            font{bold: true;pointSize: 14}
        }
        //description field
        TextArea{
            width: inputWidth
            height: 100
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
            color: "#1C1C1C"

            font{bold: true;pointSize: 14}
        }
        //image field
        TextField{
            id:imageField
            placeholderText: "Choose an image"
            anchors.left:imageLabel.right
            anchors.top: imageLabel.top
            width: 250
            height: 30
            maximumLength: 50
        }
        CustomButton{
            id:imageButton
            anchors.left:imageField.right
            anchors.top: imageField.top
            height: imageField.height - 2
            label: "Upload"
            width: 70
        }

    }
    Rectangle{
        id:divider1
        height: 2
        width: contentWidth
        visible:true
        anchors{top:imageSection.bottom; left:imageSection.left}
        color:"lightgray"
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
            color: "#1C1C1C"

            font{bold: true;pointSize: 14}
        }
        //Duration Label
        Text{
            id:durationLabel
            width: labelWidth
            height: 30
            text: "Duration"
            color: "#1C1C1C"

            font{bold: true;pointSize: 14}
        }

        //difficulty combobox
        ComboBox{
            width:100
        }
        Item{
            height: 30
            width: contentWidth
            //hr spinner
            SpinBox{
                id: hrSpin
                decimals: 1
                suffix: "hr"

            }
            SpinBox{
                id:minSpin
                anchors{left:hrSpin.right; top:hrSpin.top}
                decimals:1
                suffix: "min"
                maximumValue: 59
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
            color: "#1C1C1C"

            font{bold: true;pointSize: 14}
        }
        //Directions Label
        Text{
            id:directionsLabel
            width: labelWidth
            height: 30
            text: "Directions"
            color: "#1C1C1C"

            font{bold: true;pointSize: 14}
        }
        AddItemView{
            height:100

        }
        AddItemView{
            height: 100

        }

    }

}
