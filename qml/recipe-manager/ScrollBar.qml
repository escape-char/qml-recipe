import QtQuick 2.0

Rectangle {
    id: scrollbar;
    color: "lightgray"
    opacity:0.8
    property int size:15
    property variant flickable;
    visible: true
    width: size
    height: flickable.height
    z: flickable.z + 1
    anchors {
        top: flickable.top;
        right: flickable.right;
    }
    clip:true
    //up arrow
    Image{
         id:upArrow
         anchors.top: scrollbar.top
         source: "../../images/up-arrow.png"
         MouseArea{
             anchors.fill:parent
         }

    }
    //down arrow
    Image{
         id:downArrow
         anchors.bottom: scrollbar.bottom
         source: "../../images/dn-arrow.png"
         MouseArea{
             anchors.fill:parent
         }

    }
    Rectangle {
        id: handle;
        height: (scrollbar.height * flickable.visibleArea.heightRatio);
        color: "darkgray"
        border {
            width: 1;
            color: "white";
        }
        anchors {
            left: parent.left;
            right: parent.right;
        }

        Binding { // Calculate handle's x/y position based on the content position of the Flickable
            target: handle;
            property: "y";
            value: (flickable.visibleArea.yPosition * scrollbar.height);
            when: (!dragger.drag.active);
        }
        Binding { // Calculate Flickable content position based on the handle x/y position
            target: flickable;
            property: "contentY";
            value: (handle.y / scrollbar.height * flickable.contentHeight);
            when: (dragger.drag.active);
        }
        MouseArea {
            id: dragger;
            anchors.fill: parent;
            drag {
                target: handle;
                minimumX: handle.x;
                maximumX: handle.x;
                minimumY: 0 + upArrow.height + 100;
                maximumY: (scrollbar.height - handle.height - downArrow.height);
                axis: Drag.YAxis;
            }
        }
    }
}
