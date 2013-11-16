import QtQuick 2.0
import "../../js/fontawesome.js" as FontAwesome

Rectangle {
    property string icon:                   FontAwesome.Icon.Ok
    property bool   disabled:               true
    property string disabledTextColor:      "#8C8C8C"
    property string enabledTextColor:       "#484848"

    width: 10
    height: 10
    color: "#A9A9A9"

    anchors.verticalCenter: parent.verticalCenter

    FontLoader {
        source: "../../fonts/fontawesome-webfont.ttf"
    }

    CustomButton {
        width: parent.height
        height: parent.width
        defaultColor: "#A9A9A9"
        fontFamily: "FontAwesome"
        textColor: disabled ? disabledTextColor : enabledTextColor
        label: icon
    }
}
