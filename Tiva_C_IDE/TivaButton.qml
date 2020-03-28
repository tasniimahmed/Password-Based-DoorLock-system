import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls 2.14
import QtQuick.Controls.Styles 1.4

RoundButton {
    id : open
    Layout.preferredWidth: iconWidth
    Layout.preferredHeight: iconHeight
    anchors.margins: iconMargin
    property string imageSource: ""
    signal click()
    Image {
        source: imageSource
        anchors.fill: parent
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: open.scale = 1.1;
        onExited: open.scale = 1;
        onClicked :open.click();
    }
}
