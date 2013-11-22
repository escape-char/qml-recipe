import QtQuick 2.0
import "content"
import "../CustomWidgets"
import "../../js/fontawesome.js" as FontAwesome

Rectangle {
    id: categoryList
    property color backgroundColor: "#F2F2F2"
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
    signal categorySelected(variant category)
    signal favoritesClick()
    signal allClick()

    function refresh(){
        console.log("CATEGORYLIST.refresh()")
        categoryModel.updateQuery("SELECT * FROM Categories")
    }

    function deselect(){
        console.log("CATEGORYLIST.deselect()")
        categoriesListView.currentIndex = -1
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
                color: "#E0E0E0"
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
                    anchors.top: categoriesLabel.bottom
                    anchors.topMargin: 8
                    onCurrentItemChanged: {
                        if(categoriesListView.currentItem)
                            categorySelected(categoriesListView.currentItem.categoryData)
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
    Rectangle {height: parent.height; width:2; color: "#E0E0E0"; anchors.right:parent.right; }
    //left border
    Rectangle {height: parent.height; width:2; color: "#E0E0E0"; anchors.left:parent.left; }
}
