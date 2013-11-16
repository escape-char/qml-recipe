import QtQuick 2.0

Rectangle { 
    id: actionBar
    height: 41
    width: parent.width
    color: "#A9A9A9"


    //Top border
    Rectangle {
        id: actionBarBorder
        height: 1; width: parent.width
        color: "#8A8A8A"
        anchors.bottom: parent.top
    }
}
