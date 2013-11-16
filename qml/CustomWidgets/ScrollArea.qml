import QtQuick 2.0
import QtQuick.Controls 1.0

Item {
    //
    property int margins: 0
    property int contentWidth: content.childrenRect.width
    property int contentHeight: content.childrenRect.height
    property alias color: background.color
    height:300
    width:300

    //this makes it so that any new children added to this item
    //is added as childen to the scroll area
    default property alias children: content.children

    //background
    Rectangle{
        id:background
        color: "transparent"
        anchors.fill:parent
    }
    ScrollBar{
        id:scrollBar
        target:scrollArea
    }

    //ScrollArea
    Flickable{
        id:scrollArea
        clip:true
        anchors.fill:parent
        contentWidth: content.childrenRect.width
        contentHeight:content.childrenRect.height
        boundsBehavior: Flickable.StopAtBounds

        //margins
        Item{
            id:scrollAreaMargins
            anchors.fill:parent
            anchors.margins: margins

            //content
            Item{
                id:content
            }
        }
    }
}
