import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"
import "fontawesome.js" as FontAwesome

Item {
    id:container
    property int currentPage: 1
    property int lastPage: 2
    property variant currentRecipe
    anchors.fill: parent

    signal itemClicked()
    signal loaded()


    onItemClicked: {}
    onLoaded: {}

    ScrollBar{
        id: scrollbar
        flickable: recipeListView
    }

    //background
    Rectangle {id: background;color: "white"; anchors.fill:parent}

    ListView {
         id: recipeListView
         height:parent.height - pagination.paginationHeight - 26
         width: background.width
         model: recipeModel

         delegate: RecipeDelegate {
             onRecipeClicked: {
                 container.currentRecipe = recipeListView.currentItem.recipeData
                 itemClicked()
             }
         }

         highlight: Rectangle { color: "#DCE0B8"; }

         Component.onCompleted: {
             container.currentRecipe = recipeListView.currentItem.recipeData
             loaded()
         }
    }

    Rectangle {
        height: 1
        width: parent.width
        color: "#BDBDBD"
        anchors.top: recipeListView.bottom

    }

    //Pagination bar
    ActionBar {
        id: pagination
        anchors.bottom: background.bottom
        property int paginationHeight: 17
        property int paginationWidth: 40

        Rectangle {
            color: "transparent"
            height: pagination.paginationHeight
            width: pagination.paginationWidth

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

        anchors.right: background.right
    }

}
