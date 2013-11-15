import QtQuick 2.0
import "js/fontawesome.js" as FontAwesome
import "components"

Rectangle {
    property string icon:                   FontAwesome.Icon.Ok
    property bool   disabled:               true
    property string disabledTextColor:      "#525252"
    property string enabledTextColor:       "#B9B9B9"

    width: 25
    height: 25
    color: parent.color
    anchors.verticalCenter: parent.verticalCenter

    FontLoader {
        source: "fonts/fontawesome-webfont.ttf"
    }

    CustomButton {
        width: parent.height
        height: parent.width
        color: parent.color
        border.width: 0
        defaultColor: "red"
        fontFamily: "FontAwesome"
        textColor: disabled ? disabledTextColor : enabledTextColor
        label: icon
    }
}
