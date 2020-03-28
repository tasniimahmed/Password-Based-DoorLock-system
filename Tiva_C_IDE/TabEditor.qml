import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
TabView {
    id: tabView
    property string orangeColor: "#b55400"
    property string lightGreyColor: "#eeeeee"
    property string darkGreyColor: "#222831"
    property string middleGreyColor: "#393e46"
    property var openedTabs: []
    property string currentText: ""

    style: TabViewStyle{
        tabsMovable: true
        frameOverlap: 1  // the amount of overlap there are between individual tab buttons.
        tabBar: Rectangle{ color: middleGreyColor }
        tab : Rectangle {
            id:text
            implicitHeight: (styleData.selected) ? 43 : 40
            implicitWidth: Math.max(titleTab.contentWidth+ 20 , 150)
            radius: 3
            color: (styleData.hovered || styleData.selected) ? orangeColor :lightGreyColor

            RowLayout {
                anchors.fill: parent

                Rectangle {
                    id :icon
                    Layout.preferredHeight: text.height
                    Layout.preferredWidth: 15
                    color: text.color
                }

                Rectangle {
                    id : textContainer
                    Layout.preferredWidth: text.width - exitBtn.width
                    Layout.preferredHeight : text.height
                    Layout.fillWidth: true
                    color: text.color

                    Text {
                        id: titleTab
                        text: styleData.title
                        color: (styleData.hovered || styleData.selected) ? lightGreyColor :middleGreyColor
                        anchors.centerIn: parent
                        wrapMode: Text.Wrap
                    }
                }
                Rectangle {
                    Layout.preferredWidth: 15
                    Layout.preferredHeight: 15
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: 10
                    color: text.color

                    RoundButton {
                        id:exitBtn
                        text: "x"
                        anchors.fill:parent
                        onClicked: { if (styleData.selected)  tabView.removeTab(tabView.currentIndex)}
                    }
                }
            }
        }
    }


//    onCurrentIndexChanged: {tabView.currentText = tabView.getTab(currentIndex).textAreaContent;}
    function getCurrentText()
    {
        return tabView.getTab(currentIndex).textAreaContent;
    }

    function newTab(titleTab,textContent)
    {
        var componentEditor = Qt.createComponent("Editor.qml");
        var ray2 = componentEditor.createObject(tabView, {title:titleTab, textAreaContent:textContent});
    }
}
