import QtQuick 2.0

//button widdget
Rectangle{
    id: button
    property color defaultColor: "gray"
    property color onHoverColor: "dimgray"
    property color borderColor: "black"

    signal buttonClicked()
    onButtonClicked: {
    }
    MouseArea: {
        id: buttonMouseArea
        onClicked: buttonClicked()
        hoverEnabled: true
        onEntered: parent.border.color = onHoverColor
        onExited: parent.border.color = borderColor
    }
    color: buttonMouseArea.pressed ? Qt.darker(defaultColor, 1.5) : buttonColor
}
