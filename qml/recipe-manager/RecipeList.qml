import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"


//Item Container
Rectangle {
    id: listItem

    property int topMargin: 20
    property int leftMargin: 20
    property int imageSize: 100
    property int checkBoxContainerWidth: 20
    property string white: "#f3f3f3"

    anchors.fill: parent

    /*XmlListModel {
        id: recipeModel
        source: "content/recipe_manager.xml"
        query: "/recipe_manager/recipe"

        XmlRole { name: "title"; query: "title/string()" }
        XmlRole { name: "description"; query: "description/string()" }
        XmlRole { name: "difficulty"; query: "difficulty/string()" }
        XmlRole { name: "duration"; query: "duration/string()" }
        XmlRole { name: "image"; query: "image/string()" }
    }*/

    Rectangle {
        anchors.fill: parent
        color: "white"

        ListView {
             id: recipeList
             model: recipeModel
             delegate: RecipeDelegate {}

             anchors.fill: parent
        }
    }

    /*Rectangle {
        id: listItemCheckboxContainer
        color: "#EAEAEA"
        height: parent.height - topMargin
        width: 20

        CheckBox{
            id: listItemCheckBox

            anchors.left: parent.left
            anchors.leftMargin: 1

            anchors.top: parent.top
            anchors.topMargin: topMargin

        }
    }

    Rectangle {
        id: listItemImagecontainer
        height: parent.height - topMargin
        width: 100
        color: white

        anchors.left: listItemCheckboxContainer.right
        anchors.leftMargin: 10

        anchors.top: parent.top
        anchors.topMargin: topMargin

        Image {
            id: listitemimage
            source: "100x100.gif"
            height: 100
            width: parent.width
            asynchronous: true
        }
    }

    Rectangle {
        height: parent.height - topMargin
        width: parent.width - imageSize - checkBoxContainerWidth
        color: white
        anchors.left: listItemImagecontainer.right
        anchors.leftMargin: 10

        Text {
            id:listitemtitle
            font.bold: true
            font.pixelSize: 18
            text: "Hello world"
            wrapMode: "WordWrap"
            anchors.top: parent.top
            anchors.topMargin: topMargin
        }
    } */
}

