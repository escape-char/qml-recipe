import QtQuick 2.0
import "../../js/fontawesome.js" as FontAwesome

Rectangle {
    property color  backgroundColor: parent.color
    property color  hoverBackgroundColor: "#9C3E44"
    property color  activeBackgroundColor: "#641B1B"
    property color  iconColor: "#EEDBDB"
    property string icon: FontAwesome.Icon.Ok
    property int    fontSize: 32
    property int    padding: 10
    property bool   isActive: false

    signal mainMenuItemClick()

    id: mainMenuItem
    width: parent.width
    height: 50
    color: isActive ? activeBackgroundColor : backgroundColor

    FontLoader {
        source: "../../fonts/fontawesome-webfont.ttf"
    }

    MouseArea{
        id: buttonMouseArea
        anchors.fill:parent
        hoverEnabled: true
        onClicked: mainMenuItemClick()
        onEntered: { hovering() }

        onExited: { stoppedHovering() }
    }

    Text {
        id: buttonIcon
        color: iconColor
        width: parent.width
        height: parent.height
        font {pointSize: fontSize; family: "FontAwesome"}
        text: icon
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    function hovering() {
        mainMenuItem.color = isActive ? activeBackgroundColor : hoverBackgroundColor
        this.color = isActive ? activeBackgroundColor : hoverBackgroundColor
    }

    function stoppedHovering() {
        mainMenuItem.color = isActive ? activeBackgroundColor : backgroundColor
        this.color = isActive ? activeBackgroundColor : backgroundColor
    }
}
