import QtQuick 2.0
import "fontawesome.js" as FontAwesome

Rectangle {
    width: 10
    height: 10
    color: "#A9A9A9"

    anchors.verticalCenter: parent.verticalCenter

    FontLoader {
        source: "fonts/fontawesome-webfont.ttf"
    }

    CustomButton {
        width: parent.height
        height: parent.width
        defaultColor: "#A9A9A9"
        fontFamily: "FontAwesome"
        textColor: "#484848"
        label: FontAwesome.Icon.Ok
    }
}
