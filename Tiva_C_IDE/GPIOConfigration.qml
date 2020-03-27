import QtQuick 2.9
import QtQuick.Layouts 1.3

Item {
    id: gpio
    property var gpioconfigration: {"PULLUP_RESISTOR": "NULL","PULLDOWN_RESISTOR": "NULL"}
    Rectangle {
        id: configrations
        anchors.centerIn: parent
        height: parent.height
        width: parent.width
        border.color: "black"
        border.width: 2
        radius: 10
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightsteelblue" }
            GradientStop { position: 1.0; color: "dark cyan" }
        }
        GridLayout{
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: parent.height*0.07
            anchors.leftMargin: parent.width*0.07
            columns: 2
            rows: 2
            columnSpacing: 5
            rowSpacing: 15
            Text {
                text: "PullUp Resistor:"
                font.bold: true
                //font.family: "Comic Sans MS"
                Layout.row: 0
                Layout.column: 0
            }
            Text {
                text: "PullDown Resistor:"
                font.bold: true
                //font.family: "Comic Sans MS"
                Layout.row: 1
                Layout.column: 0
            }
            CustomizingComboBox {
                id: pullup
                Layout.row: 0
                Layout.column: 1
                model: ["Disable","Enable"]
            }
            CustomizingComboBox {
                id: pulldown
                Layout.row: 1
                Layout.column: 1
                model: ["Disable","Enable"]
            }
        }
        Rectangle {
            id: submit
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 60
            z: 10
            color: "black"
            border.color: "orange"
            border.width: 2
            width: 100
            height: 40
            radius: width/15
            Text {
                anchors.centerIn: parent
                color: "orange"
                text: "Submit"
                font.pixelSize: parent.height * 0.4
                font.family: "Comic Sans MS"
            }
            MouseArea {
                id: mousesub
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                hoverEnabled: true
                onEntered: {
                    parent.color = "gray"
                }
                onExited: {
                    parent.color = "black"
                }
                onClicked: {
                    gpio.gpioconfigration["PULLUP_RESISTOR"] = pullup.currentText
                    gpio.gpioconfigration["PULLDOWN_RESISTOR"] = pulldown.currentText
                }
            }
        }
    }
}
