import QtQuick 2.0
import QtQuick.Controls 1.0

//Item Container
Rectangle {
    id: listitem
    width: 400
    height: 250
    color: "#EAEAEA"
    smooth: true

    Row {
        height: parent.height
        width: parent.width
        Column {
            height: parent.height

            Rectangle {
                color: "#D6D6D6"
                height: parent.height
                width: 20

                CheckBox{
                    id: listitemcheck
                }
            }
        }

        Column {
            Image {
                id: listitemimage
                source: "../../100x100.gif"
                height: 125
                width: 125
                asynchronous: true
            }

            Rectangle {
                height: parent.height
                width: parent.weight - 20
                Text {
                    id:listitemtitle
                    font.bold: true
                    font.pixelSize: 18
                    text: "Hello world"
                }
            }
        }
    }
}

