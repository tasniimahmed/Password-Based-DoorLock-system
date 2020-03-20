import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    visible: true
    width: 750
    height: 750
    color: "white"
    title: qsTr("TM4C123GX IDE")


    MouseArea {
        id: main_mouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton
        onPressed: {
            for(var i = 0; i<top_pins.count;i++)
            {
                top_pins.itemAt(i).clicked = false
                bottom_pins.itemAt(i).clicked = false
                right_pins.itemAt(i).clicked = false
                left_pins.itemAt(i).clicked = false
                tiva_border.pin_selected = false
            }
        }
    }
        Rectangle {
            id : tiva_border
            width: 400
            height: 400
            color: "blue"
            border.color: "red"
            border.width: 2
            anchors.centerIn: parent   
            property bool pin_selected: false
            Repeater {
                        id: top_pins
                        model: ["PA2","PA3","PA4","PA5","PA6","PA7","PB0","PB1","PB2"]
                            Rectangle {
                                property bool clicked: false
                                property string pin: modelData
                                height: parent.height * 0.1
                                width: parent.height * 0.1
                                x: (parent.width/100)+((index)*5.5*(parent.width/50))
                                color: "black"
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.bottom: parent.top
                                Text {
                                    anchors.centerIn: parent
                                    color: "red"
                                    text: modelData
                                    font.pixelSize: parent.height * 0.4
                                    font.family: "Comic Sans MS"
                                }
                                ListView {
                                    id: list_top
                                    width: parent.width*2
                                    height: parent.height*count
                                    anchors.top: parent.bottom
                                    Component {
                                        id: contactsDelegate
                                        Rectangle {
                                            id: wrapper
                                            width: list_top.width
                                            height: contactInfo.height
                                            radius: width/2
                                            color: ListView.isCurrentItem ? "black" : "red"
                                            Text {
                                                id: contactInfo
                                                text: name
                                                anchors.centerIn: parent
                                                color: wrapper.ListView.isCurrentItem ? "red" : "black"
                                            }
                                        }
                                    }

                                    model: ModeList {}
                                    delegate: contactsDelegate
                                    focus: parent.clicked && tiva_border.pin_selected ? true : false
                                    visible: parent.clicked && tiva_border.pin_selected ? true : false
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.RightButton
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
                                    }
                                    onPressed: {
                                        parent.clicked = true
                                        if(!tiva_border.pin_selected)
                                            tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: bottom_pins
                        model: ["PE1","PE0","PD7","PD6","PD4","PD3","PD2","PD1","PD0"]
                            Rectangle {
                                property bool clicked: false
                                property string pin: modelData
                                height: parent.height * 0.1
                                width: parent.height * 0.1
                                x: (parent.width/100)+((index)*5.5*(parent.width/50))
                                color: "black"
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.top: parent.bottom
                                Text {
                                    anchors.centerIn: parent
                                    color: "red"
                                    text: modelData
                                    font.pixelSize: parent.height * 0.4
                                    font.family: "Comic Sans MS"
                                }
                                ListView {
                                    id: list_bottom
                                    width: parent.width*2
                                    height: parent.height*count
                                    anchors.top: parent.bottom
                                    Component {
                                        id: contactsDelegate
                                        Rectangle {
                                            id: wrapper
                                            width: list_bottom.width
                                            height: contactInfo.height
                                            radius: width/2
                                            color: ListView.isCurrentItem ? "black" : "red"
                                            Text {
                                                id: contactInfo
                                                text: name
                                                anchors.centerIn: parent
                                                color: wrapper.ListView.isCurrentItem ? "red" : "black"
                                            }
                                        }
                                    }

                                    model: ModeList {}
                                    delegate: contactsDelegate
                                    focus: parent.clicked && tiva_border.pin_selected ? true : false
                                    visible: parent.clicked && tiva_border.pin_selected ? true : false
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.RightButton
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
                                    }
                                    onPressed: {
                                        parent.clicked = true
                                        if(!tiva_border.pin_selected)
                                            tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: right_pins
                        model: ["PB3","PB4","PB5","PB6","PB7","PC4","PC5","PC6","PC7"]
                            Rectangle {
                                property bool clicked: false
                                property string pin: modelData
                                height: parent.height * 0.1
                                width: parent.height * 0.1
                                y: (parent.width/100)+((index)*5.5*(parent.width/50))
                                color: "black"
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.left: parent.right
                                Text {
                                    anchors.centerIn: parent
                                    color: "red"
                                    text: modelData
                                    font.pixelSize: parent.height * 0.4
                                    font.family: "Comic Sans MS"
                                }
                                ListView {
                                    id: list_right
                                    width: parent.width*2
                                    height: parent.height*count
                                    anchors.left: parent.right
                                    Component {
                                        id: contactsDelegate
                                        Rectangle {
                                            id: wrapper
                                            width: list_right.width
                                            height: contactInfo.height
                                            radius: width/2
                                            color: ListView.isCurrentItem ? "black" : "red"
                                            Text {
                                                id: contactInfo
                                                text: name
                                                anchors.centerIn: parent
                                                color: wrapper.ListView.isCurrentItem ? "red" : "black"
                                            }
                                        }
                                    }

                                    model: ModeList {}
                                    delegate: contactsDelegate
                                    focus: parent.clicked && tiva_border.pin_selected ? true : false
                                    visible: parent.clicked && tiva_border.pin_selected ? true : false
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.RightButton
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
                                    }
                                    onPressed: {
                                        parent.clicked = true
                                        if(!tiva_border.pin_selected)
                                            tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: left_pins
                        model: ["PF4","PF3","PF2","PF1","PF0","PE5","PE4","PE3","PE2"]
                            Rectangle {
                                property bool clicked: false
                                property string pin: modelData
                                height: parent.height * 0.1
                                width: parent.height * 0.1
                                y: (parent.width/100)+((index)*5.5*(parent.width/50))
                                color: "black"
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.right: parent.left
                                Text {
                                    anchors.centerIn: parent
                                    color: "red"
                                    text: modelData
                                    font.pixelSize: parent.height * 0.4
                                    font.family: "Comic Sans MS"
                                }
                                ListView {
                                    id: list_left
                                    width: parent.width*2
                                    height: parent.height*count
                                    anchors.right: parent.left
                                    Component {
                                        id: contactsDelegate
                                        Rectangle {
                                            id: wrapper
                                            width: list_left.width
                                            height: contactInfo.height
                                            radius: width/2
                                            color: ListView.isCurrentItem ? "black" : "red"
                                            Text {
                                                id: contactInfo
                                                text: name
                                                anchors.centerIn: parent
                                                color: wrapper.ListView.isCurrentItem ? "red" : "black"
                                            }
                                        }
                                    }

                                    model: ModeList {}
                                    delegate: contactsDelegate
                                    focus: parent.clicked && tiva_border.pin_selected ? true : false
                                    visible: parent.clicked && tiva_border.pin_selected ? true : false
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.RightButton
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
                                    }
                                    onPressed: {
                                        parent.clicked = true
                                        if(!tiva_border.pin_selected)
                                            tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Image {
                   id: tiva_logo
                   source: "texas_logo.png"
                   anchors.centerIn: parent
                   scale: 0.2
                   mipmap: true
                   Text {
                       anchors.horizontalCenter: parent.horizontalCenter
                       anchors.top: parent.bottom
                       anchors.topMargin: parent.height
                       text: "TM4C123GX Kit"
                       color: "black"
                       font.pixelSize: parent.height * 0.4
                       font.family: "Comic Sans MS"
                   }
                 }
        }
}
