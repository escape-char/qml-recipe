import QtQuick 2.0

 Item {
     id: delegate

     property int itemHeight: 130
     property int imageSize: 75
     property int imageRightOffset: 15
     property string borderColor: "#cccccc"

     height: itemHeight
     width: delegate.ListView.view.width

     Column {
         height: parent.height
         Rectangle {
             height: parent.height
             width: 40
             color: "red"
         }
     }

     Column {
         id: column
         x: 10; y: 10
         width: parent.width - 40

         Image {
             id: img
             width: imageSize; height: imageSize
             source: image
         }

         //Title
         Text {
             id: titleText
             text: name; width: parent.width; wrapMode: Text.WordWrap
             font { bold: true; family: "Helvetica"; pointSize: 16 }
             anchors.left: img.right
             anchors.top: parent.top
             anchors.leftMargin: imageRightOffset
         }

         //Description
         Text {
             id: descriptionText
             width: parent.width
             text: description
             wrapMode: Text.WordWrap; font.family: "Helvetica"
             anchors.top: titleText.bottom
             anchors.topMargin: 10
             anchors.left: img.right
             anchors.leftMargin: imageRightOffset

         }

        //Difficulty
         Row {
             Text {
                 id: difficultyText
                 width: parent.width
                 text: difficulty
                 wrapMode: Text.WordWrap; font.family: "Helvetica"
                 anchors.top: descriptionText.bottom
                 anchors.left: img.right
                 anchors.leftMargin: imageRightOffset
             }

             //Duration
             Text {
                 id: durationText
                 width: parent.width
                 height: 40
                 text: duration
                 wrapMode: Text.WordWrap; font.family: "Helvetica"
                 anchors.left: difficultyText.right
             }

             anchors.top: descriptionText.bottom
             anchors.topMargin: 10
             anchors.left: img.right
             anchors.leftMargin: imageRightOffset
         }

     }

    //Bottom Border
     Rectangle {
         width: parent.width; height: 1; color: borderColor
         anchors.bottom: parent.bottom
     }
 }
