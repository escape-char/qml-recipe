import QtQuick 2.0
import "../../js/fontawesome.js" as FontAwesome

Rectangle {
    id: categoryItemContainer

    property color backgroundColor: "#333333"
    property color textColor: "#c0c0c0"
    property color  hoverBackgroundColor: "#3f3f3f"
    property string label: "Example"
    property string icon: FontAwesome.Icon.Star
    property int textSize: 12
    property int rowHeight: 30
    property bool hasIcon: false

    color: parent.color
    smooth:true
    clip:true
    width: parent.width
    height: rowHeight
    border.color: "transparent"
    border.width: 1

    signal categoryItemClicked()

    Rectangle {
        color: parent.color
        width: parent.width
        height: parent.height - 10

        anchors.left: parent.left
        anchors.leftMargin: 6
        anchors.top: parent.top
        anchors.topMargin: 3

        FontLoader {
            source: "../../fonts/fontawesome-webfont.ttf"
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
                categoryItemContainer.color = hoverBackgroundColor;
            }
            onExited: {
               categoryItemContainer.color = backgroundColor;
            }
            onClicked: categoryItemClicked()
        }
    }

}
