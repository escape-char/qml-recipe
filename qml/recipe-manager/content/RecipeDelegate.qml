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
    property color activeBackgroundColor: "#fafafa"

    property color titleColor: "#358C91"
    property color descriptionColor: "#888"

    property int  borderWidth: 1;

    /*Margins */
    property int topMargin: 10
    property int rightMargin: 10
    property int leftMargin: 10

    signal clicked()

    height: itemHeight
    width: itemWidth

    Rectangle {width: itemWidth; height: itemHeight; color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor}

    //Borders
    Rectangle { height: 1; width: itemWidth; color: "#bbb"; anchors.bottom: parent.bottom; }

    MouseArea {
        id: mousearea
        anchors.fill: parent
    }

    Component.onCompleted: {
        mousearea.clicked.connect(clicked)
    }

    //Image
    Rectangle {
        id: imageContainer
        height: 85 - topMargin
        width: 85
        color: "#BFBFBF"
        anchors {top: parent.top; topMargin: topMargin; left: parent.left; leftMargin: leftMargin;}
        //Image {
        //    id: img
        //    width: imageSize; height: imageSize
        //}
    }

    //Title
    Text {
        id: titleText
        width: itemWidth - imageContainer.width - leftMargin*2
        text: title
        color: titleColor
        wrapMode: Text.WordWrap
        font { bold: true; pointSize: 12 }
        elide: Text.ElideRight
        maximumLineCount: 1
        anchors {top: parent.top; topMargin: topMargin; left: imageContainer.right; leftMargin: leftMargin;}
    }

    //Description
    Text {
        id: descriptionText
        height:20
        width: 180
        text: description
        color: descriptionColor
        wrapMode: Text.WordWrap
        maximumLineCount : 1
        elide: Text.ElideRight
        font { pointSize: 11 }
        anchors {top: titleText.bottom; topMargin: 7; left: imageContainer.right; leftMargin: leftMargin;}
    }

    //Difficulty
    Text {
         id: difficultyAndDurationText
         width: 200
         text: "Difficulty: " + difficulty + " Duration: " + duration
         color: "#aaa"
         wrapMode: Text.WordWrap;
         font.pointSize: 8
         anchors {top: descriptionText.bottom; topMargin: 10; left: imageContainer.right; leftMargin: leftMargin}
    }

    /*Rectangle {
        id:ratingWidget
        height:40
        width: itemWidth - 300 - 85 - borderWidth
        visible:true
        color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor

        Rating{
            anchors.fill: parent
            fillColor: "gold"

            x: 0
            y: 0
            size:11
        }
        anchors{top: parent.top; topMargin: topMargin}
        } */
 }
