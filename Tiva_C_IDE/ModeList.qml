import QtQuick 2.0

ListModel {
    ListElement {
        name: "UART"
        property int list_index: 0
    }
    ListElement {
        name: "Input"
        property int list_index: 1
    }
    ListElement {
        name: "Output"
        property int list_index: 2
    }
    ListElement {
        name: "Timer"
        property int list_index: 3
    }
    ListElement {
        name: "Interrupt"
        property int list_index: 4
    }
    ListElement {
        name: "DMA"
        property int list_index: 5
    }
    ListElement {
        name: "SPI"
        property int list_index: 6
    }
}
