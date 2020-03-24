import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

Item {
    Rectangle {
        id: configrations
        anchors.centerIn: parent
        height: parent.height
        width: parent.width
        border.color: "black"
        radius: width/20
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightsteelblue" }
            GradientStop { position: 1.0; color: "dark cyan" }
        }
           GridLayout{
               anchors.left: parent.left
               anchors.top: parent.top
               anchors.topMargin: 50
               anchors.leftMargin: 25
               columns: 3
               rows: 5
               columnSpacing: 15
               rowSpacing: 15
               Text {
                   text: "BoudRate:"
                   font.bold: true
                   font.family: "Comic Sans MS"
                   Layout.row: 0
                   Layout.column: 0
               }
               Text {
                   text: "ParityEnable:"
                   font.bold: true
                   font.family: "Comic Sans MS"
                   Layout.row: 1
                   Layout.column: 0
               }
               CustomizingComboBox {
                   Layout.row: 0
                   Layout.column: 1
                   model: ["115200","9600"]
               }
               CustomizingComboBox {
                   Layout.row: 1
                   Layout.column: 1
                   model: ["Disable","Enable"]
               }
           }
        }
}
