import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    id:combobox
    delegate: ItemDelegate {
        width: combobox.width
        height: combobox.height
        contentItem: Text {
            text: modelData
            color: "dark red"
            font: combobox.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        highlighted: combobox.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        x: combobox.width - width - combobox.rightPadding
        y: combobox.topPadding + (combobox.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"
        Connections {
            target: combobox
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = combobox.pressed ? "orange" : "dark red";
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: combobox.indicator.width + combobox.spacing
        text: combobox.displayText
        font: combobox.font
        color: combobox.pressed ? "dark red" : "orange"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 25
        color: "black"
        border.color: combobox.pressed ? "dark red" : "orange"
        border.width: combobox.visualFocus ? 2 : 1
        radius: 5
    }

    popup: Popup {
        y: combobox.height - 1
        width: combobox.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: combobox.popup.visible ? combobox.delegateModel : null
            currentIndex: combobox.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            id: background
            border.color: "orange"
            radius: 2
        }
    }
}
