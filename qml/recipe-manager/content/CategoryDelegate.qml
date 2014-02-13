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
    color: categoryDelegate.ListView.isCurrentItem ? Qt.lighter("#444") : "#444"


    Component.onCompleted: {
        categoryDelegate.ListView.view.currentIndex = -1
    }

    CategoryItem {
        label: name
        textColor: "#aaa"
        textSize: 14
        hasIcon: false
        onCategoryItemClicked: {
            categoryDelegate.ListView.view.currentIndex = index
        }

    }
}
