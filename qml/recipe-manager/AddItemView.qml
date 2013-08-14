import QtQuick 2.0

Rectangle{
    id:addItemView
    height: 160
    width: 180
    border.color: "gray"
    color: "white"
    property variant itemModel: model

    signal addButtonClick()
    onAddButtonClick: {
        console.log("clicked add")
        itemModel.append({"ingredient": "eggs"})

    }
    ListModel{
        id:model
        ListElement{ingredient: ""}

    }
    Component{
        id: itemDelegate
        Column{
            spacing: 5
            Text{text: ingredient}
        }

    }
    ListView{
        id: itemListView
        anchors.fill: parent
        model:itemModel
        delegate: itemDelegate

    }
    //add recipe
    CustomButton{
        id: addItem
        anchors.top: itemListView.bottom
        width: 40;
        height: 20;
        label: "+"
        MouseArea{
            anchors.fill:parent
            onClicked: addButtonClick()
        }
    }
}



