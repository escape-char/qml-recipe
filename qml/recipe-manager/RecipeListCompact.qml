import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"
import "../CustomWidgets"
import "../../js/fontawesome.js" as FontAwesome
import Widgets 1.0

Item {
    id:container

    property int currentPage: 1
    property int lastPage: 2
    property variant currentRecipe
    property int curWidth: 350
    property variant sqlModel;

    height: parent.height
    width: curWidth

    signal itemClicked()
    signal loaded()
    signal backClicked()


   //background
    Rectangle {id: background; color: "#555555"; anchors.fill:parent}

    //Action bar for List view
    ActionBar {
        id: listViewActionBar
        anchors.top: parent.top

        ActionBarButton {
            id: backButton
            icon: FontAwesome.Icon.ArrowLeft
            anchors {left: parent.left; leftMargin: 10}

            onClicked: {
                backClicked()
            }
        }

    }
    ScrollArea{
        id: scrollList
        width: curWidth
        height: background.height
        anchors {top: listViewActionBar.bottom; left: parent.left; topMargin: 0;}

        ListView {
             id: recipeListView
             width: curWidth
             height: childrenRect.height
             interactive: true

             model: container.sqlModel

             delegate: RecipeCompactDelegate {
                 onClicked: {
                     container.currentRecipe = recipeListView.currentItem.recipeData
                     console.log(recipeListView.delegate)
                     console.log("RECIPELIST: clicked " + currentRecipe.id +  " " + currentRecipe.title)
                 }
             }

             //highlight: Rectangle { color: "#DCE0B8"; }

             Component.onCompleted: {
                 container.currentRecipe = recipeListView.currentItem ? recipeListView.currentItem.recipeData : null
                 loaded()
             }
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
           id: paginationBack
           icon: FontAwesome.Icon.ArrowLeft
           disabled: true
           anchors.left: parent.left
           anchors.leftMargin: 10

        }

        //Next Page Button
        ActionBarButton {
           id: paginationNext
           icon: FontAwesome.Icon.ArrowRight
           disabled: true
           anchors.right: parent.right
           anchors.rightMargin: 10
        }
    }

    //left border
    /*Rectangle {
        height: parent.height
        width: 1
        color: "#cfcfcf"

        anchors.left: parent.left
    } */
}
