import QtQuick 2.0
import QtQuick.Controls 1.0
Dialog {
    contentHeight: 600
    contentWidth:500

    Rectangle{
        id: addRecipeContent
        width:parent.width - 25
        height: parent.height -25
        anchors.centerIn:parent
        Text{
            text: "Add Recipe"
            font{pointSize: 20; bold: true}
        }
    }
}
