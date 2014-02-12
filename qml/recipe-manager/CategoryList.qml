import QtQuick 2.0
import "content"
import "../CustomWidgets"
import "../../js/fontawesome.js" as FontAwesome
import Widgets 1.0

Rectangle {
    id: categoryList
    property color backgroundColor: "#505050"
    property color borderColor: "#444"
    property color labelColor: "#A39494"
    property int textSize: 12
    property int labelSize: 10
    property bool enableEdit: false
    property int leftMargin: 15
    property int topMargin: 10
    property int rowHeight: 30

    height: parent.height
    width: 200
    color: backgroundColor

    //category event handlers
    signal categorySelect(variant category)
    signal favoritesClick()
    signal allClick()

    SqlQueryModel{
        id:categoryModel
        query: "SELECT * FROM categories"
        Component.onCompleted: {
            categoryModel.updateQuery("SELECT * FROM categories")
        }
    }
    Component.onCompleted: {
        //deselect();
    }

    function refresh(){
        console.log("CATEGORYLIST.refresh()");
        categoryModel.updateQuery("SELECT * FROM categories");
    }

    function deselect(){
        console.log("CATEGORYLIST.deselect()");
        //categoriesListView.currentIndex = -1;
    }

    Rectangle {
        id: categoriesContent
        height: parent.height - 41; width: parent.width
        color: "transparent"

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

                Text {
                    id: categoriesLabel
                    color: labelColor
                    text: "Categories"
                    font { pointSize: labelSize; bold: true; family: "Helvetica" }
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                }
                ListView {
                    id: categoriesListView
                    height: parent.height - categoriesLabel.height - 15
                   width: parent.width
                    model: categoryModel
                    delegate: CategoryDelegate {id: categoryDelegate}

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
