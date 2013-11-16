import QtQuick 2.0

BorderImage {
        property variant target

        source: "../../images/scrollbar.png"
        border {left: 0; top: 3; right: 0; bottom: 3}
        width: 17

        anchors {top: target.top; bottom: target.bottom; right: target.right }
        visible: (track.height == slider.height) ? false : true //TODO: !visible -> width: 0 (but creates a binding loop)
        z: target.z + 1
        clip:true

        //scroll container
        Item {
                anchors {fill: parent; margins: 1; rightMargin: 2; bottomMargin: 2}

                Image {
                        id: upArrow
                        source: "../../images/up-arrow.png"
                        anchors.top: parent.top
                        MouseArea {
                                anchors.fill: parent
                                preventStealing: true
                                onPressed: {
                                        console.log("SCROLLBAR: pressed up-arrow")
                                        timer.scrollAmount = -10
                                        timer.running = true;
                                }
                                onReleased: {
                                        console.log("SCROLLBAR: released up-arrow")
                                        timer.running = false;
                                }
                        }
                }

                //timer to keep scrolling when clicking arrows
                //or pressing tracks
                Timer {
                        property int scrollAmount

                        id: timer
                        repeat: true
                        interval: 20
                        onTriggered: {
                                target.contentY = Math.max(
                                                0, Math.min(
                                                target.contentY + scrollAmount,
                                                target.contentHeight - target.height));
                        }
                }
                //scrollbar track
                Item {
                        id: track
                        anchors {top: upArrow.bottom; topMargin: 1; bottom: dnArrow.top;}
                        width: parent.width
                        height: parent.height
                        MouseArea {
                                anchors.fill: parent
                                preventStealing:true

                                onPressed: {
                                        timer.scrollAmount = target.height * (mouseY < slider.y ? -1 : 1)       // scroll by a page
                                        console.log("SCROLLBAR: pressed on scrollbar")
                                        timer.running = true;


                                }
                                onReleased: {
                                        timer.running = false;
                               }
                        }

                        //slider for scroll bar
                        BorderImage {
                                id:slider

                                source: "../../images/slider.png"
                                border {left: 0; top: 3; right: 0; bottom: 3}
                                width: parent.width

                                height: Math.min(target.height / target.contentHeight * track.height, track.height)
                                y: target.visibleArea.yPosition * track.height

                                MouseArea {
                                        anchors.fill: parent
                                        drag.target: parent
                                        drag.axis: Drag.YAxis
                                        drag.minimumY: 0
                                        drag.maximumY: track.height - height
                                        preventStealing: true

                                        onPositionChanged: {
                                                if (pressedButtons == Qt.LeftButton) {
                                                        console.log("SCROLLBAR: moved slider to y position " + slider.y.toString())
                                                        target.contentY = slider.y * target.contentHeight / track.height
                                                }
                                        }
                                }
                        }
                }
                Image {
                        id: dnArrow
                        source: "../../images/dn-arrow.png"
                        anchors.bottom: parent.bottom
                        MouseArea {
                                anchors.fill: parent
                                preventStealing: true
                                onPressed: {
                                        console.log("SCROLLBAR: pressed down arrow")
                                        timer.scrollAmount = 10
                                        timer.running = true;
                                }
                                onReleased: {
                                        console.log("SCROLLBAR: released down arrow")
                                        timer.running = false;
                                }
                        }
                }
        }
}
