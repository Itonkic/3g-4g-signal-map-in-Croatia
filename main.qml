import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import QtLocation 5.6
import QtPositioning 5.6

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Pokrivenost Signalom")
    header: ToolBar {
        RowLayout{
        ToolButton {
            text:"Filter"
            onClicked: sortMenu.open()
        }
        ToolButton {
            text: "Legenda"
            onClicked: tmobile.legendaON = !tmobile.legendaON
        }
        }
    }
    Menu {
        id:sortMenu
        title: "Edit"

            MenuItem {
                text: "4G"
                checkable: true
                checked: true
            }

            MenuItem {
                text: "3G"
                checkable: true
            }

            MenuItem {
                text: "2G"
                checkable: true
            }
    }
    ButtonGroup
    {
        id: sortSelection
        buttons: sortMenu.contentChildren
    }

    Tmobile
    {
        id:tmobile
        anchors.fill: parent
        currentSelection: sortSelection.checkedButton.text
    }
}
