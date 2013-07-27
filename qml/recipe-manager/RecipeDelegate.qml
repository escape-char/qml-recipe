import QtQuick 2.0

Item {
    id:delegate
    width: delegate.ListView.view.width
    height: 30
    anchors.margins:4
   Row{
        anchors.margins:4
        anchors.fill:parent
        spacing:4
        Text{
            text:name
            width:60
            color:"pink"
        }
        Text{
            text:description
            width:120
            color:"blue"
        }
        Text{
            text:difficulty
            width:50
            color:"red"
        }
        Text{
            text:timestamp
            width: 30
            color:"green"
        }
    }
}
