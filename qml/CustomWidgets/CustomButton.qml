import QtQuick 2.0

//Button
Rectangle {

    width: 100
    height: 62

    property string label:                  "Button"
    property string fontFamily:             "Helvetica"
    property int    fontSize:               12
    property color  defaultColor:           "gray"
    property color  defaultBorderColor:     "darkgray"
    property color  hoverBorderColor:       "white"
    property color  textColor:              "white"

    signal buttonClick();

    border.color: defaultBorderColor

    //label
    Text{
        id:buttonLabel
        anchors.centerIn: parent
        font.pointSize: fontSize
        font.family: fontFamily
        text: label
        color: textColor
    }

    MouseArea{
        id: buttonMouseArea
        anchors.fill:parent
        hoverEnabled: true
        onClicked: buttonClick()
        onEntered: parent.border.color= hoverBorderColor
        onExited: parent.border.color = defaultBorderColor
    }
    color: buttonMouseArea.pressed ? Qt.darker(defaultColor) : defaultColor

}
