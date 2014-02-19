import QtQuick 2.0
import "../CustomWidgets"
Page {
    id: itemlist
    width: parent.width
    height: parent.height

    property variant recipeListView: recipeList
    property variant categoryList: categoryListView;

    function update(){
        recipeList.update();
        categoryListView.update();
    }
    function getQueryModel(){
        return recipeList.queryModel;
    }
    Component.onCompleted: {
        itemlist.categoryList = categoryListView.toString()
        console.log("CategoriesPage.onComplete(): " + itemlist.categoryListView)
    }


    Rectangle {
        id:container
        anchors.fill: parent
     }

    CategoryList{
        id: categoryListView

        anchors {top: container.top; left: container.left}
    }
    RecipeListDetailed {
        id: recipeList
        height: parent.height
        width: parent.width - categoryListView.width
        anchors {top: container.top; left: categoryListView.right}
    }

}
