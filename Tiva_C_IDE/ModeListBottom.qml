import QtQuick 2.0

ListModel {

    //port D modes from 0 to 7 except 5

    ListElement {
        name: "Input"
        property int list_index: 0
    }
    ListElement {
        name: "Output"
        property int list_index: 1
    }
    // PD0
    ListElement {
        name: "AIN7"
        property int list_index: 2
    }
    ListElement {
        name: "SSI3Clk"
        property int list_index: 3
    }
    ListElement {
        name: "SSI1Clk"
        property int list_index: 4
    }
    ListElement {
        name: "I2C3SCL"
        property int list_index: 5
    }
    ListElement {
        name: "M0PWM6"
        property int list_index: 6
    }
    ListElement {
        name: "M1PWM0"
        property int list_index: 7
    }
    ListElement {
        name: "WT2CCP0"
        property int list_index: 8
    }
    // PD1
    ListElement {
        name: "AIN6"
        property int list_index: 2
    }
    ListElement {
        name: "SSI3Fss"
        property int list_index: 3
    }
    ListElement {
        name: "SSI1Fss"
        property int list_index: 4
    }
    ListElement {
        name: "I2C3SDA"
        property int list_index: 5
    }
    ListElement {
        name: "M0PWM7"
        property int list_index: 6
    }
    ListElement {
        name: "M1PWM1"
        property int list_index: 7
    }
    ListElement {
        name: "WT2CCP1"
        property int list_index: 8
    }
    // PD2
    ListElement {
        name: "AIN5"
        property int list_index: 2
    }
    ListElement {
        name: "SSI3Rx"
        property int list_index: 3
    }
    ListElement {
        name: "SSI1Rx"
        property int list_index: 4
    }
    ListElement {
        name: "M0FAULT0"
        property int list_index: 5
    }
    ListElement {
        name: "WT3CCP0"
        property int list_index: 6
    }
    ListElement {
        name: "USB0EPEN"
        property int list_index: 7
    }
    // PD3
    ListElement {
        name: "AIN4"
        property int list_index: 2
    }
    ListElement {
        name: "SSI3Tx"
        property int list_index: 3
    }
    ListElement {
        name: "SSI1Tx"
        property int list_index: 4
    }
    ListElement {
        name: "IDX0"
        property int list_index: 5
    }
    ListElement {
        name: "WT3CCP1"
        property int list_index: 6
    }
    ListElement {
        name: "USB0PFLT"
        property int list_index: 7
    }
    // PD4
    ListElement {
        name: "USB0DM"
        property int list_index: 2
    }
    ListElement {
        name: "WT4CCP0"
        property int list_index: 3
    }
    // PD6
    ListElement {
        name: "U2Rx"
        property int list_index: 2
    }
    ListElement {
        name: "M0FAULT0"
        property int list_index: 3
    }
    ListElement {
        name: "PhA0"
        property int list_index: 4
    }
    ListElement {
        name: "WT5CCP0"
        property int list_index: 5
    }
    // PD7
    ListElement {
        name: "U2Tx"
        property int list_index: 2
    }
    ListElement {
        name: "PhB0"
        property int list_index: 3
    }
    ListElement {
        name: "WT5CCP1"
        property int list_index: 4
    }
    ListElement {
        name: "NMI"
        property int list_index: 5
    }

    //port E modes from 0 to 1

    // PE0
    ListElement {
        name: "AIN3"
        property int list_index: 2
    }
    ListElement {
        name: "U7Rx"
        property int list_index: 3
    }
    // PE1
    ListElement {
        name: "AIN2"
        property int list_index: 2
    }
    ListElement {
        name: "U7Tx"
        property int list_index: 3
    }
}
