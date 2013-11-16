import QtQuick 2.0
Rectangle {
    id: container

    border.color: "gray"
    border.width: 1
    radius: 10
    width: 230
    height: fontPixelSize+25

    property alias maximumLength: input.maximumLength
    property alias inputMask: input.inputMask
    property alias validator: input.validator
    property int fontPixelSize: 26


    function floatValue() {
        return parseFloat(container.value);
    }
/*
    states: [
        State {
            name: 'input'
            PropertyChanges {
                target: container
                color: 'lightblue'
            }
            PropertyChanges {
                target: input
                visible: true
                focus: true
            }
            PropertyChanges {
                target: displayValue
                visible: false
            }
        }
    ]
*/

    transitions: [
         Transition {
             ColorAnimation { duration: 150 }
         }
     ]

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (!enabled) return;

            if (container.state == 'input')
                container.state = '';
            else {
                input.text = container.value;
                input.selectionStart = 0;
                input.selectionEnd = input.text.length;
                container.state = 'input';
            }
        }
    }
/*
    Text {
        id: label
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pixelSize: fontPixelSize
    }

    Text {
        id: displayValue
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
        font.pixelSize: fontPixelSize
        color: "gray"
    }
*/

    TextInput {
        id: input
        readOnly: false
        horizontalAlignment: "AlignRight"

        anchors.left: parent.left
        anchors.leftMargin: 10

        anchors.right: parent.right
        anchors.rightMargin: 10

        anchors.verticalCenter: parent.verticalCenter

        font.pixelSize: fontPixelSize
        visible: false

        /*
        Keys.onPressed: {
            if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter) {
                var emitSignal = (container.value != input.text);
                displayValue.text = container.value = input.text;

                if (emitSignal)
                    container.valueChanged();

                container.state = '';
            }
        }
        */

        onFocusChanged: {
            if (!focus)
                container.state = '';
        }
    }
}
