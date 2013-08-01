import QtQuick 2.0
import "fontawesome.js" as FontAwesome

Rectangle {
    id: categoryItemContainer

    property string backgroundColor: "#C4C4C4"
    property string textColor: "#555"
    property string hoverBackgroundColor: "#B3B3B3"
    property string label: "Example"
    property string icon: FontAwesome.Icon.Star
    property int textSize: 12
    property int rowHeight: 30
    property bool hasIcon: false

    color: parent.color
    width: parent.width - 30
    height: rowHeight
    border.color: "transparent"
    border.width: 1
    radius: 5

    Rectangle {
        color: parent.color
        width: parent.width - 6
        height: parent.height - 3

        anchors.left: parent.left
        anchors.leftMargin: 6
        anchors.top: parent.top
        anchors.topMargin: 3

        FontLoader {
            source: "fonts/fontawesome-webfont.ttf"
        }

        Text {
            id: iconText
            color: textColor
            font { pointSize: textSize; family: "FontAwesome" }
            visible: hasIcon
            text: icon
        }

        Text {
            id: favorites
            color: textColor
            text: label
            font { pointSize: textSize; family: "Helvetica" }
            anchors.left: iconText.right
            anchors.leftMargin: 5
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            onEntered: {
                console.log("hovering");
                categoryItemContainer.color = hoverBackgroundColor;
            }
            onExited: {
               categoryItemContainer.color = backgroundColor;
            }
        }
    }

}
