import QtQuick 2.0
import QtQuick.Controls 1.0

import ".."

Rectangle {
    id: categoryDelegate
    width: parent.width - 20
    height: 30
    property variant categoryData: model
    radius: 5
    smooth: true
    clip:true


    property variant selectedCategory
    color: categoryDelegate.ListView.isCurrentItem ? Qt.darker("#C4C4C4", 1.3) : "#C4C4C4"


    Component.onCompleted: {
        categoryDelegate.ListView.view.currentIndex = -1
    }

    CategoryItem {
        property int category_id: id
        property string category_name: name
        label: category_name
        hasIcon: false
        onCategoryItemClicked: {
            categoryDelegate.ListView.view.currentIndex = index
        }
        backgroundColor: "transparent"

    }
}
