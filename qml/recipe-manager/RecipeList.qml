import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"


//ListContainer
Rectangle {
    id: recipeListComponent
    height: parent.height
    width: parent.width * 0.35
    color: "white"

    XmlListModel {
        id: recipeModel2
        source: "content/recipe_manager.xml"
        query: "/recipe_manager/recipe"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "description"; query: "description/string()" }
        XmlRole { name: "difficulty"; query: "difficulty/string()" }
        XmlRole { name: "duration"; query: "duration/string()" }
        XmlRole { name: "image"; query: "image/string()" }
    }

    Rectangle {
        id: recipeListContainer
        anchors.fill: parent
        color: "#D6D6D6"

        ListView {
             id: recipeList
             model: recipeModel2
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


    //top border of page bar
    Rectangle {
        id: pageBarBorder
        height: 1; width: parent.width
        color: "#8A8A8A"
        anchors.bottom: recipeListContainer.bottom
    }

    Rectangle {
        id: pageBar
        height: 40; width: parent.width
        color: "#A9A9A9"

        anchors.bottom: pageBarBorder.bottom
    }

    //Right border
    Rectangle {
        height: parent.height
        width: 1
        color: "#A2A2A2"

        anchors.left: recipeListContainer.right
    }
}

