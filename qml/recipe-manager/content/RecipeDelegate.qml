import QtQuick 2.0
import QtQuick.Controls 1.0
import Widgets 1.0

 Item {
    id: recipeDelegate

    //property to access recipe data from other compontents
    property variant recipeData: model

    property int itemHeight: 100
    property int itemWidth: parent.width
    property int imageSize: 75
    property int checkBoxWidth: 10
    property int imageHorizMargin: 10
    property color borderColor: "#B8B8B8"
    property color backgroundColor: "#fafafa"
    property color activeBackgroundColor: "#F2F2F2"

    property color titleColor: "#358C91"
    property color descriptionColor: "#888"

    /*Margins */
    property int topMargin: 10
    property int rightMargin: 10
    property int leftMargin: 10

    height: itemHeight
    width: itemWidth

    Rectangle {
        id:background
        width: itemWidth;
        height: itemHeight;
        color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor;

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                recipeDelegate.ListView.view.currentIndex =  index;
            }
        }

    }
    Row {
        height: itemHeight
        spacing: 10


        Rectangle {
            height:parent.height
            color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor
            width: 1;

        }

        //image
        Rectangle {
            height: 85 - topMargin
            width: 85
            anchors {top: parent.top; topMargin: topMargin}
            Image {
               id: img
               source: image
               sourceSize.height: imageSize
               sourceSize.width: imageSize
               Component.onCompleted: {
               }
            }

        }

        Rectangle {
            width: 300;
            height: itemHeight-topMargin;
            color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor

            Text {
                id: titleText
                width: itemWidth
                text: title
                color: titleColor
                wrapMode: Text.WordWrap
                font { bold: true; pointSize: 12 }
                anchors {top: parent.top}

            }

            Text {
                id: descriptionText
                height:20
                width: itemWidth
                text: description
                color: descriptionColor
                wrapMode: Text.WordWrap
                font { pointSize: 11 }
                anchors {top: titleText.bottom; topMargin: 7}
            }

            //Difficulty
            Text {
                 id: difficultyText
                 width: 200
                 text: "Difficulty: " + difficulty
                 color: "#aaa"
                 wrapMode: Text.WordWrap; font.pointSize: 8
                 anchors {top: descriptionText.bottom; topMargin: 10}
            }
            Text {
                 id: durationText
                 width: 200
                 text: "Duration: : " + duration
                 color: "#aaa"
                 wrapMode: Text.WordWrap; font.pointSize: 8
                 anchors {top:difficultyText.top;}
            }
         }

        Rectangle {
            id:ratingWidget
            height:40
            width: itemWidth - 300 - 85
            visible:true
            color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor

            Rating{
                anchors.fill: parent
                fillColor: "gold"
                selected: rating

                x: 0
                y: 0
                size:11
            }
            anchors{top: parent.top; topMargin: topMargin}
        }
      }

    Rectangle { height: 1; width: parent.width; color: "#ddd"; }
    Component.onCompleted: {
        recipeDelegate.ListView.view.currentIndex = -1;
    }
 }
