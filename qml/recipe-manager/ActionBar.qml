import QtQuick 2.0

Rectangle { 
    id: actionBar
    height: 41
    width: parent.width
    color: "#404040"


    //Top border
    Rectangle {
        id: actionBarBorder
        height: 1; width: parent.width
        color: "#363636"
        anchors.bottom: parent.top
    }
}
