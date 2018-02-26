import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1
import QtLocation 5.6
import QtPositioning 5.6
import "tmobilecov.js" as TC

Item
{
    property string currentSelection: "4G"
    property var currentData: TC.getData(currentSelection)
    property bool legendaON: true
    Plugin
    {
        id: osmPlugin
        name: "osm"
    }
    Map {
        anchors.fill: parent
        id: map
        plugin: osmPlugin
        zoomLevel: 10
        center {
            latitude: 46.3057
            longitude: 16.3366
        }
        MapRectangle
        {
            id:rect
            color: 'transparent'
            border.width: 0
            topLeft {
                latitude: currentData.N //46.665780491
                longitude: currentData.W //10.411622632
            }
            bottomRight {
                latitude: currentData.S //42.09436183
                longitude: currentData.E //22.66014675
            }
        }
        Image
        {
            id: image
            source: currentData.ImgUrl.replace("https","http") // "http://tc.t-com.hr/gsmcoveragesvc/WebResources/GSMCoverageMaps/Img/googleMap_G38_2017-03-10/4G_Desktop.png"
            anchors.fill: rect
            opacity: prozirnost.value
        }

    }


   Rectangle
    {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left:  parent.left
        color: "white"
        height:  legendView.height
        visible: legendaON
        ListView {
            property var legende: {
                "4G": [
                    ["150 Mbps", "#e20074"],
                    ["225 Mbps", "#427bab"],
                    ["262.5 Mb", "#64b9e4"]
                 ],
                "3G": [
                    ["7.2 Mbps", "#0070ff"],
                    ["42.2 Mbps", "#38a800"]
                ],
                "2G": [
                    ["240 kbps", "#ffff01"]
                ]
            }
            id:legendView
            model: legende[currentSelection]
            delegate: Row {
                spacing: 5
                Label {
                    text: " " }
                Rectangle {
                    height: opisLabel.height * 0.8
                    width: height
                    anchors.verticalCenter: opisLabel.verticalCenter
                    color:  modelData[1]
                }
                Label {
                    id: opisLabel
                    text:" "+ modelData[0] + " "
                }
            }
            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            height: 50
        }
        Slider
        {
            id: prozirnost
            from: 0.0
            to: 1.0
            stepSize: 0.05
            value: 0.8
            width: parent.width / 2
            anchors.left: parent.horizontalCenter
            anchors.right: parent.right
        }

    }
}
