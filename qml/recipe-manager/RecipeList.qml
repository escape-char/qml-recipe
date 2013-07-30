import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"


//ListContainer
Rectangle {
    id: recipeListComponent
    height: parent.height
    width: parent.width
    color: "white"

    Rectangle {
        id: recipeListContainer
        anchors.fill: parent
        color: "#D6D6D6"

        ListView {
             id: recipeList
             model: recipeModel
             delegate: RecipeDelegate {}

             highlight: Rectangle { color: "#DCE0B8"; }

             anchors.fill: parent
        }

        Rectangle {
            height: 1
            width: parent.width
            color: "#BDBDBD"
            anchors.top: recipeList.bottom

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

