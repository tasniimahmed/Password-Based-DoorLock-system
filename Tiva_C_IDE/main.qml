import QtQuick 2.14
import QtQuick.Window 2.12
import QtQuick.Controls 2.1

Window {
    id: tiva
    visible: true
    width: 1000
    height: 1000
    color: "white"
    title: qsTr("TM4C123GX IDE")
    property var configration: {"PA2": "NULL","PA3": "NULL","PA4": "NULL","PA5": "NULL","PA6": "NULL","PA7": "NULL","PB0": "NULL","PB1": "NULL","PB2": "NULL","PE1": "NULL","PE0": "NULL","PD7": "NULL","PD6": "NULL","PD4": "NULL","PD3": "NULL","PD2": "NULL","PD1": "NULL","PD0": "NULL","PB3": "NULL","PB4": "NULL","PB5": "NULL","PB6": "NULL","PB7": "NULL","PC4": "NULL","PC5": "NULL","PC6": "NULL","PC7": "NULL","PF4": "NULL","PF3": "NULL","PF2": "NULL","PF1": "NULL","PF0": "NULL","PE5": "NULL","PE4": "NULL","PE3": "NULL","PE2": "NULL"}
    Rectangle {
        id: generate
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.bottomMargin: 40
        anchors.rightMargin: 40
        color: "dark green"
        width: 100
        height: 40
        radius: width/8
        Text {
            anchors.centerIn: parent
            color: "white"
            text: "Generate"
            font.pixelSize: parent.height * 0.4
            font.family: "Comic Sans MS"
        }
        MouseArea {
            id: mousegen
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton
            hoverEnabled: true
            onEntered: {
                parent.color = "green"
            }
            onExited: {
                parent.color = "dark green"
            }
        }
    }

    MouseArea {
        id: main_mouse
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.WheelFocus
        onWheel: {
            if(wheel.angleDelta.y > 0)
            {
                tiva_border.height -= 10
                tiva_border.width -= 10
            }
            else if(wheel.angleDelta.y < 0 && tiva_border.height <= 400)
            {
                tiva_border.height += 10
                tiva_border.width += 10
            }
        }
        onClicked: {
            tiva_border.pin_selected = false
        }
    }
        Rectangle {
            id : tiva_border
            width: 300
            height: 300
            color: "blue"
            border.color: "red"
            border.width: 2
            anchors.centerIn: parent   
            property bool pin_selected: false
            property string pin_name: "NULL"
            property string configured_color: "green"
            property string hovered_color: "lightsteelblue"
            property string default_color: "black"
            Repeater {
                        id: top_pins
                        model: ["PA2","PA3","PA4","PA5","PA6","PA7","PB0","PB1","PB2"]
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.width * 0.1
                                x: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color:  {
                                    if(list_top.last_mode != -1)
                                    {
                                        pin_name_top.color = "black"
                                        return tiva_border.configured_color
                                    }
                                    else if(mousetop.containsMouse)
                                    {
                                        pin_name_top.color = "red"
                                         return tiva_border.hovered_color
                                    }
                                    else
                                    {
                                        pin_name_top.color = "red"
                                        return tiva_border.default_color
                                    }
                                }
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.bottom: tiva_border.top
                                Text {
                                    id: pin_name_top
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
                                    anchors.right: {
                                        if(modelData == "PB2")
                                        {
                                            return parent.right
                                        }
                                    }
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
                                            MouseArea {
                                                anchors.fill: parent
                                                acceptedButtons: Qt.LeftButton | Qt.WheelFocus
                                                hoverEnabled: true
                                                onEntered: {
                                                    if(list_top.last_mode != list_index)
                                                    {
                                                        parent.set_color("black","red")
                                                    }
                                                }
                                                onExited: {
                                                    if(list_top.last_mode != list_index)
                                                    {
                                                        parent.set_color("red","black")
                                                    }
                                                }
                                                onClicked: {
                                                    if(list_top.last_mode == -1)
                                                    {
                                                        parent.set_color("green","black")
                                                        list_top.last_mode = list_index
                                                        tiva.configration[modelData] = parent.mode
                                                    }
                                                    else if(list_top.last_mode == list_index)
                                                    {
                                                        parent.set_color("red","black")
                                                        list_top.last_mode = -1
                                                        tiva.configration[modelData] = "NULL"
                                                    }
                                                    else
                                                    {
                                                        list_top.reset_list()
                                                        parent.set_color("green","black")
                                                        list_top.last_mode = list_index
                                                        tiva.configration[modelData] = parent.mode
                                                    }
                                                }
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
                                        handle_list(event.key)
                                    }
                                function reset_list()
                                {
                                    for(var i = 0;i<count;i++)
                                    {
                                        itemAtIndex(i).set_color("red","black")
                                    }
                                }

                                function handle_list(key)
                                {
                                    if(key === Qt.Key_Down && current < 6 && current >= 0)
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
                                    else if(key === Qt.Key_Up && current > 0 && current <= 6)
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
                                    else if(key === Qt.Key_Enter - 1)
                                    {
                                        if(current != last_mode)
                                        {
                                            tiva.configration[modelData] = itemAtIndex(current).mode
                                            itemAtIndex(current).set_color("green","black")
                                            if(last_mode != -1)
                                            {
                                                itemAtIndex(last_mode).set_color("red","black")
                                            }
                                            last_mode = current
                                        }
                                        else
                                        {
                                            tiva.configration[modelData] = "NULL"
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
                                    onClicked: {
                                        tiva_border.pin_name = modelData
                                        tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: bottom_pins
                        model: ["PE1","PE0","PD7","PD6","PD4","PD3","PD2","PD1","PD0"]
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.width * 0.1
                                x: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color:  {
                                    if(list_bottom.last_mode != -1)
                                    {
                                        pin_name_bottom.color = "black"
                                        return tiva_border.configured_color
                                    }
                                    else if(mousebottom.containsMouse)
                                    {
                                        pin_name_bottom.color = "red"
                                        return tiva_border.hovered_color
                                    }
                                    else
                                    {
                                        pin_name_bottom.color = "red"
                                        return tiva_border.default_color
                                    }
                                }
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.top: tiva_border.bottom
                                Text {
                                    id: pin_name_bottom
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
                                            MouseArea {
                                                anchors.fill: parent
                                                acceptedButtons: Qt.LeftButton | Qt.WheelFocus
                                                hoverEnabled: true
                                                onEntered: {
                                                    if(list_bottom.last_mode != list_index)
                                                    {
                                                        parent.set_color("black","red")
                                                    }
                                                }
                                                onExited: {
                                                    if(list_bottom.last_mode != list_index)
                                                    {
                                                        parent.set_color("red","black")
                                                    }
                                                }
                                                onClicked: {
                                                    if(list_bottom.last_mode == -1)
                                                    {
                                                        parent.set_color("green","black")
                                                        list_bottom.last_mode = list_index
                                                        tiva.configration[modelData] = parent.mode
                                                    }
                                                    else if(list_bottom.last_mode == list_index)
                                                    {
                                                        parent.set_color("red","black")
                                                        list_bottom.last_mode = -1
                                                        tiva.configration[modelData] = "NULL"
                                                    }
                                                    else
                                                    {
                                                        list_bottom.reset_list()
                                                        parent.set_color("green","black")
                                                        list_bottom.last_mode = list_index
                                                        tiva.configration[modelData] = parent.mode
                                                    }
                                                }
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
                                        handle_list(event.key)
                                    }
                                function reset_list()
                                {
                                    for(var i = 0;i<count;i++)
                                    {
                                        itemAtIndex(i).set_color("red","black")
                                    }
                                }

                                function handle_list(key)
                                {
                                    if(key === Qt.Key_Down && current < 6 && current >= 0)
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
                                    else if(key === Qt.Key_Up && current > 0 && current <= 6)
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
                                    else if(key === Qt.Key_Enter - 1)
                                    {
                                        if(current != last_mode)
                                        {
                                            tiva.configration[modelData] = itemAtIndex(current).mode
                                            itemAtIndex(current).set_color("green","black")
                                            if(last_mode != -1)
                                            {
                                                itemAtIndex(last_mode).set_color("red","black")
                                            }
                                            last_mode = current
                                        }
                                        else
                                        {
                                            tiva.configration[modelData] = "NULL"
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
                                    onClicked: {
                                        tiva_border.pin_name = modelData
                                        tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: right_pins
                        model: ["PB3","PB4","PB5","PB6","PB7","PC4","PC5","PC6","PC7"]
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.width * 0.1
                                y: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color:  {
                                    if(list_right.last_mode != -1)
                                    {
                                        pin_name_right.color = "black"
                                        return tiva_border.configured_color
                                    }
                                    else if(mouseright.containsMouse)
                                    {
                                        pin_name_right.color = "red"
                                        return tiva_border.hovered_color
                                    }
                                    else
                                    {
                                        pin_name_right.color = "red"
                                        return tiva_border.default_color
                                    }
                                }
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.left: tiva_border.right
                                Text {
                                    id: pin_name_right
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
                                            MouseArea {
                                                anchors.fill: parent
                                                acceptedButtons: Qt.LeftButton | Qt.WheelFocus
                                                hoverEnabled: true
                                                onEntered: {
                                                    if(list_right.last_mode != list_index)
                                                    {
                                                        parent.set_color("black","red")
                                                    }
                                                }
                                                onExited: {
                                                    if(list_right.last_mode != list_index)
                                                    {
                                                        parent.set_color("red","black")
                                                    }
                                                }
                                                onClicked: {
                                                    if(list_right.last_mode == -1)
                                                    {
                                                        parent.set_color("green","black")
                                                        list_right.last_mode = list_index
                                                        tiva.configration[modelData] = parent.mode
                                                    }
                                                    else if(list_right.last_mode == list_index)
                                                    {
                                                        parent.set_color("red","black")
                                                        list_right.last_mode = -1
                                                        tiva.configration[modelData] = "NULL"
                                                    }
                                                    else
                                                    {
                                                        list_right.reset_list()
                                                        parent.set_color("green","black")
                                                        list_right.last_mode = list_index
                                                        tiva.configration[modelData] = parent.mode
                                                    }
                                                }
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
                                        handle_list(event.key)
                                    }
                                function reset_list()
                                {
                                    for(var i = 0;i<count;i++)
                                    {
                                        itemAtIndex(i).set_color("red","black")
                                    }
                                }

                                function handle_list(key)
                                {
                                    if(key === Qt.Key_Down && current < 6 && current >= 0)
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
                                    else if(key === Qt.Key_Up && current > 0 && current <= 6)
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
                                    else if(key === Qt.Key_Enter - 1)
                                    {
                                        if(current != last_mode)
                                        {
                                            tiva.configration[modelData] = itemAtIndex(current).mode
                                            itemAtIndex(current).set_color("green","black")
                                            if(last_mode != -1)
                                            {
                                                itemAtIndex(last_mode).set_color("red","black")
                                            }
                                            last_mode = current
                                        }
                                        else
                                        {
                                            tiva.configration[modelData] = "NULL"
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
                                    onClicked: {
                                        tiva_border.pin_name = modelData
                                        tiva_border.pin_selected = true
                                    }
                                }
                            }
                 }
            Repeater {
                        id: left_pins
                        model: ["PF4","PF3","PF2","PF1","PF0","PE5","PE4","PE3","PE2"]
                            Rectangle {
                                height: tiva_border.height * 0.1
                                width: tiva_border.width * 0.1
                                y: (tiva_border.width/100)+((index)*5.5*(tiva_border.width/50))
                                color:  {
                                    if(list_left.last_mode != -1)
                                    {
                                        pin_name_left.color = "black"
                                        return tiva_border.configured_color
                                    }
                                    else if(mouseleft.containsMouse)
                                    {
                                        pin_name_left.color = "red"
                                        return tiva_border.hovered_color
                                    }
                                    else
                                    {
                                        pin_name_left.color = "red"
                                        return tiva_border.default_color
                                    }
                                }
                                border.color: "red"
                                border.width: 2
                                radius: width/2
                                antialiasing: true
                                anchors.right: tiva_border.left
                                Text {
                                    id: pin_name_left
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
                                            MouseArea {
                                                anchors.fill: parent
                                                acceptedButtons: Qt.LeftButton | Qt.WheelFocus
                                                hoverEnabled: true
                                                onEntered: {
                                                    if(list_left.last_mode != list_index)
                                                    {
                                                        parent.set_color("black","red")
                                                    }
                                                }
                                                onExited: {
                                                    if(list_left.last_mode != list_index)
                                                    {
                                                        parent.set_color("red","black")
                                                    }
                                                }
                                                onClicked: {
                                                    if(list_left.last_mode == -1)
                                                    {
                                                        parent.set_color("green","black")
                                                        list_left.last_mode = list_index
                                                        tiva.configration[modelData] = parent.mode
                                                    }
                                                    else if(list_left.last_mode == list_index)
                                                    {
                                                        parent.set_color("red","black")
                                                        list_left.last_mode = -1
                                                        tiva.configration[modelData] = "NULL"
                                                    }
                                                    else
                                                    {
                                                        list_left.reset_list()
                                                        parent.set_color("green","black")
                                                        list_left.last_mode = list_index
                                                        tiva.configration[modelData] = parent.mode
                                                    }
                                                }
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
                                        handle_list(event.key)
                                    }
                                function reset_list()
                                {
                                    for(var i = 0;i<count;i++)
                                    {
                                        itemAtIndex(i).set_color("red","black")
                                    }
                                }

                                function handle_list(key)
                                {
                                    if(key === Qt.Key_Down && current < 6 && current >= 0)
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
                                    else if(key === Qt.Key_Up && current > 0 && current <= 6)
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
                                    else if(key === Qt.Key_Enter - 1)
                                    {
                                        if(current != last_mode)
                                        {
                                            tiva.configration[modelData] = itemAtIndex(current).mode
                                            itemAtIndex(current).set_color("green","black")
                                            if(last_mode != -1)
                                            {
                                                itemAtIndex(last_mode).set_color("red","black")
                                            }
                                            last_mode = current
                                        }
                                        else
                                        {
                                            tiva.configration[modelData] = "NULL"
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
                                    onClicked: {
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
        Row {
            id: zoom
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle {
                id:zoom_in_rec
                height: zoom_in.height*0.25
                width: zoom_in.width*0.25
                color: "white"
                radius: width/5
                Image {
                    id: zoom_in
                    source: "zoom_in.png"
                    anchors.centerIn: parent
                    mipmap: true
                    scale: 0.2
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        hoverEnabled: true
                        onEntered: {
                            zoom_in_rec.color = "lightsteelblue"
                        }
                        onExited: {
                            zoom_in_rec.color = "white"
                        }
                        onClicked: {
                            if(tiva_border.height <= 400)
                            {
                                tiva_border.height += 10
                                tiva_border.width += 10
                            }
                        }
                    }
                }
            }
            Rectangle {
                id:zoom_out_rec
                height: zoom_out.height*0.25
                width: zoom_out.width*0.25
                color: "white"
                radius: width/5
                Image {
                    id: zoom_out
                    source: "zoom_out.png"
                    anchors.centerIn: parent
                    mipmap: true
                    scale: 0.2
                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton
                        hoverEnabled: true
                        onEntered: {
                            zoom_out_rec.color = "lightsteelblue"
                        }
                        onExited: {
                            zoom_out_rec.color = "white"
                        }
                        onClicked: {
                            tiva_border.height -= 10
                            tiva_border.width -= 10
                        }
                    }
                }
            }
       }
}
