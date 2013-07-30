import QtQuick 2.0

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
