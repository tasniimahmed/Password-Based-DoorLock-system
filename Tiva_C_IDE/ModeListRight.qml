import QtQuick 2.0

ListModel {

    //port B modes from 3 to 7

    ListElement {
        name: "Input"
        property int list_index: 0
    }
    ListElement {
        name: "Output"
        property int list_index: 1
    }
    // PB3
    ListElement {
        name: "I2C0SDA"
        property int list_index: 2
    }
    ListElement {
        name: "T3CCP1"
        property int list_index: 3
    }
    // PB4
    ListElement {
        name: "AIN10"
        property int list_index: 2
    }
    ListElement {
        name: "SSI2Clk"
        property int list_index: 3
    }
    ListElement {
        name: "M0PWM2"
        property int list_index: 4
    }
    ListElement {
        name: "T1CCP0"
        property int list_index: 5
    }
    ListElement {
        name: "CAN0Rx"
        property int list_index: 6
    }
    // PB5
    ListElement {
        name: "AIN11"
        property int list_index: 2
    }
    ListElement {
        name: "SSI2Fss"
        property int list_index: 3
    }
    ListElement {
        name: "M0PWM3"
        property int list_index: 4
    }
    ListElement {
        name: "T1CCP1"
        property int list_index: 5
    }
    ListElement {
        name: "CAN0Tx"
        property int list_index: 6
    }
    // PB6
    ListElement {
        name: "SSI2Rx"
        property int list_index: 2
    }
    ListElement {
        name: "M0PWM0"
        property int list_index: 3
    }
    ListElement {
        name: "T0CCP0"
        property int list_index: 4
    }
    // PB7
    ListElement {
        name: "SSI2Tx"
        property int list_index: 2
    }
    ListElement {
        name: "M0PWM1"
        property int list_index: 3
    }
    ListElement {
        name: "T0CCP1"
        property int list_index: 4
    }

    //port C modes from 4 to 7

    // PC4
    ListElement {
        name: "C1-"
        property int list_index: 2
    }
    ListElement {
        name: "U4Rx"
        property int list_index: 3
    }
    ListElement {
        name: "U1Rx"
        property int list_index: 4
    }
    ListElement {
        name: "M0PWM6"
        property int list_index: 5
    }
    ListElement {
        name: "IDX1"
        property int list_index: 6
    }
    ListElement {
        name: "WT0CCP0"
        property int list_index: 7
    }
    ListElement {
        name: "U1RTS"
        property int list_index: 8
    }
    // PC5
    ListElement {
        name: "C1+"
        property int list_index: 2
    }
    ListElement {
        name: "U4Tx"
        property int list_index: 3
    }
    ListElement {
        name: "U1Tx"
        property int list_index: 4
    }
    ListElement {
        name: "M0PWM7"
        property int list_index: 5
    }
    ListElement {
        name: "PhA1"
        property int list_index: 6
    }
    ListElement {
        name: "WT0CCP1"
        property int list_index: 7
    }
    ListElement {
        name: "U1CTS"
        property int list_index: 8
    }
    // PC6
    ListElement {
        name: "C0+"
        property int list_index: 2
    }
    ListElement {
        name: "U3Rx"
        property int list_index: 3
    }
    ListElement {
        name: "PhB1"
        property int list_index: 4
    }
    ListElement {
        name: "WT1CCP0"
        property int list_index: 5
    }
    ListElement {
        name: "USB0EPEN"
        property int list_index: 6
    }
    // PC7
    ListElement {
        name: "C0-"
        property int list_index: 2
    }
    ListElement {
        name: "U3Tx"
        property int list_index: 3
    }
    ListElement {
        name: "WT1CCP1"
        property int list_index: 4
    }
    ListElement {
        name: "USB0PFLT"
        property int list_index: 5
    }
}
