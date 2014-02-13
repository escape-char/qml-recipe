import QtQuick 2.0

Rectangle { 
    id: actionBar
    height: 41
    width: parent.width
    color: "#e8e8e8"

    //bottom border
    Rectangle {
        height: 1
        width: parent.width
        color: "#c0c0c0"
        anchors.top: parent.bottom
    }

    //top border
    Rectangle {
        height: 1
        width: parent.width
        color: "#c0c0c0"
        anchors.bottom: parent.top
    }
}
