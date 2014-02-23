import QtQuick 2.1
import QtQuick.Dialogs 1.0

FileDialog{
    id: fileDialog
    title: "Please choose an Image"
    nameFilters: [ "Image files (*.jpg *.png)"]
    onAccepted: {
        console.log("You chose: " + fileDialog.fileUrls)
    }
    onRejected: {
        console.log("Canceled")
    }
    Component.onCompleted: visible = true
}
