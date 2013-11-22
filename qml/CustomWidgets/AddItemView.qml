import QtQuick 2.0
import QtQuick.Controls 1.0

Item{
    id:addItemView
    height: 160
    width: 180
    property var items: []

    Rectangle{
        id:container
        anchors.top: parent.top
        anchors.left: parent.left
        height: parent.height - textField.height - textField.anchors.topMargin
        width: parent.width
        color: "white"
        border.width: 2
        border.color: "gray"
    }
    Component.onCompleted: {
        console.log("AddItemView.oncCompleted()");
       items.forEach(function(i){model.append({"name": i});})
    }

    signal addButtonClick()
    onAddButtonClick: {
        console.log("ADDITEMVIEW.onAddButtonClick")
        if(textField.text.length){
            items.push(textField.text)
            model.append({"name": textField.text})
            textField.text = ""
         }
    }
    ListModel{
        id:model
    }
    Component{
        id: itemDelegate
        Rectangle{
            height: 23
            width: scrollArea.scrollBarVisible ? container.width - 25 : container.width
            color: "white"
            border.color: "lightgray"
            border.width: 1

            Text{
                id:itemText
                width: parent.width * 0.80
                anchors{top:parent.top; left: parent.left}
                color: "gray"
                text: name
            }
            //remove action
            Rectangle{
                height: parent.height
                width: 23
                border.width: 1
                border.color: "lightgray"
                anchors{right:parent.right; top:parent.top}
                Item{
                    height: 10
                    width: 10
                    Text{id: exitField; text: "X"; color: "red"; font{pointSize: 6}}

                    anchors{centerIn: parent}

                }
            }
            MouseArea{
               anchors.fill: parent
               hoverEnabled: true
               onEntered: {
                   textField.font.bold = true
                }
               onExited: {
                   textField.font.bold = false
                }
               onClicked: {
                    listView.model.remove(index)
                    items.splice(index, 1)
                }
            }
        }
    }
    ScrollArea{
        id:scrollArea
        height: container.height - 8
        width:container.width - 10
        anchors.top: container.top
        anchors.left: container.left
        anchors.topMargin: 5
        anchors.leftMargin: 5

        ListView{
            id: listView
            model:model
            delegate: itemDelegate
            width: parent.width - 10
            height: childrenRect.height
            spacing: 1
            Component.onCompleted: {
            }
        }
    }
    //textbox for entering item
    TextField{
        id: textField
        width: parent.width - addItem.width
        height: 24
        placeholderText: "Enter an Item"
        anchors{topMargin: 5; top: scrollArea.bottom; left:scrollArea.left}

    }
    //add item button
    CustomButton{
        id: addItem
        anchors.top: scrollArea.bottom
        anchors.topMargin: 5
        anchors.left:textField.right
        width: 40;
        height: 20;
        label: "+"
        MouseArea{
            anchors.fill:parent
            onClicked: addButtonClick()
        }
    }
}



