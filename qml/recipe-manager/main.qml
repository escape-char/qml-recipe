import QtQuick 2.0

Rectangle {
    width: 400
    height: 450
    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
    ListView{
        id: listview
        anchors.fill:parent
        delegate:RecipeDelegate{}
        model:recipeModel
    }
}
