import QtQuick 2.0
import "../CustomWidgets"
Item {
    id: dialog

    z: parent ? parent.z + 3 : 20
    property int contentWidth: 200
    property int contentHeight: 200
    property int contentX: 100;
    property int contentY: 100;
    default property alias children: scrollArea.children
    property color topColor: "transparent"
    property color bottomColor: "#313131"
    property color borderColor: "transparent"
    property color submitColor: topColor
    property color cancelColor: "#636363"
    property string titleText: "Title"
    property color titleColor:  "black"

    property bool scrollBarVisible: scrollArea.scrollBarVisible

    state: "HIDE"

    anchors.fill: parent

    signal submitClick()
    signal cancelClick();
    signal exitClick();


    Rectangle {
        id: overlay
        width: dialog.parent ? dialog.parent.width : 300
        height: dialog.parent ? dialog.parent.height: 600

        color: 'black'
        z: dialog.z - 2
    }

    Rectangle{
        id: container
        width: contentWidth
        height: 500
        border.color: borderColor
        border.width: 0
        anchors.centerIn: parent
        z: dialog.z
        color: "white"
    }

    Rectangle{
        id: top
        z: dialog.z
        border.color: borderColor
        border.width: 2
        width: contentWidth
        height: 34
        color: topColor
        anchors.left: container.left
        anchors.top: container.top

        //dialog title
        Text{
            id: tText
            height: parent.height
            color: "#888"
            anchors{
                top: top.top;
                left: top.left;
                leftMargin: 10;
                topMargin: 10;
            }
            text: titleText
            font{pointSize: 12; bold: true}
        }
        //exit button
        CustomButton{
            id: exitButton
            height: 18
            width: 18
            label: "x"
            defaultColor: "red"
            anchors{
                top: top.top;
                right: top.right;
                rightMargin: 5;
                topMargin: 5;
            }
            onClicked: {
                exitClick();
                dialog.state  = "HIDE";
            }
        }
    }    //scrollable area
    ScrollArea{
        id:scrollArea
        anchors{top:top.bottom; left:top.left}

        width:dialog.contentWidth
        height: dialog.contentHeight - top.height - bottom.height
        z: container.z + 1

        Item{
            id: content
            anchors.fill: parent;

        }
    }
    Rectangle{
        id: bottom
        z: dialog.z
        width: contentWidth
        color: bottomColor
        height: 50
        anchors.left: container.left
        anchors.bottom: container.bottom

        border.color: borderColor
        border.width: 2

        CustomButton{
             id: submit
             defaultColor: submitColor
             anchors.right: bottom.right
             anchors.bottom:bottom.bottom
             anchors.bottomMargin: 10
             anchors.rightMargin: 4
             height: 30
             onClicked: {
                 submitClick();

             }
            label: "Submit"
        }
        CustomButton{
             id: cancel
             defaultColor: cancelColor
             anchors.right: submit.left
             anchors.bottom:bottom.bottom
             anchors.bottomMargin: 10
             anchors.rightMargin: 4
             height: 30
             onClicked:{
                 cancelClick()
                 dialog.state = "HIDE"
             }
            label: "Cancel"
        }
    }
    MouseArea{
        id: mouseArea
        anchors.fill: parent
        preventStealing: true

        onClicked: {
            console.log("clicked dialog")
            if(!isMouseInDialog()){
                console.log("Clicked outside of dialog")
                dialog.state = "HIDE"
            }

        }

    }
    function isMouseInDialog(){
        return((mouseArea.mouseX >= container.x) &&
                (mouseArea.mouseX <= (container.X + container.width)) &&
               (mouseArea.mouseY >= container.Y) &&
               (mouseArea.mouseY <= container.Y + container.height));
    }

    states: [
        State {
            name: "SHOW"
            PropertyChanges{target: overlay;opacity: 0.50}
            PropertyChanges{target: dialog;opacity: 1.00}

        },
        State {
            name: "HIDE"
            PropertyChanges{target: overlay;opacity: 0.00}
            PropertyChanges{target: dialog;opacity: 0.00}
        }
    ]
    transitions: [
        Transition{
            id: hideToShow
            from: "HIDE"; to: "SHOW"
            SequentialAnimation{
                NumberAnimation{
                    target:overlay; property:"opacity";  duration:1000
                }
            }
        },
        Transition{
            id: showToHide
            from: "SHOW"; to: "HIDE"
           SequentialAnimation{
               NumberAnimation{
                   target:overlay; property:"opacity";  duration:100
               }
          }
        }
    ]
}
