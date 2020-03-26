import QtQuick 2.0

ListModel {

    // port A modes from 2 to 7

    ListElement {
        name: "Input"
        property int list_index: 0
    }
    ListElement {
        name: "Output"
        property int list_index: 1
    }
    // PA2
    ListElement {
        name: "SSI0Clk"
        property int list_index: 2
    }
    // PA3
    ListElement {
        name: "SSI0Fss"
        property int list_index: 2
    }
    // PA4
    ListElement {
        name: "SSI0Rx"
        property int list_index: 2
    }
    // PA5
    ListElement {
        name: "SSI0Tx"
        property int list_index: 2
    }
    // PA6
    ListElement {
        name: "I2C1SCL"
        property int list_index: 2
    }
    ListElement {
        name: "M1PWM2"
        property int list_index: 3
    }
    // PA7
    ListElement {
        name: "I2C1SDA"
        property int list_index: 2
    }
    ListElement {
        name: "M1PWM3"
        property int list_index: 3
    }

    // prot B modes from 0 to 2

    // PB0
    ListElement {
        name: "USB0ID"
        property int list_index: 2
    }
    ListElement {
        name: "U1Rx"
        property int list_index: 3
    }
    ListElement {
        name: "T2CCP0"
        property int list_index: 4
    }
    // PB1
    ListElement {
        name: "USB0VBUS"
        property int list_index: 2
    }
    ListElement {
        name: "U1Tx"
        property int list_index: 3
    }
    ListElement {
        name: "T2CCP1"
        property int list_index: 4
    }
    // PB2
    ListElement {
        name: "I2C0SCL"
        property int list_index: 2
    }
    ListElement {
        name: "T3CCP0"
        property int list_index: 3
    }
}
