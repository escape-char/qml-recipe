import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"


//ListContainer
Rectangle {
    id: recipeList
    height: parent.height
    width: parent.width
    color: "white"

    Rectangle {
        id: recipeListContainer
        color: "#D6D6D6"

        height: parent.height - 45
        width: parent.width

        ListView {
             id: recipeListContent
             model: recipeModel
             delegate: RecipeDelegate {}

             highlight: Rectangle { color: "#DCE0B8"; }

             anchors.fill: parent
        }

        Rectangle {
            height: 1
            width: parent.width
            color: "#BDBDBD"
            anchors.top: recipeListContent.bottom

        }
    }

    //Pagination bar
    ActionBar {
        anchors.top: recipeListContainer.bottom

        CustomButton {
            id: prevPage
            color: parent.color
            label: "Previous"
            anchors.left: parent.left
        }

        Text {
            height: 10
            width:  30
            text: "1 of 1"
            anchors.horizontalCenter: parent.horizontalCenter

        }


    }

    //Right border
    Rectangle {
        height: parent.height
        width: 1
        color: "#A2A2A2"

        anchors.left: recipeListContainer.right
    }
}

