import QtQuick 2.0
import "fontawesome.js" as FontAwesome

Rectangle {
    property string backgroundColor: "#333333"
    property string hoverBackgroundColor: "#383838"
    property string activeBackgroundColor: "#1F1F1F"
    property string textColor: "#EBEBEB"
    property string icon: FontAwesome.Icon.Ok
    property string label: "None"
    property bool isActive: false

    id: mainMenuItem
    width: parent.width
    height: 60
    color: isActive ? activeBackgroundColor : backgroundColor

    FontLoader {
        source: "fonts/fontawesome-webfont.ttf"
    }

    MouseArea{
        id: buttonMouseArea
        anchors.fill:parent
        hoverEnabled: true
        //onClicked: buttonClick()
        onEntered: { hovering() }

        onExited: { stoppedHovering() }
    }

    Rectangle {
        id: mainMenuItemContent
        width: 45
        height: parent.height - 11
        color: isActive ? activeBackgroundColor : backgroundColor

        anchors.verticalCenter: parent.verticalCenter

        //Icon
        Text {
            id: buttonIcon
            color: textColor
            font {pointSize: 32; family: "FontAwesome"}
            text: FontAwesome.Icon.Book
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        /*//Label
        Text {
            id: buttonLabel
            color: textColor
            font {pointSize: 9; family: "Helvetica"}
            text: label
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter

            anchors.top: buttonIcon.bottom
        }*/

        anchors.horizontalCenter: parent.horizontalCenter
    }

    //bottom border
    Rectangle {
        id: border
        height: 1; width: parent.width;
        color: dividerColor
        anchors.top: parent.bottom
    }

    function hovering() {
        mainMenuItem.color = isActive ? activeBackgroundColor : hoverBackgroundColor
        mainMenuItemContent.color = isActive ? activeBackgroundColor : hoverBackgroundColor
    }

    function stoppedHovering() {
        mainMenuItem.color = isActive ? activeBackgroundColor : backgroundColor
        mainMenuItemContent.color = isActive ? activeBackgroundColor : backgroundColor
    }
}
