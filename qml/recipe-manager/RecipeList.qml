import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"
import "fontawesome.js" as FontAwesome



//ListContainer
Rectangle {
    property int currentPage: 1
    property int lastPage: 2
    id: recipeList
    height: parent.height
    width: parent.width
    color: "white"

    Rectangle {
        id: recipeListContainer
        color: "#D6D6D6"

        height: parent.height - 41
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

        Rectangle {
            color: "transparent"
            height: 17; width: 40

            Text {
                color: "#6B6B6B"
                width: parent.width; height: parent.height
                text: "1 of 1"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        //Previous Page Button
        ActionBarButton {
           icon: FontAwesome.Icon.ArrowLeft
           anchors.left: parent.left
           anchors.leftMargin: 10

        }

        //Next Page Button
        ActionBarButton {
           icon: FontAwesome.Icon.ArrowRight
           anchors.right: parent.right
           anchors.rightMargin: 10
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

