import QtQuick 2.0
import QtQuick.Controls 1.0
import Widgets 1.0

 Item {
    id: recipeDelegate

    //property to access recipe data from other compontents
    property variant recipeData: model

    property int itemHeight: 100
    property int imageSize: 75
    property int checkBoxWidth: 10
    property int imageHorizMargin: 10
    property color borderColor: "#B8B8B8"
    property color backgroundColor: "#f3f3f3"
    property color activeBackgroundColor: "#f3f3f3"

    property color titleColor: "#454545"
    property color descriptionColor: "#888"

    /*Margins */
    property int topMargin: 10
    property int rightMargin: 10
    property int leftMargin: 10

    signal recipeClicked()

    height: itemHeight
    width: 300

    Rectangle {width: parent.width; height: itemHeight; color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor}

    Row {
        height: itemHeight
        spacing: 10



        MouseArea {
            id: mousearea
            anchors.fill: parent
            onClicked: {
                recipeDelegate.ListView.view.currentIndex = index
                recipeClicked()
            }
        }


        Component.onCompleted: {
            mousearea.clicked.connect(recipeClicked)
            console.log(recipeData.title)
        }

        Rectangle {
            height:parent.height
            color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor
            width: 1;

        }

        Rectangle {
            height: 85
            width: 85
            color: "#BFBFBF"
            anchors {top: parent.top; topMargin: topMargin}
            //Image {
            //    id: img
            //    width: imageSize; height: imageSize
            //}



        }

        Rectangle {
            width: 185;
            height: parent.height;
            color: recipeDelegate.ListView.isCurrentItem ? activeBackgroundColor : backgroundColor
            anchors {top: parent.top; topMargin: topMargin}

            Text {
                id: titleText
                height: 20
                width: parent.width
                text: title
                color: titleColor
                wrapMode: Text.WordWrap
                font { bold: true; pointSize: 12 }

            }

            Rectangle {
                id:ratingWidget
                height:30
                width: parent.width
                visible:true
                Rating{
                    fillColor: backgroundColor

                    anchors.fill:parent;
                    x: 0
                    y: 0
                    size:8
                }
            }

            Text {
                id: descriptionText
                height:20
                width: 200
                text: description
                color: descriptionColor
                wrapMode: Text.WordWrap
                font { pointSize: 11 }
            }
         }



                //rating

                /*Item {
                    width: parent.width
                    height: 30

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
                         text: duration
                         color: "#787878"
                         wrapMode: Text.WordWrap; font.family: "Helvetica"; font.pointSize: 10
                         anchors.left: difficultyText.right
                     }
                }
            } */
      }

    Rectangle { height: 1; width: parent.width; color: "#ddd"; anchors.bottom: parent.bottom; }
 }
