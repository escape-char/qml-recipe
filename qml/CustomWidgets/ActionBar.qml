import QtQuick 2.0

Rectangle { 
    id: actionBar
    height: 41
    width: parent.width
    color: "#efefef"

    //bottom border
    Rectangle {
        height: 1
        width: parent.width
        color: "#e0e0e0"
        anchors.top: parent.bottom
    }

    //top border
    Rectangle {
        height: 1
        width: parent.width
        color: "#e0e0e0"
        anchors.bottom: parent.top
    }
}
