import QtQuick 2.0

Rectangle {
    id: groceries
    width: parent.width
    height: parent.height
    state: "HIDE"

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
