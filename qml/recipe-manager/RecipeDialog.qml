import QtQuick 2.0
import QtQuick.Controls 1.0
import Widgets 1.0
import "../CustomWidgets"

Dialog {
    id: addRecipeDialog
    clip:true
    MouseArea{
        anchors.fill:parent
        preventStealing: true
    }

    //holds recipe data from form
    property var recipe: {
        "title": "",
        "categories": "",
        "ingredients": [],
        "directions": [],
        "description":"",
        "image": "",
        "duration": -1,
        "difficulty": "",
        "rating": 0
    }

    //signal for canceling dialog
    signal cancelButtonClick()
    //signal for adding recipe
    signal addRecipeButtonClick(variant data)

}
