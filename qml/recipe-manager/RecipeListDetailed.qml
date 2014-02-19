import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.XmlListModel 2.0
import "content"
import "../CustomWidgets"
import "../../js/fontawesome.js" as FontAwesome
import "../../js/DatabaseHandler.js" as DatabaseHandler
import Widgets 1.0

Item {
    id:container
    property int currentPage: 1
    property int lastPage: 2
    property variant currentRecipe
    property int curWidth:parent.width
    height: parent.height
    width: curWidth
    property variant model
    signal itemClicked()
    signal loaded()

    onItemClicked: {}
    onLoaded: {}

    function update(){
        recipeListView.update()
    }
    function filterByCategories(){

    }

   //background
    Rectangle {id: background; color: "#fff"; anchors.fill:parent}

    //Action bar for List view
    ActionBar {
        id: listViewActionBar
        anchors.top: parent.top

        ActionBarButton {
            id: categoriesButton
            icon: FontAwesome.Icon.List
            anchors.left: parent.left
            anchors.leftMargin: 10
        }

        ActionBarButton {
            id: searchButton
            icon: FontAwesome.Icon.Search
            anchors.right: parent.right
            anchors.rightMargin: 10
        }
    }
    ScrollArea{
        id: scrollList
        width: background.width - 7
        height: background.height - pagination.height - listViewActionBar.height
        anchors {top: listViewActionBar.bottom; left: parent.left; topMargin: 0;}

      ListView {
             id: recipeListView
             width: curWidth
             height: childrenRect.height
             interactive: true

             model: container.model

             delegate: RecipeDelegate {
                 onRecipeClicked: {
                     container.currentRecipe = recipeListView.currentItem.recipeData
                     console.log("RECIPELIST: clicked " + currentRecipe.id +  " " + currentRecipe.title)
                 }
             }
             onCurrentIndexChanged: {
                 console.log("current index changed")
             }
             onCurrentItemChanged: {
                 console.log("onCurrentItemChanged")
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
           icon: FontAwesome.Icon.ArrowLeft
           disabled: true
           anchors.left: parent.left
           anchors.leftMargin: 10

        }

        //Next Page Button
        ActionBarButton {
           icon: FontAwesome.Icon.ArrowRight
           disabled: true
           anchors.right: parent.right
           anchors.rightMargin: 10
        }
    }
}
