import QtQuick 2.14
import QtQuick.Window 2.12
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Window {
    id: tiva
    visible: true
    width: 750
    height: 750
    color: "white"
    title: qsTr("TM4C123GX IDE")
    property var configration: {"PA2": "NULL","PA3": "NULL","PA4": "NULL","PA5": "NULL","PA6": "NULL","PA7": "NULL","PB0": "NULL","PB1": "NULL","PB2": "NULL","PE1": "NULL","PE0": "NULL","PD7": "NULL","PD6": "NULL","PD4": "NULL","PD3": "NULL","PD2": "NULL","PD1": "NULL","PD0": "NULL","PB3": "NULL","PB4": "NULL","PB5": "NULL","PB6": "NULL","PB7": "NULL","PC4": "NULL","PC5": "NULL","PC6": "NULL","PC7": "NULL","PF4": "NULL","PF3": "NULL","PF2": "NULL","PF1": "NULL","PF0": "NULL","PE5": "NULL","PE4": "NULL","PE3": "NULL","PE2": "NULL"}
    property string last_pin_mode: "NULL"
    function readValues(map)
    {
        for(var i in map)
        {
            console.log(map[i])
        }
    }

    Rectangle {
        id: container
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        width: parent.width
        states: State {
            name: "configrationanchors"
            AnchorChanges {
                target: userinterface
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
                anchors.right: container.right
            }
        }
        State {
            name: "normalanchors"
            AnchorChanges {
                target: userinterface
                anchors.horizontalCenter: container.horizontalCenter
                anchors.verticalCenter: container.verticalCenter
                anchors.right: undefined
            }
        }
        transitions: Transition {
            AnchorAnimation {
                duration: 1000
            }
        }
        MouseArea {
            id: main_mouse
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.WheelFocus
            onWheel: {
                if(wheel.angleDelta.y > 0 && tiva_border.height >= 200)
                {
                    tiva_border.height -= 10
                    tiva_border.width -= 10
                }
                else if(wheel.angleDelta.y < 0 && tiva_border.height <= 375)
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
            id: generate
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: 40
            anchors.rightMargin: 40
            z: 10
            color: "green"
            border.color: "black"
            border.width: 2
            width: 100
            height: 40
            radius: width/15
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
                    parent.color = " dark green"
                }
                onExited: {
                    parent.color = "green"
                }
            }
        }
        Item {
            width: parent.width*0.35
            anchors.left: parent.left
            height: parent.height
            Loader {
                id: load_config
                anchors.fill: parent
            }
        }
        Component {
            id: config_window
            UARTConfigration {
                width: tiva.width*0.35
                anchors.left: tiva.left
                height: tiva.height
                Text {
                    id: pinnametext
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "black"
                    text: tiva_border.pin_name + " " + tiva.last_pin_mode + " Configrations"
                    font.pixelSize: parent.width*0.05
                    font.bold: true
                    font.family: "Comic Sans MS"
                }
            }
        }
        Rectangle {
            id: userinterface
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height
            width: parent.width*0.65
            Rectangle {
                id : tiva_border
                width: 300
                height: 300
                color: "blue"
                border.color: "red"
                border.width: 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: parent.height/10
                property bool pin_selected: false
                property string pin_name: "NULL"
                property string pin_configured_color: "green"
                property string pin_hovered_color: "lightsteelblue"
                property string pin_default_color: "black"
                property string pin_text_color: "red"
                property string pin_text_configured_color: "black"
                property string list_mode_color: "red"
                property string list_configured_color: "green"
                property string list_text_color: "black"
                property string list_mode_hovered_color: "black"
                property string list_text_hovered_color: "red"
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
                                pin_name_top.color = tiva_border.pin_text_configured_color
                                return tiva_border.pin_configured_color
                            }
                            else if(mousetop.containsMouse)
                            {
                                pin_name_top.color = tiva_border.pin_text_color
                                return tiva_border.pin_hovered_color
                            }
                            else
                            {
                                pin_name_top.color = tiva_border.pin_text_color
                                return tiva_border.pin_default_color
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
                            Component.onCompleted: {
                                if(modelData == "PA2"){
                                    modetop.remove(3,15)
                                }
                                else if(modelData == "PA3"){
                                    modetop.remove(4,14)
                                    modetop.remove(2)
                                }
                                else if(modelData == "PA4"){
                                    modetop.remove(5,13)
                                    modetop.remove(2,2)
                                }
                                else if(modelData == "PA5"){
                                    modetop.remove(6,12)
                                    modetop.remove(2,3)
                                }
                                else if(modelData == "PA6"){
                                    modetop.remove(8,10)
                                    modetop.remove(2,4)
                                }
                                else if(modelData == "PA7"){
                                    modetop.remove(10,8)
                                    modetop.remove(2,6)
                                }
                                else if(modelData == "PB0"){
                                    modetop.remove(13,5)
                                    modetop.remove(2,8)
                                }
                                else if(modelData == "PB1"){
                                    modetop.remove(16,2)
                                    modetop.remove(2,11)
                                }
                                else if(modelData == "PB2"){
                                    modetop.remove(2,14)
                                }
                            }
                            property int numberOfMode: {
                                if(modelData == "PA2" || modelData == "PA3" || modelData == "PA4" || modelData == "PA5" || modelData == "PB2"){
                                    return 3;
                                }
                                else if(modelData == "PA6" || modelData == "PA7"){
                                    return 4;
                                }
                                else if(modelData == "PB0" || modelData == "PB1"){
                                    return 5;
                                }
                            }
                            property int last_mode: -1
                            property int current: 0
                            Component {
                                id: modesDelegatetop
                                Rectangle {
                                    width: list_top.width
                                    height: list_top.height/(list_top.count*2)
                                    radius: width/15
                                    border.width: width*0.01
                                    border.color: "black"
                                    property string mode: modeinfo_top.text
                                    function set_color(rect_color,text_color)
                                    {
                                        color = rect_color
                                        modeinfo_top.color = text_color
                                    }
                                    Component.onCompleted: {
                                        color = tiva_border.list_mode_color
                                        modeinfo_top.color = tiva_border.list_text_color
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        acceptedButtons: Qt.LeftButton
                                        hoverEnabled: true
                                        onEntered: {
                                            if(list_top.last_mode != list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                            }
                                        }
                                        onExited: {
                                            if(list_top.last_mode != list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                            }
                                        }
                                        onClicked: {
                                            if(list_top.last_mode == -1)
                                            {
                                                parent.set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                                list_top.last_mode = list_index
                                                tiva.configration[modelData] = parent.mode
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "configrationanchors"
                                                load_config.sourceComponent = config_window
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                            else if(list_top.last_mode == list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                                list_top.last_mode = -1
                                                tiva.configration[modelData] = "NULL"
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "normalanchors"
                                                load_config.sourceComponent = undefined
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                            else
                                            {
                                                list_top.reset_list()
                                                parent.set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                                list_top.last_mode = list_index
                                                tiva.configration[modelData] = parent.mode
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "configrationanchors"
                                                load_config.sourceComponent = config_window
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                        }
                                    }
                                    Text {
                                        id: modeinfo_top
                                        text: name
                                        font.pixelSize: parent.height * 0.75
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                            model: ModeListTop {id: modetop}
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
                                    itemAtIndex(i).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                }
                            }

                            function handle_list(key)
                            {
                                if(key === Qt.Key_Down && current < numberOfMode - 1 && current >= 0)
                                {
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                    }
                                    current++
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                    }
                                }
                                else if(key === Qt.Key_Up && current > 0 && current <= numberOfMode - 1)
                                {
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                    }
                                    current--
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                    }
                                }
                                else if(key === Qt.Key_Enter - 1)
                                {
                                    if(current != last_mode)
                                    {
                                        tiva.configration[modelData] = itemAtIndex(current).mode
                                        tiva.last_pin_mode = tiva.configration[modelData]
                                        itemAtIndex(current).set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                        if(last_mode != -1)
                                        {
                                            itemAtIndex(last_mode).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                        }
                                        last_mode = current
                                        container.state = "configrationanchors"
                                        load_config.sourceComponent = config_window
                                        console.log(tiva_border.pin_name,tiva.configration[modelData])
                                    }
                                    else
                                    {
                                        tiva.configration[modelData] = "NULL"
                                        tiva.last_pin_mode = tiva.configration[modelData]
                                        itemAtIndex(last_mode).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                        last_mode= -1
                                        container.state = "normalanchors"
                                        load_config.sourceComponent = undefined
                                        console.log(tiva_border.pin_name,tiva.configration[modelData])
                                    }
                                }
                            }
                            //                                  MouseArea {
                            //                                      id: topwheel
                            //                                      anchors.fill: parent
                            //                                      acceptedButtons: Qt.WheelFocus
                            //                                      //enabled: false
                            //                                      onWheel: {
                            //                                          if(wheel.angleDelta.y > 0 && parent.current < 6 && parent.current >= 0)
                            //                                          {
                            //                                              if(parent.current != parent.last_mode)
                            //                                              {
                            //                                                  parent.itemAtIndex(parent.current).set_color("red","black")
                            //                                              }
                            //                                              parent.current++
                            //                                              if(parent.current != parent.last_mode)
                            //                                              {
                            //                                                  parent.itemAtIndex(parent.current).set_color("black","red")
                            //                                              }
                            //                                          }
                            //                                          else if(wheel.angleDelta.y < 0 && parent.current > 0 && parent.current <= 6)
                            //                                          {
                            //                                              if(parent.current != parent.last_mode)
                            //                                              {
                            //                                                  parent.itemAtIndex(parent.current).set_color("red","black")
                            //                                              }
                            //                                              parent.current--
                            //                                              if(parent.current != parent.last_mode)
                            //                                              {
                            //                                                  parent.itemAtIndex(parent.current).set_color("black","red")
                            //                                              }
                            //                                          }
                            //                                      }
                            //                                  }
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
                                pin_name_bottom.color = tiva_border.pin_text_configured_color
                                return tiva_border.pin_configured_color
                            }
                            else if(mousebottom.containsMouse)
                            {
                                pin_name_bottom.color = tiva_border.pin_text_color
                                return tiva_border.pin_hovered_color
                            }
                            else
                            {
                                pin_name_bottom.color = tiva_border.pin_text_color
                                return tiva_border.pin_default_color
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
                            text: modelData
                            font.pixelSize: parent.height * 0.4
                            font.family: "Comic Sans MS"
                        }
                        ListView {
                            id: list_bottom
                            width: parent.width*2
                            height: parent.height*count
                            anchors.top: parent.bottom
                            Component.onCompleted: {
                                if(modelData == "PD0"){
                                    modebottom.remove(9,34)
                                }
                                else if(modelData == "PD1"){
                                    modebottom.remove(16,27)
                                    modebottom.remove(2,7)
                                }
                                else if(modelData == "PD2"){
                                    modebottom.remove(22,21)
                                    modebottom.remove(2,14)
                                }
                                else if(modelData == "PD3"){
                                    modebottom.remove(28,15)
                                    modebottom.remove(2,20)
                                }
                                else if(modelData == "PD4"){
                                    modebottom.remove(31,12)
                                    modebottom.remove(2,26)
                                }
                                else if(modelData == "PD6"){
                                    modebottom.remove(35,8)
                                    modebottom.remove(2,29)
                                }
                                else if(modelData == "PD7"){
                                    modebottom.remove(39,4)
                                    modebottom.remove(2,33)
                                }
                                else if(modelData == "PE0"){
                                    modebottom.remove(41,2)
                                    modebottom.remove(2,37)
                                }
                                else if(modelData == "PE1"){
                                    modebottom.remove(2,39)
                                }
                            }
                            property int numberOfMode: {
                                if(modelData == "PE0" || modelData == "PE1"){
                                    return 4;
                                }
                                else if(modelData == "PD4"){
                                    return 5;
                                }
                                else if(modelData == "PD6" || modelData == "PD7"){
                                    return 6;
                                }
                                else if(modelData == "PD2" || modelData == "PD3"){
                                    return 8;
                                }
                                else if(modelData == "PD0" || modelData == "PD1"){
                                    return 9;
                                }
                            }
                            property int last_mode: -1
                            property int current: 0
                            Component {
                                id: modesDelegatebottom
                                Rectangle {
                                    width: list_bottom.width
                                    height: list_bottom.height/(list_bottom.count*2)
                                    radius: width/15
                                    border.width: width*0.01
                                    border.color: "black"
                                    property string mode: modeinfo_bottom.text
                                    function set_color(rect_color,text_color)
                                    {
                                        color = rect_color
                                        modeinfo_bottom.color = text_color
                                    }
                                    Component.onCompleted: {
                                        color = tiva_border.list_mode_color
                                        modeinfo_bottom.color = tiva_border.list_text_color
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        acceptedButtons: Qt.LeftButton | Qt.WheelFocus
                                        hoverEnabled: true
                                        onEntered: {
                                            if(list_bottom.last_mode != list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                            }
                                        }
                                        onExited: {
                                            if(list_bottom.last_mode != list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                            }
                                        }
                                        onClicked: {
                                            if(list_bottom.last_mode == -1)
                                            {
                                                parent.set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                                list_bottom.last_mode = list_index
                                                tiva.configration[modelData] = parent.mode
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "configrationanchors"
                                                load_config.sourceComponent = config_window
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])

                                            }
                                            else if(list_bottom.last_mode == list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                                list_bottom.last_mode = -1
                                                tiva.configration[modelData] = "NULL"
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "normalanchors"
                                                load_config.sourceComponent = undefined
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                            else
                                            {
                                                list_bottom.reset_list()
                                                parent.set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                                list_bottom.last_mode = list_index
                                                tiva.configration[modelData] = parent.mode
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "configrationanchors"
                                                load_config.sourceComponent = config_window
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                        }
                                    }
                                    Text {
                                        id: modeinfo_bottom
                                        text: name
                                        font.pixelSize: parent.height * 0.75
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                            model: ModeListBottom {id: modebottom}
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
                                    itemAtIndex(i).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                }
                            }

                            function handle_list(key)
                            {
                                if(key === Qt.Key_Down && current < numberOfMode - 1 && current >= 0)
                                {
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                    }
                                    current++
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                    }
                                }
                                else if(key === Qt.Key_Up && current > 0 && current <= numberOfMode - 1)
                                {
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                    }
                                    current--
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                    }
                                }
                                else if(key === Qt.Key_Enter - 1)
                                {
                                    if(current != last_mode)
                                    {
                                        tiva.configration[modelData] = itemAtIndex(current).mode
                                        tiva.last_pin_mode = tiva.configration[modelData]
                                        itemAtIndex(current).set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                        if(last_mode != -1)
                                        {
                                            itemAtIndex(last_mode).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                        }
                                        last_mode = current
                                        container.state = "configrationanchors"
                                        load_config.sourceComponent = config_window
                                        console.log(tiva_border.pin_name,tiva.configration[modelData])
                                    }
                                    else
                                    {
                                        tiva.configration[modelData] = "NULL"
                                        tiva.last_pin_mode = tiva.configration[modelData]
                                        itemAtIndex(last_mode).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                        last_mode= -1
                                        container.state = "normalanchors"
                                        load_config.sourceComponent = undefined
                                        console.log(tiva_border.pin_name,tiva.configration[modelData])
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
                                pin_name_right.color = tiva_border.pin_text_configured_color
                                return tiva_border.pin_configured_color
                            }
                            else if(mouseright.containsMouse)
                            {
                                pin_name_right.color = tiva_border.pin_text_color
                                return tiva_border.pin_hovered_color
                            }
                            else
                            {
                                pin_name_right.color = tiva_border.pin_text_color
                                return tiva_border.pin_default_color
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
                            text: modelData
                            font.pixelSize: parent.height * 0.4
                            font.family: "Comic Sans MS"
                        }
                        ListView {
                            id: list_right
                            width: parent.width*2
                            height: parent.height*count
                            anchors.left: parent.right
                            Component.onCompleted: {
                                if(modelData == "PB3"){
                                    moderight.remove(4,39)
                                }
                                else if(modelData == "PB4"){
                                    moderight.remove(9,34)
                                    moderight.remove(2,2)
                                }
                                else if(modelData == "PB5"){
                                    moderight.remove(14,29)
                                    moderight.remove(2,7)
                                }
                                else if(modelData == "PB6"){
                                    moderight.remove(17,26)
                                    moderight.remove(2,12)
                                }
                                else if(modelData == "PB7"){
                                    moderight.remove(20,23)
                                    moderight.remove(2,15)
                                }
                                else if(modelData == "PC4"){
                                    moderight.remove(27,16)
                                    moderight.remove(2,18)
                                }
                                else if(modelData == "PC5"){
                                    moderight.remove(34,9)
                                    moderight.remove(2,25)
                                }
                                else if(modelData == "PC6"){
                                    moderight.remove(39,4)
                                    moderight.remove(2,32)
                                }
                                else if(modelData == "PC7"){
                                    moderight.remove(2,37)
                                }
                            }
                            property int numberOfMode: {
                                if(modelData == "PB3"){
                                    return 4;
                                }
                                else if(modelData == "PB6" || modelData == "PB7"){
                                    return 5;
                                }
                                else if(modelData == "PC7"){
                                    return 6;
                                }
                                else if(modelData == "PB4" || modelData == "PB5" || modelData == "PC6"){
                                    return 7;
                                }
                                else if(modelData == "PC4" || modelData == "PC5"){
                                    return 9;
                                }
                            }
                            property int last_mode: -1
                            property int current: 0
                            Component {
                                id: modesDelegateright
                                Rectangle {
                                    width: list_right.width
                                    height: list_right.height/(list_right.count*2)
                                    radius: width/15
                                    border.width: width*0.01
                                    border.color: "black"
                                    property string mode: modeinfo_right.text
                                    function set_color(rect_color,text_color)
                                    {
                                        color = rect_color
                                        modeinfo_right.color = text_color
                                    }
                                    Component.onCompleted: {
                                        color = tiva_border.list_mode_color
                                        modeinfo_right.color = tiva_border.list_text_color
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        acceptedButtons: Qt.LeftButton | Qt.WheelFocus
                                        hoverEnabled: true
                                        onEntered: {
                                            if(list_right.last_mode != list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                            }
                                        }
                                        onExited: {
                                            if(list_right.last_mode != list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                            }
                                        }
                                        onClicked: {
                                            if(list_right.last_mode == -1)
                                            {
                                                parent.set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                                list_right.last_mode = list_index
                                                tiva.configration[modelData] = parent.mode
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "configrationanchors"
                                                load_config.sourceComponent = config_window
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                            else if(list_right.last_mode == list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                                list_right.last_mode = -1
                                                tiva.configration[modelData] = "NULL"
                                                container.state = "normalanchors"
                                                load_config.sourceComponent = undefined
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                            else
                                            {
                                                list_right.reset_list()
                                                parent.set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                                list_right.last_mode = list_index
                                                tiva.configration[modelData] = parent.mode
                                                container.state = "configrationanchors"
                                                load_config.sourceComponent = config_window
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                        }
                                    }
                                    Text {
                                        id: modeinfo_right
                                        text: name
                                        font.pixelSize: parent.height * 0.75
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                            model: ModeListRight {id: moderight}
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
                                    itemAtIndex(i).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                }
                            }

                            function handle_list(key)
                            {
                                if(key === Qt.Key_Down && current < numberOfMode - 1 && current >= 0)
                                {
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                    }
                                    current++
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                    }
                                }
                                else if(key === Qt.Key_Up && current > 0 && current <= numberOfMode - 1)
                                {
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                    }
                                    current--
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                    }
                                }
                                else if(key === Qt.Key_Enter - 1)
                                {
                                    if(current != last_mode)
                                    {
                                        tiva.configration[modelData] = itemAtIndex(current).mode
                                        tiva.last_pin_mode = tiva.configration[modelData]
                                        itemAtIndex(current).set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                        if(last_mode != -1)
                                        {
                                            itemAtIndex(last_mode).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                        }
                                        last_mode = current
                                        container.state = "configrationanchors"
                                        load_config.sourceComponent = config_window
                                        console.log(tiva_border.pin_name,tiva.configration[modelData])
                                    }
                                    else
                                    {
                                        tiva.configration[modelData] = "NULL"
                                        tiva.last_pin_mode = tiva.configration[modelData]
                                        itemAtIndex(last_mode).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                        last_mode= -1
                                        container.state = "normalanchors"
                                        load_config.sourceComponent = undefined
                                        console.log(tiva_border.pin_name,tiva.configration[modelData])
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
                                pin_name_left.color = tiva_border.pin_text_configured_color
                                return tiva_border.pin_configured_color
                            }
                            else if(mouseleft.containsMouse)
                            {
                                pin_name_left.color = tiva_border.pin_text_color
                                return tiva_border.pin_hovered_color
                            }
                            else
                            {
                                pin_name_left.color = tiva_border.pin_text_color
                                return tiva_border.pin_default_color
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
                            text: modelData
                            font.pixelSize: parent.height * 0.4
                            font.family: "Comic Sans MS"
                        }
                        ListView {
                            id: list_left
                            width: parent.width*2
                            height: parent.height*count
                            anchors.right: parent.left
                            Component.onCompleted: {
                                if(modelData == "PE2"){
                                    modeleft.remove(3,42)
                                }
                                else if(modelData == "PE3"){
                                    modeleft.remove(4,41)
                                    modeleft.remove(2)
                                }
                                else if(modelData == "PE4"){
                                    modeleft.remove(10,35)
                                    modeleft.remove(2,2)
                                }
                                else if(modelData == "PE5"){
                                    modeleft.remove(16,29)
                                    modeleft.remove(2,8)
                                }
                                else if(modelData == "PF0"){
                                    modeleft.remove(24,21)
                                    modeleft.remove(2,14)
                                }
                                else if(modelData == "PF1"){
                                    modeleft.remove(31,14)
                                    modeleft.remove(2,22)
                                }
                                else if(modelData == "PF2"){
                                    modeleft.remove(36,9)
                                    modeleft.remove(2,29)
                                }
                                else if(modelData == "PF3"){
                                    modeleft.remove(41,4)
                                    modeleft.remove(2,34)
                                }
                                else if(modelData == "PF4"){
                                    modeleft.remove(2,39)
                                }
                            }
                            property int numberOfMode: {
                                if(modelData == "PE2" || modelData == "PE3"){
                                    return 3;
                                }
                                else if(modelData == "PF4"){
                                    return 6;
                                }
                                else if(modelData == "PF2" || modelData == "PF3"){
                                    return 7;
                                }
                                else if(modelData == "PE4" || modelData == "PE5"){
                                    return 8;
                                }
                                else if(modelData == "PF1"){
                                    return 9;
                                }
                                else if(modelData == "PF0"){
                                    return 10;
                                }
                            }
                            property int last_mode: -1
                            property int current: 0
                            Component {
                                id: modesDelegateleft
                                Rectangle {
                                    width: list_left.width
                                    height: list_left.height/(list_left.count*2)
                                    radius: width/15
                                    border.width: width*0.01
                                    border.color: "black"
                                    property string mode: modeinfo_left.text
                                    function set_color(rect_color,text_color)
                                    {
                                        color = rect_color
                                        modeinfo_left.color = text_color
                                    }
                                    Component.onCompleted: {
                                        color = tiva_border.list_mode_color
                                        modeinfo_left.color = tiva_border.list_text_color
                                    }
                                    MouseArea {
                                        anchors.fill: parent
                                        acceptedButtons: Qt.LeftButton | Qt.WheelFocus
                                        hoverEnabled: true
                                        onEntered: {
                                            if(list_left.last_mode != list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                            }
                                        }
                                        onExited: {
                                            if(list_left.last_mode != list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                            }
                                        }
                                        onClicked: {
                                            if(list_left.last_mode == -1)
                                            {
                                                parent.set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                                list_left.last_mode = list_index
                                                tiva.configration[modelData] = parent.mode
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "configrationanchors"
                                                load_config.sourceComponent = config_window
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                            else if(list_left.last_mode == list_index)
                                            {
                                                parent.set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                                list_left.last_mode = -1
                                                tiva.configration[modelData] = "NULL"
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "normalanchors"
                                                load_config.sourceComponent = undefined
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                            else
                                            {
                                                list_left.reset_list()
                                                parent.set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                                list_left.last_mode = list_index
                                                tiva.configration[modelData] = parent.mode
                                                tiva.last_pin_mode = tiva.configration[modelData]
                                                container.state = "configrationanchors"
                                                load_config.sourceComponent = config_window
                                                console.log(tiva_border.pin_name,tiva.configration[modelData])
                                            }
                                        }
                                    }
                                    Text {
                                        id: modeinfo_left
                                        text: name
                                        font.pixelSize: parent.height * 0.75
                                        anchors.centerIn: parent
                                    }
                                }
                            }
                            model: ModeListLeft {id: modeleft}
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
                                    itemAtIndex(i).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                }
                            }

                            function handle_list(key)
                            {
                                if(key === Qt.Key_Down && current < numberOfMode - 1 && current >= 0)
                                {
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                    }
                                    current++
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                    }
                                }
                                else if(key === Qt.Key_Up && current > 0 && current <= numberOfMode - 1)
                                {
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                    }
                                    current--
                                    if(current != last_mode)
                                    {
                                        itemAtIndex(current).set_color(tiva_border.list_mode_hovered_color,tiva_border.list_text_hovered_color)
                                    }
                                }
                                else if(key === Qt.Key_Enter - 1)
                                {
                                    if(current != last_mode)
                                    {
                                        tiva.configration[modelData] = itemAtIndex(current).mode
                                        tiva.last_pin_mode = tiva.configration[modelData]
                                        itemAtIndex(current).set_color(tiva_border.list_configured_color,tiva_border.list_text_color)
                                        if(last_mode != -1)
                                        {
                                            itemAtIndex(last_mode).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                        }
                                        last_mode = current
                                        container.state = "configrationanchors"
                                        load_config.sourceComponent = config_window
                                        console.log(tiva_border.pin_name,tiva.configration[modelData])
                                    }
                                    else
                                    {
                                        tiva.configration[modelData] = "NULL"
                                        tiva.last_pin_mode = tiva.configration[modelData]
                                        itemAtIndex(last_mode).set_color(tiva_border.list_mode_color,tiva_border.list_text_color)
                                        last_mode= -1
                                        container.state = "normalanchors"
                                        load_config.sourceComponent = undefined
                                        console.log(tiva_border.pin_name,tiva.configration[modelData])
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
                                if(tiva_border.height <= 375)
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
                                if(tiva_border.height >= 200)
                                {
                                    tiva_border.height -= 10
                                    tiva_border.width -= 10
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
