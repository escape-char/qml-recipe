import QtQuick 2.0
import "../../js/fontawesome.js" as FontAwesome

Rectangle {
    id: button
    property string icon:                   FontAwesome.Icon.Ok
    property bool   disabled:               false
    property color disabledTextColor:      "#ccc"
    property color enabledTextColor:       "#888"

    width: 30
    height: 30
    color: "transparent";
    radius: 5

    signal clicked
    anchors.verticalCenter: parent.verticalCenter

    FontLoader {
        source: "../../fonts/fontawesome-webfont.ttf"
    }

    CustomButton {
        id: custButton
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

        Component.onCompleted: {
            custButton.clicked.connect(button.clicked)
        }
    }
}
