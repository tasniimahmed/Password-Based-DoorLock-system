import QtQuick 2.14
import QtQuick.Window 2.12
import QtQuick.Controls 2.1

Window {
    id: root
    visible: true
    width: 1000
    height: 1000
    color: "white"
    title: qsTr("TM4C123GX IDE")
    MouseArea {
        id: main_mouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.WheelFocus
        onWheel: {
            if(wheel.angleDelta.y > 0)
            {
                tiva_border.height = tiva_border.height - 10
                tiva_border.width = tiva_border.width - 10
            }
            else if(wheel.angleDelta.y < 0)
            {
                tiva_border.height = tiva_border.height + 10
                tiva_border.width = tiva_border.width + 10
            }
        }
        onPressed: {
            tiva_border.pin_selected = false
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
            property string pin_name: "NULL"
            Repeater {
                        id: top_pins
                        model: ["PA2","PA3","PA4","PA5","PA6","PA7","PB0","PB1","PB2"]
                        property var configration: {"PA2": "NULL","PA3": "NULL","PA4": "NULL","PA5": "NULL","PA6": "NULL","PA7": "NULL","PB0": "NULL","PB1": "NULL","PB2": "NULL"}
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.width * 0.1
                                x: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color: mousetop.containsMouse ? "lightsteelblue" : "black"
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
                                    id: list_top
                                    width: parent.width*2
                                    height: parent.height*count
                                    anchors.top: parent.bottom
                                    property int last_mode: -1
                                    property int current: 0
                                    Component {
                                        id: modesDelegatetop
                                        Rectangle {
                                            width: list_top.width
                                            height: list_top.height/(list_top.count*2)
                                            radius: width/2
                                            border.width: width*0.01
                                            border.color: "black"
                                            property string mode: modeinfo_top.text
                                            function set_color(rect_color,text_color)
                                            {
                                                color = rect_color
                                                modeinfo_top.color = text_color
                                            }
                                            Component.onCompleted: {
                                                color = "red"
                                                modeinfo_top.color = "black"
                                            }
                                            Text {
                                                id: modeinfo_top
                                                text: name
                                                font.pixelSize: parent.height * 0.8
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                    model: ModeList {}
                                    delegate: modesDelegatetop
                                    focus: tiva_border.pin_selected && tiva_border.pin_name == modelData ? true : false
                                    visible: tiva_border.pin_selected && tiva_border.pin_name == modelData ? true : false

                                    Keys.onPressed: {
                                        if(event.key === Qt.Key_Down && current < 6 && current >= 0)
                                        {
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("red","black")
                                            }
                                            current++
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("black","red")
                                            }
                                        }
                                        else if(event.key === Qt.Key_Up && current > 0 && current <= 6)
                                        {
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("red","black")
                                            }
                                            current--
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("black","red")
                                            }
                                        }
                                        else if(event.key === Qt.Key_Enter - 1)
                                        {
                                            if(current != last_mode)
                                            {
                                                top_pins.configration[modelData] = itemAtIndex(current).mode
                                                itemAtIndex(current).set_color("green","black")
                                                if(last_mode != -1)
                                                {
                                                    itemAtIndex(last_mode).set_color("red","black")
                                                }
                                                last_mode = current
                                            }
                                            else
                                            {
                                                top_pins.configration[modelData] = "NULL"
                                                itemAtIndex(last_mode).set_color("red","black")
                                                last_mode= -1
                                            }
                                        }
                                    }
                                }
                                MouseArea {
                                    id: mousetop
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.RightButton
                                    hoverEnabled: true
                                    onPressed: {
                                        tiva_border.pin_name = modelData
                                        tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: bottom_pins
                        model: ["PE1","PE0","PD7","PD6","PD4","PD3","PD2","PD1","PD0"]
                        property var configration: {"PE1": "NULL","PE0": "NULL","PD7": "NULL","PD6": "NULL","PD4": "NULL","PD3": "NULL","PD2": "NULL","PD1": "NULL","PD0": "NULL"}
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.width * 0.1
                                x: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color: mousebottom.containsMouse ? "lightsteelblue" : "black"
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
                                ListView {
                                    id: list_bottom
                                    width: parent.width*2
                                    height: parent.height*count
                                    anchors.top: parent.bottom
                                    property int last_mode: -1
                                    property int current: 0
                                    Component {
                                        id: modesDelegatebottom
                                        Rectangle {
                                            width: list_bottom.width
                                            height: list_bottom.height/(list_bottom.count*2)
                                            radius: width/2
                                            border.width: width*0.01
                                            border.color: "black"
                                            property string mode: modeinfo_bottom.text
                                            function set_color(rect_color,text_color)
                                            {
                                                color = rect_color
                                                modeinfo_bottom.color = text_color
                                            }
                                            Component.onCompleted: {
                                                color = "red"
                                                modeinfo_bottom.color = "black"
                                            }
                                            Text {
                                                id: modeinfo_bottom
                                                text: name
                                                font.pixelSize: parent.height * 0.8
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                    model: ModeList {}
                                    delegate: modesDelegatebottom
                                    focus: tiva_border.pin_selected && tiva_border.pin_name == modelData ? true : false
                                    visible: tiva_border.pin_selected && tiva_border.pin_name == modelData ? true : false

                                    Keys.onPressed: {
                                        if(event.key === Qt.Key_Down && current < 6 && current >= 0)
                                        {
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("red","black")
                                            }
                                            current++
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("black","red")
                                            }
                                        }
                                        else if(event.key === Qt.Key_Up && current > 0 && current <= 6)
                                        {
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("red","black")
                                            }
                                            current--
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("black","red")
                                            }
                                        }
                                        else if(event.key === Qt.Key_Enter - 1)
                                        {
                                            if(current != last_mode)
                                            {
                                                bottom_pins.configration[modelData] = itemAtIndex(current).mode
                                                itemAtIndex(current).set_color("green","black")
                                                if(last_mode != -1)
                                                {
                                                    itemAtIndex(last_mode).set_color("red","black")
                                                }
                                                last_mode = current
                                            }
                                            else
                                            {
                                                bottom_pins.configration[modelData] = "NULL"
                                                itemAtIndex(last_mode).set_color("red","black")
                                                last_mode= -1
                                            }
                                        }
                                    }
                                }
                                MouseArea {
                                    id: mousebottom
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.RightButton
                                    hoverEnabled: true
                                    onPressed: {
                                        tiva_border.pin_name = modelData
                                        tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: right_pins
                        model: ["PB3","PB4","PB5","PB6","PB7","PC4","PC5","PC6","PC7"]
                        property var configration: {"PB3": "NULL","PB4": "NULL","PB5": "NULL","PB6": "NULL","PB7": "NULL","PC4": "NULL","PC5": "NULL","PC6": "NULL","PC7": "NULL"}
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.width * 0.1
                                y: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color: mouseright.containsMouse ? "lightsteelblue" : "black"
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
                                ListView {
                                    id: list_right
                                    width: parent.width*2
                                    height: parent.height*count
                                    anchors.left: parent.right
                                    property int last_mode: -1
                                    property int current: 0
                                    Component {
                                        id: modesDelegateright
                                        Rectangle {
                                            width: list_right.width
                                            height: list_right.height/(list_right.count*2)
                                            radius: width/2
                                            border.width: width*0.01
                                            border.color: "black"
                                            property string mode: modeinfo_right.text
                                            function set_color(rect_color,text_color)
                                            {
                                                color = rect_color
                                                modeinfo_right.color = text_color
                                            }
                                            Component.onCompleted: {
                                                color = "red"
                                                modeinfo_right.color = "black"
                                            }
                                            Text {
                                                id: modeinfo_right
                                                text: name
                                                font.pixelSize: parent.height * 0.8
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                    model: ModeList {}
                                    delegate: modesDelegateright
                                    focus: tiva_border.pin_selected && tiva_border.pin_name == modelData ? true : false
                                    visible: tiva_border.pin_selected && tiva_border.pin_name == modelData ? true : false

                                    Keys.onPressed: {
                                        if(event.key === Qt.Key_Down && current < 6 && current >= 0)
                                        {
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("red","black")
                                            }
                                            current++
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("black","red")
                                            }
                                        }
                                        else if(event.key === Qt.Key_Up && current > 0 && current <= 6)
                                        {
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("red","black")
                                            }
                                            current--
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("black","red")
                                            }
                                        }
                                        else if(event.key === Qt.Key_Enter - 1)
                                        {
                                            if(current != last_mode)
                                            {
                                                right_pins.configration[modelData] = itemAtIndex(current).mode
                                                itemAtIndex(current).set_color("green","black")
                                                if(last_mode != -1)
                                                {
                                                    itemAtIndex(last_mode).set_color("red","black")
                                                }
                                                last_mode = current
                                            }
                                            else
                                            {
                                                right_pins.configration[modelData] = "NULL"
                                                itemAtIndex(last_mode).set_color("red","black")
                                                last_mode= -1
                                            }
                                        }
                                    }
                                }
                                MouseArea {
                                    id: mouseright
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.RightButton
                                    hoverEnabled: true
                                    onPressed: {
                                        tiva_border.pin_name = modelData
                                        tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: left_pins
                        model: ["PF4","PF3","PF2","PF1","PF0","PE5","PE4","PE3","PE2"]
                        property var configration: {"PF4": "NULL","PF3": "NULL","PF2": "NULL","PF1": "NULL","PF0": "NULL","PE5": "NULL","PE4": "NULL","PE3": "NULL","PE2": "NULL"}
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.width * 0.1
                                y: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color: mouseleft.containsMouse ? "lightsteelblue" : "black"
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
                                ListView {
                                    id: list_left
                                    width: parent.width*2
                                    height: parent.height*count
                                    anchors.right: parent.left
                                    property int last_mode: -1
                                    property int current: 0
                                    Component {
                                        id: modesDelegateleft
                                        Rectangle {
                                            width: list_left.width
                                            height: list_left.height/(list_left.count*2)
                                            radius: width/2
                                            border.width: width*0.01
                                            border.color: "black"
                                            property string mode: modeinfo_left.text
                                            function set_color(rect_color,text_color)
                                            {
                                                color = rect_color
                                                modeinfo_left.color = text_color
                                            }
                                            Component.onCompleted: {
                                                color = "red"
                                                modeinfo_left.color = "black"
                                            }
                                            Text {
                                                id: modeinfo_left
                                                text: name
                                                font.pixelSize: parent.height * 0.8
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                    model: ModeList {}
                                    delegate: modesDelegateleft
                                    focus: tiva_border.pin_selected && tiva_border.pin_name == modelData ? true : false
                                    visible: tiva_border.pin_selected && tiva_border.pin_name == modelData ? true : false

                                    Keys.onPressed: {
                                        if(event.key === Qt.Key_Down && current < 6 && current >= 0)
                                        {
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("red","black")
                                            }
                                            current++
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("black","red")
                                            }
                                        }
                                        else if(event.key === Qt.Key_Up && current > 0 && current <= 6)
                                        {
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("red","black")
                                            }
                                            current--
                                            if(current != last_mode)
                                            {
                                                itemAtIndex(current).set_color("black","red")
                                            }
                                        }
                                        else if(event.key === Qt.Key_Enter - 1)
                                        {
                                            if(current != last_mode)
                                            {
                                                left_pins.configration[modelData] = itemAtIndex(current).mode
                                                itemAtIndex(current).set_color("green","black")
                                                if(last_mode != -1)
                                                {
                                                    itemAtIndex(last_mode).set_color("red","black")
                                                }
                                                last_mode = current
                                            }
                                            else
                                            {
                                                left_pins.configration[modelData] = "NULL"
                                                itemAtIndex(last_mode).set_color("red","black")
                                                last_mode= -1
                                            }
                                        }
                                    }
                                }
                                MouseArea {
                                    id: mouseleft
                                    anchors.fill: parent
                                    acceptedButtons:  Qt.RightButton
                                    hoverEnabled: true
                                    onPositionChanged: {
                                        parent.color = "lightsteelblue"
                                    }
                                    onExited: {
                                        parent.color = "black"
                                    }
                                    onReleased: {
                                        parent.color = "black"
                                    }
                                    onPressed: {
                                        tiva_border.pin_name = modelData
                                        tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Image {
                   id: tiva_logo
                   source: "texas_logo.png"
                   anchors.centerIn: parent
                   scale: parent.height*0.0005
                   mipmap: true
                   Text {
                       anchors.horizontalCenter: parent.horizontalCenter
                       anchors.top: parent.bottom
                       anchors.topMargin: parent.height
                       text: "TM4C123GX Kit"
                       color: "black"
                       font.pixelSize: parent.height*0.5
                       font.family: "Comic Sans MS"
                   }
                 }
        }
}
