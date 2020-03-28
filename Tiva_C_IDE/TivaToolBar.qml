import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls 2.14
import QtQuick.Controls.Styles 1.4

Rectangle {
    color: "#222831"
    property int iconHeight: 50
    property int iconWidth: 50
    property int  iconMargin: 10
    signal saveFile()

    RowLayout {
        id : rowLayout
        anchors.fill: parent
        anchors.margins: iconMargin
        TivaButton{
            id : burn
            imageSource : "icons/tiva1.png"
            onClick: {console.log("Burn on CPU !")}
        }
        TivaButton{
            id : save
            imageSource : "icons/save.png"
            anchors.left: burn.right
            onClick: {console.log("Saved !") ; saveFile();}
        }
        TivaButton{
            id : debug
            imageSource : "icons/debug.png"
            anchors.left: save.right
            onClick: {console.log("Debug mode") }

        }

        Rectangle {
            id : tivaText
            color: "#222831"
            Layout.preferredWidth:  300
            Layout.preferredHeight:  parent.height
            Layout.alignment: Qt.AlignRight
            Text {
                id: textTiva
                text: qsTr("TIVA C  IDE")
                anchors.centerIn: parent

                color: "#b55400"
                font.weight: Font.Black
                font.pointSize: 30
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: textTiva.color = "#eeeeee";
                    onExited: textTiva.color = "#b55400";

                }
            }
        }


    }
}
