import QtQuick 2.0

//Button
Rectangle {

    width: 100
    height: 62

    property string label:                  "Button"
    property string fontFamily:             "Helvetica"
    property int    fontSize:                12
    property color  backgroundColor:           "gray"
    property color  borderColor:            "darkgray"
    property color  hoverBackgroundColor:   "lightgray"
    property color  textColor:              "white"
    property bool   disabled:               false

    signal buttonClick();

    color: backgroundColor
    border.color: borderColor


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
        onEntered: {
            if (disabled == false) {
                parent.color = hoverBackgroundColor
                parent.radius = 5
            }
        }

        onExited: {
            parent.color = backgroundColor
            parent.radius = 0
        }
    }

}
