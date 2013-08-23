import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle{
    id:addItemView
    height: 160
    width: 180
    border.color: "gray"
    color: "white"

    signal addButtonClick()
    onAddButtonClick: {
        console.log("ADDITEMVIEW: clicked add button")
        listView.model.append({"name": textField.text})
        textField.text = ""
        console.log("ADDITEMVIEW: listView count: " + listView.count)
        console.log("ADDITEMVIEW: model count: " + model.count)
    }
    ListModel{
        id:model
        ListElement{name: ""}
    }
    Component{
        id: itemDelegate
        Rectangle{
            height: 30
            width: addItemView.width - 5
            color: "white"
            border.color: "lightgray"
            border.width: 1

            Text{
                id:itemText
                width: parent.width * 0.85
                anchors{margins:10; top:parent.top; left: parent.left}
                color: "gray"
                text: name
            }
            //remove action
            Rectangle{
                height: 30
                width: 10
                Text{id: textField; text: "X"; color: "darkred"}
                anchors{left: itemText.right; top: itemText.top}
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
                    }
                }
            }
        }
    }
    ScrollArea{
        id:scrollArea
        height: parent.height
        width:parent.width
        ListView{
            id: listView
            model:model
            delegate: itemDelegate
            width: parent.width
            height: childrenRect.height
            spacing: 1
            Component.onCompleted: {
                model.clear()
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



