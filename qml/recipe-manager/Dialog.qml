import QtQuick 2.0
Item {
    id: dialog

    z: parent ? parent.z + 3 : 20
    property alias contentWidth: content.width
    property alias contentHeight: content.height
    property alias contentX: content.x
    property alias contentY: content.y
    default property alias children: content.children
    property color borderColor: "gray"
    state: "HIDE"

    anchors.fill: parent

    signal runChanged()
    signal closed();


    Rectangle {
        id: overlay
        width: dialog.parent ? dialog.parent.width : 300
        height: dialog.parent ? dialog.parent.height: 300

        color: 'black'
        z: dialog.z - 1
    }

    Rectangle {
        id: content
        width: contentWidth
        height: contentHeight
        x: -(contentWidth)
        y: 0
        color: "lightyellow"
        z: dialog.z + 1
        border.width: 2
        border.color:borderColor
        radius: 5
    }
    states: [
        State {
            name: "SHOW"
            PropertyChanges{target: overlay;opacity: 0.75}
            PropertyChanges{target: content; x:0}
        },
        State {
            name: "HIDE"
            PropertyChanges{target: overlay;opacity: 0.10}
            PropertyChanges {target:content; x:-(content.width)}

        }
    ]
    transitions: [
        Transition{
            id: hideToShow
            from: "HIDE"; to: "SHOW"
            SequentialAnimation{
                NumberAnimation{
                    target:overlay; property:"opacity";  duration:500
                }
                NumberAnimation{
                    target:content; property:"x";  duration:600
                }
            }
        },
        Transition{
            id: showToHide
            from: "SHOW"; to: "HIDE"
           SequentialAnimation{
               NumberAnimation{
                   target:content; property:"x";  duration:400
                   alwaysRunToEnd: true
                   onStopped: {
                     console.log("stopped")
                    }
               }
               NumberAnimation{
                   target:overlay; property:"opacity";  duration:300
               }
          }
        }
    ]
}
