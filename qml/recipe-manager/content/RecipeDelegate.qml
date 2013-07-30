import QtQuick 2.0
import QtQuick.Controls 1.0

 Item {
    id: delegate


    //property to access recipe data from other compontents
    property variant recipeData: model

    property int itemHeight: 110
    property int imageSize: 75
    property int checkBoxWidth: 10
    property int imageHorizMargin: 10
    property string borderColor: "#B8B8B8"

    height: itemHeight
    width: delegate.ListView.view.width

    Rectangle {
        height: parent.height; width: parent.width
        color: delegate.ListView.isCurrentItem ? "#DCE0B8" : "#EBEBEB"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                delegate.ListView.view.currentIndex = index
            }
        }

        //checkbox
        Rectangle {
            id: checkBoxContainer
            height: parent.height
            width: checkBoxWidth
            color: "transparent"

            anchors.left: parent.left

            CheckBox {
                anchors.top: parent.top
                anchors.topMargin: 40
                anchors.left: parent.left
                anchors.leftMargin: 3
            }
        }

        Image {
            id: img
            width: imageSize; height: imageSize
            source: image

            anchors.left: checkBoxContainer.right
            anchors.leftMargin: imageHorizMargin
            anchors.top: parent.top
            anchors.topMargin: 10
        }

        Rectangle {
            width: parent.width -imageSize - (imageHorizMargin*2) - checkBoxWidth

            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: img.right
            anchors.leftMargin: imageHorizMargin

            //Title
            Text {
                id: titleText
                width: parent.width
                height: 20
                text: title
                wrapMode: Text.WordWrap
                font { bold: true; family: "Helvetica"; pointSize: 12 }
            }

            //Rating
            Rectangle {
                id: ratingWidget
                height: 25
                width: parent.width - 10
                color: "lightgrey"

                anchors.top: titleText.bottom
                anchors.topMargin: 7
            }

            Rectangle {
                width: parent.width
                height: 30

                color: "transparent"

                anchors.top: ratingWidget.bottom
                anchors.topMargin: 4

                //Difficulty
                Text {
                     id: difficultyText
                     width: 50
                     text: difficulty
                     color: "#787878"
                     wrapMode: Text.WordWrap; font.family: "Helvetica"; font.pointSize: 10
                }

                 //Duration
                 Text {
                     id: durationText
                     width:  50
                     height: 40
                     text: duration
                     color: "#787878"
                     wrapMode: Text.WordWrap; font.family: "Helvetica"; font.pointSize: 10
                     anchors.left: difficultyText.right
                 }
            }
        }
    }

    //Bottom Border
    Rectangle {
     width: parent.width; height: 1; color: borderColor
     anchors.bottom: parent.bottom
    }
 }
