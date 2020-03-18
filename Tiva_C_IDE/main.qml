import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    visible: true
    width: 750
    height: 750
    color: "white"
    title: qsTr("TM4C123GX IDE")
        Rectangle {
            id : tiva_border
            width: 500
            height: 500
            color: "blue"
            border.color: "red"
            border.width: 2
            anchors.centerIn: parent
            Repeater {
                        model: ["PA2","PA3","PA4","PA5","PA6","PA7","PB0","PB1","PB2"]
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.height * 0.1
                                x: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color: "black"
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.bottom: tiva_border.top
                                Text {
                                    anchors.centerIn: parent
                                    color: "red"
                                    text: modelData
                                    font.pixelSize: parent.height * 0.4
                                    font.family: "Comic Sans MS"
                                }
                                ListView {
                                    id: list
                                    width: 150
                                    height: 200
                                    anchors.top: parent.bottom
                                    Component {
                                        id: contactsDelegate
                                        Rectangle {
                                            id: wrapper
                                            width: 180
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
                                    focus: true
                                    visible: false
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.AllButtons
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
                                    }
                                    onPressed: {
                                        list.visible = true
                                    }
                                }
                            }
                 }
            Repeater {
                        model: ["PE1","PE0","PD7","PD6","PD4","PD3","PD2","PD1","PD0"]
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.height * 0.1
                                x: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color: "black"
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.top: tiva_border.bottom
                                Text {
                                    anchors.centerIn: parent
                                    color: "red"
                                    text: modelData
                                    font.pixelSize: parent.height * 0.4
                                    font.family: "Comic Sans MS"
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.AllButtons
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
                                    }
                                }
                            }
                 }
            Repeater {
                        model: ["PB3","PB4","PB5","PB6","PB7","PC4","PC5","PC6","PC7"]
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.height * 0.1
                                y: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color: "black"
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.left: tiva_border.right
                                Text {
                                    anchors.centerIn: parent
                                    color: "red"
                                    text: modelData
                                    font.pixelSize: parent.height * 0.4
                                    font.family: "Comic Sans MS"
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.AllButtons
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
                                    }
                                }
                            }
                 }
            Repeater {
                        model: ["PF4","PF3","PF2","PF1","PF0","PE5","PE4","PE3","PE2"]
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.height * 0.1
                                y: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color: "black"
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.right: tiva_border.left
                                Text {
                                    anchors.centerIn: parent
                                    color: "red"
                                    text: modelData
                                    font.pixelSize: parent.height * 0.4
                                    font.family: "Comic Sans MS"
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.AllButtons
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
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
