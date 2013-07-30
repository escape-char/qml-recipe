import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

ApplicationWindow{
    id: appWindow
    width:950
    height:680
    visible: true

    Dialog{
        id: dialog
        contentHeight: 600
        contentWidth: 400

        Column{
            anchors.fill: parent
            spacing: 15
            anchors.margins:30
            Text{
                id: recipeDialogTitle
                font { bold: true; family: "Helvetica"; pointSize: 18 }
                text: "Add Recipe"
            }
            //title
            Text{
                text: "Title"
                width:50
            }
            TextInput{
               width: 50
               text: "enter a title"
               color: "gray"
            }
            //description
            Text{

            }
        }

    }

    MainMenu{
        id: mainMenu
        onRecipeBtnClick: dialog.show()

    }

    SplitView{
        id: mainSplitView
        height:parent.height
        width: parent.width - mainMenu.width
        anchors.left: mainMenu.right
        visible:true
        resizing: true
        orientation: Qt.Horizontal

        //left panel
        Rectangle{
            height: parent.height
            Layout.minimumWidth: 120
            Layout.maximumWidth: 140
            CategoryPanel{}
        }
        //middle panel
        Rectangle{
            height:parent.height
            width: 250
            Layout.minimumWidth:200
            Layout.maximumWidth:620
            RecipeList{}
        }
        //right panel
        Rectangle{
            color: "lightgray"
            height:parent.height;
            Layout.minimumWidth: 300
            Layout.fillWidth: true

        }

    }


}
