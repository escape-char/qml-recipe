import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"
import "js/fontawesome.js" as FontAwesome

Item {
    id:container
    property int currentPage: 1
    property int lastPage: 2
    property variant currentRecipe
    height: parent ? parent.height : 350
    width:300
    signal itemClicked()
    signal loaded()


    onItemClicked: {}
    onLoaded: {}

   //background
    Rectangle {id: background;color: "#515151"; anchors.fill:parent}

    //Action bar for List view
    ActionBar {
        id: listViewActionBar
        anchors.top: parent.top
    }

    ScrollArea{
        width:background.width
        height: background.height - pagination.height
        ListView {
             id: recipeListView
             width: background.width
             height: childrenRect.height
             interactive: true
             model: recipeModel


             delegate: RecipeDelegate {
                 onRecipeClicked: {
                     container.currentRecipe = recipeListView.currentItem.recipeData
                     console.log("RECIPELIST: clicked " + currentRecipe.id + ") " + currentRecipe.title)
                 }
             }

             highlight: Rectangle { color: "#DCE0B8"; }

             /*
             Component.onCompleted: {
                 container.currentRecipe = recipeListView.currentItem.recipeData
                 loaded()
             }
             */

             /*
            Rectangle {
                height: 1
                width: parent.width
                color: "#BDBDBD"
                anchors.top: recipeListView.bottom
rectangle
            }
            */
        }
    }
    //Pagination bar
    ActionBar {
        id: pagination
        anchors.bottom: parent.bottom
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

    //left border
    Rectangle {
        height: parent.height
        width: 1
        color: "#474747"

        anchors.left: parent.left
    }
}
