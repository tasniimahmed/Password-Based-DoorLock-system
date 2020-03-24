import QtQuick 2.12
import QtQuick.Controls 2.12

ComboBox {
    id:boudrate
    delegate: ItemDelegate {
        width: boudrate.width
        height: boudrate.height
        contentItem: Text {
            text: modelData
            color: "orange"
            font: boudrate.font
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        highlighted: boudrate.highlightedIndex === index
    }

    indicator: Canvas {
        id: canvas
        x: boudrate.width - width - boudrate.rightPadding
        y: boudrate.topPadding + (boudrate.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"
        Connections {
            target: boudrate
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = boudrate.pressed ? "orange" : "dark red";
            context.fill();
        }
    }

    contentItem: Text {
        leftPadding: 0
        rightPadding: boudrate.indicator.width + boudrate.spacing
        text: boudrate.displayText
        font: boudrate.font
        color: boudrate.pressed ? "dark red" : "orange"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 25
        color: "black"
        border.color: boudrate.pressed ? "dark red" : "orange"
        border.width: boudrate.visualFocus ? 2 : 1
        radius: 5
    }

    popup: Popup {
        y: boudrate.height - 1
        width: boudrate.width
        implicitHeight: contentItem.implicitHeight
        padding: 1

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: boudrate.popup.visible ? boudrate.delegateModel : null
            currentIndex: boudrate.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator { }
        }

        background: Rectangle {
            id: background
            border.color: "dark red"
            radius: 2
        }
    }
}
