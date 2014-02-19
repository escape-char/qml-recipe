import QtQuick 2.0
import "content"
import "../CustomWidgets"
import "../../js/fontawesome.js" as FontAwesome
import "../../js/DatabaseHandler.js" as DatabaseHandler
import Widgets 1.0

Rectangle {
    id: categoryList
    property color backgroundColor: "#444"
    property color borderColor: "#333"
    property color labelColor: "#aaa"
    property int textSize: 12
    property int labelSize: 12
    property bool enableEdit: false
    property int leftMargin: 15
    property int topMargin: 10
    property int rowHeight: 30
    property variant model

    height: parent.height
    width: 200
    color: backgroundColor

    //category event handlers
    signal categorySelect(variant category)
    signal favoritesClick()
    signal allClick()

    Component.onCompleted: {
        //deselect();
    }

    function update(){
    }
    function updateQuery(query){
        categoryModel.updateQuery(query)  ;
    }

    function deselect(){
        console.log("CATEGORYLIST.deselect()");
        //categoriesListView.currentIndex = -1;
    }

    Rectangle {
        id: categoriesContent
        height: parent.height - 41; width: parent.width
        color: parent.color

        Rectangle {
            id: listItems
            color: parent.color
            height: parent.height
            width: parent.width

            anchors.top: parent.top
            anchors.topMargin: topMargin


            //Main items
            Rectangle {
                id: mainItems
                height: 70
                width: parent.width - 20
                color: parent.color

                CategoryItem {
                    id: all
                    hasIcon: true
                    icon: FontAwesome.Icon.Book
                    label: "All"
                    onCategoryItemClicked: allClick()

                }

                CategoryItem {
                    hasIcon: true
                    icon: FontAwesome.Icon.Star
                    label: "Favorites"

                    anchors.top: all.bottom
                    anchors.topMargin: 2
                    onCategoryItemClicked: favoritesClick()
                }

                anchors.left: parent.left
                anchors.leftMargin: leftMargin
            }

            Rectangle {
                id: separator
                height: 1
                width: parent.width
                color:  borderColor
                anchors.top: mainItems.bottom
                anchors.topMargin: 5
            }

            Rectangle {
                height: parent.height - separator.height - mainItems.height - topMargin
                width: parent.width - 20
                color: parent.color


                ListView {
                    id: categoriesListView
                    height: parent.height
                    width: parent.width
                    model: categoryList.model
                    delegate: CategoryDelegate {id: categoryDelegate}

                    anchors.top:  parent.top
                    anchors.topMargin: 5
                    anchors.left: parent.left

                    onCurrentItemChanged: {
                        //have item changed
                        if(categoriesListView.currentItem){

                            var d = categoriesListView.currentItem.categoryData;

                            console.log("CategoryList.onCurrentItemChanged(): category.id = " + d.id);
                            console.log("CategoryList.onCurrentItemChanged(): category.name = " + d.name);

                           categorySelect(d); //give item to those holding signal
                        }
                        //don't have changed item
                        else{
                            console.log("CategoryList.onCurrentItemChange(): currentItem is null");
                        }
                    }
                }

                anchors.top: separator.bottom
                anchors.topMargin: 10
                anchors.left: parent.left
                anchors.leftMargin: leftMargin
            }
        }
    }

    //right border
    Rectangle {height: parent.height; width:1; color: borderColor; anchors.right:parent.right; }
    //left border
    Rectangle {height: parent.height; width:1; color: borderColor; anchors.left:parent.left; }
}
