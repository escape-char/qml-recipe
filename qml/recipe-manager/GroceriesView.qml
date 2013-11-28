import QtQuick 2.0

Item {
    id: groceries
    width: parent ? parent.width : 0
    height: parent ? parent.height : 0
    objectName: "Groceries"
    state: "HIDE"

    Rectangle{
        id: background
        anchors.fill: parent
    }
    Text{
        id:title
        anchors{top:background.top; left: background.left}
        font{pointSize:14; bold:true}
        text: "Groceries"
    }

    states: [
        State {
            name: "SHOW"
            PropertyChanges {
                target: groceries
                visible:true
            }
        },
        State {
            name: "HIDE"
            PropertyChanges {
                target: groceries
                visible: false
            }
        }
    ]
}
