import QtQuick 2.0
import "../../js/fontawesome.js" as FontAwesome

Rectangle {
    property string icon:                   FontAwesome.Icon.Ok
    property bool   disabled:               false
    property color disabledTextColor:      "#525252"
    property color enabledTextColor:       "#B9B9B9"

    width: 30
    height: 30
    color: "transparent";
    radius: 5

    anchors.verticalCenter: parent.verticalCenter

    FontLoader {
        source: "../../fonts/fontawesome-webfont.ttf"
    }

    CustomButton {
        width: parent.height
        height: parent.width
        color: parent.color
        border.width: 0
        border.color: "transparent"
        fontFamily: "FontAwesome"
        defaultColor : "transparent"
        textColor: disabled ? disabledTextColor : enabledTextColor
        label: icon
        disabled: parent.disabled
    }
}