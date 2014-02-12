import QtQuick 2.0

BorderImage {
        property variant target

        //source: "../../images/scrollbar.png"
        border {left: 0; top: 0; right: 0; bottom: 0}
        width: 15

        anchors {top: target.top; bottom: target.bottom; right: target.right }
        visible: (track.height == slider.height) ? false : true //TODO: !visible -> width: 0 (but creates a binding loop)
        z: target.z + 1
        clip:true

        //scroll container
        Item {
                anchors {fill: parent; margins: 1; rightMargin: 5; bottomMargin: 3}
                Image {
                    id: upArrow
                    //source: "../../images/up-arrow.png"
                    anchors.top: parent.top
                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            timer.scrollAmount = -10
                            timer.running = true;
                        }
                        onReleased: {
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
                                        timer.running = true;


                                }
                                onReleased: {
                                        timer.running = false;
                               }
                        }



                        //slider for scroll bar
                        Rectangle {
                                id:slider
                                color: Qt.rgba(0, 0, 0, 0.20)
                                border.color: Qt.rgba(0,0, 0, 0.25)
                                border.width: 1
                                radius: 5
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
                                                        target.contentY = slider.y * target.contentHeight / track.height
                                                }
                                        }
                                }
                        }
                }
                Image {
                    id: dnArrow
                    //source: "../../images/dn-arrow.png"
                    anchors.bottom: parent.bottom
                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            timer.scrollAmount = 10
                            timer.running = true;
                        }
                        onReleased: {
                            timer.running = false;
                        }
                    }
                }
        }
}
