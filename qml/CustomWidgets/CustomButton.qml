import QtQuick 2.0

//Button
Rectangle {
    id: button
    width: 100
    height: 62

    property string label:                  "Button"
    property string fontFamily:             "Helvetica"
    property int    fontSize:               12
    property color  defaultColor:           "gray"
    property color  defaultBorderColor:     "darkgray"
    property color  hoverBorderColor:       "white"
    property color  textColor:              "white"
    property bool   disabled: false

    signal clicked();

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
        onEntered: parent.border.color= hoverBorderColor
        onExited: parent.border.color = defaultBorderColor
    }

    Component.onCompleted: {
        buttonMouseArea.clicked.connect(button.clicked)
    }

    color: buttonMouseArea.pressed ? Qt.darker(defaultColor) : defaultColor

}
