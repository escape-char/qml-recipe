import QtQuick 2.0

Rectangle { 
    property Rectangle content: {}

    id: actionBar
    height: 41
    width: parent.width


    //action bar content
    Row {
        id: actionBarContent
        height: 40; width: parent.width
        Rectangle {
            color: "#A9A9A9"
        }
    }

    //Top border
    Rectangle {
        id: actionBarBorder
        height: 1; width: parent.width
        color: "#8A8A8A"
        anchors.bottom: actionBarContent.top
    }
}
