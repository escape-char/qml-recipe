import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"


//ListContainer
Rectangle {
    id: recipeListContainer
    height: parent.height
    width: parent.width * 0.35

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
        anchors.fill: parent
        color: "white"

        ListView {
             id: recipeList
             model: recipeModel2
             delegate: RecipeDelegate {}

             highlight: Rectangle { color: "#DCE0B8" }

             anchors.fill: parent
        }
    }
}

