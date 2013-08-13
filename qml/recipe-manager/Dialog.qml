import QtQuick 2.0
Item {
    id: dialog

    z: parent.z + 3
    property alias contentWidth: content.width
    property alias contentHeight: content.height
    default property alias children: content.children
    property color borderColor: "darkgray"

    anchors.fill: parent
    function close() {
        dialog.closed();
        dialog.opacity = 0;
    }
    function show() {
        dialog.opacity = 1;
    }
    signal closed();

    state: "HIDE"

    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    Rectangle {
        id: overlay
        width: dialog.parent.width
        height: dialog.parent.height

        color: 'black'
        opacity: 0.5
        z: dialog.z - 1
    }

    Rectangle {
        id: content
        width: contentWidth
        height: contentHeight
        anchors.centerIn: parent
        color: "lightyellow"
        z: dialog.z + 1
        border.width: 5
        border.color:borderColor
        radius: 15
    }
    states: [
        State {
            name: "SHOW"
            PropertyChanges {
                target: dialog
                opacity: 1
            }
        },
        State {
            name: "HIDE"
            PropertyChanges {
                target: dialog
                opacity: 0
            }
        }
    ]
}
