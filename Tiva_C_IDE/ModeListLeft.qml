import QtQuick 2.0

ListModel {

    //port E modes from 2 to 7

    ListElement {
        name: "Input"
        property int list_index: 0
    }
    ListElement {
        name: "Output"
        property int list_index: 1
    }
    // PE2
    ListElement {
        name: "AIN1"
        property int list_index: 2
    }
    // PE3
    ListElement {
        name: "AIN0"
        property int list_index: 2
    }
    // PE4
    ListElement {
        name: "AIN9"
        property int list_index: 2
    }
    ListElement {
        name: "U5Rx"
        property int list_index: 3
    }
    ListElement {
        name: "I2C2SCL"
        property int list_index: 4
    }
    ListElement {
        name: "M0PWM4"
        property int list_index: 5
    }
    ListElement {
        name: "M1PWM2"
        property int list_index: 6
    }
    ListElement {
        name: "CAN0Rx"
        property int list_index: 7
    }
    // PE5
    ListElement {
        name: "AIN8"
        property int list_index: 2
    }
    ListElement {
        name: "U5Tx"
        property int list_index: 3
    }
    ListElement {
        name: "I2C2SDA"
        property int list_index: 4
    }
    ListElement {
        name: "M0PWM5"
        property int list_index: 5
    }
    ListElement {
        name: "M1PWM3"
        property int list_index: 6
    }
    ListElement {
        name: "CAN0Tx"
        property int list_index: 7
    }

    //port F modes from 0 to 4

    // PF0
    ListElement {
        name: "AIN3"
        property int list_index: 2
    }
    ListElement {
        name: "SSI1Rx"
        property int list_index: 3
    }
    ListElement {
        name: "CAN0Rx"
        property int list_index: 4
    }
    ListElement {
        name: "M1PWM4"
        property int list_index: 5
    }
    ListElement {
        name: "PhA0"
        property int list_index: 6
    }
    ListElement {
        name: "T0CCP0"
        property int list_index: 7
    }
    ListElement {
        name: "NMI"
        property int list_index: 8
    }
    ListElement {
        name: "C0o"
        property int list_index: 9
    }
    // PF1
    ListElement {
        name: "U1CTS"
        property int list_index: 2
    }
    ListElement {
        name: "SSI1Tx"
        property int list_index: 3
    }
    ListElement {
        name: "M1PWM5"
        property int list_index: 4
    }
    ListElement {
        name: "PhB0"
        property int list_index: 5
    }
    ListElement {
        name: "T0CCP1"
        property int list_index: 6
    }
    ListElement {
        name: "C1o"
        property int list_index: 7
    }
    ListElement {
        name: "TRD1"
        property int list_index: 8
    }
    // PF2
    ListElement {
        name: "SSI1Clk"
        property int list_index: 2
    }
    ListElement {
        name: "M0FAULT0"
        property int list_index: 3
    }
    ListElement {
        name: "M1PWM6"
        property int list_index: 4
    }
    ListElement {
        name: "T1CCP0"
        property int list_index: 5
    }
    ListElement {
        name: "TRD0"
        property int list_index: 6
    }
    // PF3
    ListElement {
        name: "SSI1Fss"
        property int list_index: 2
    }
    ListElement {
        name: "CAN0Tx"
        property int list_index: 3
    }
    ListElement {
        name: "M1PWM7"
        property int list_index: 4
    }
    ListElement {
        name: "T1CCP1"
        property int list_index: 5
    }
    ListElement {
        name: "TRCLK"
        property int list_index: 6
    }
    // PF4
    ListElement {
        name: "M1FAULT0"
        property int list_index: 2
    }
    ListElement {
        name: "IDX0"
        property int list_index: 3
    }
    ListElement {
        name: "T2CCP0"
        property int list_index: 4
    }
    ListElement {
        name: "USB0EPEN"
        property int list_index: 5
    }
}
