import QtQuick 2.9
import QtQuick.Layouts 1.3

Item {
    id: uart
    property var uartconfigration: {"UART_BoudRate": "NULL","UART_FIFO": "NULL","UART_HighSpeed": "NULL","UART_Parity": "NULL","UART_StopBits": "NULL"}
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
            anchors.topMargin: parent.height*0.1
            anchors.leftMargin: parent.width*0.1
            columns: 2
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
                text: "Parity:"
                font.bold: true
                font.family: "Comic Sans MS"
                Layout.row: 1
                Layout.column: 0
            }
            Text {
                text: "Stop Bits:"
                font.bold: true
                font.family: "Comic Sans MS"
                Layout.row: 2
                Layout.column: 0
            }
            Text {
                text: "High Speed:"
                font.bold: true
                font.family: "Comic Sans MS"
                Layout.row: 3
                Layout.column: 0
            }
            Text {
                text: "FIFO:"
                font.bold: true
                font.family: "Comic Sans MS"
                Layout.row: 4
                Layout.column: 0
            }
            CustomizingComboBox {
                id: boudrate
                Layout.row: 0
                Layout.column: 1
                model: ["230400","115200","57600","38400","19200","9600","4800","2400","1200"]
            }
            CustomizingComboBox {
                id: parity
                Layout.row: 1
                Layout.column: 1
                model: ["None","Even","Odd"]
            }
            CustomizingComboBox {
                id: stopbits
                Layout.row: 2
                Layout.column: 1
                model: ["1","2"]
            }
            CustomizingComboBox {
                id: highspeed
                Layout.row: 3
                Layout.column: 1
                model: ["Disable","Enable"]
            }
            CustomizingComboBox {
                id: fifo
                Layout.row: 4
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
                    uart.uartconfigration["UART_BoudRate"] = boudrate.currentText
                    uart.uartconfigration["UART_FIFO"] = fifo.currentText
                    uart.uartconfigration["UART_HighSpeed"] = highspeed.currentText
                    uart.uartconfigration["UART_Parity"] = parity.currentText
                    uart.uartconfigration["UART_StopBits"] = stopbits.currentText
                }
            }
        }
    }
}
