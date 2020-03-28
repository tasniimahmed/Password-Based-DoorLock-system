import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 1.3
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3
import QtQuick.Controls 2.14
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

ApplicationWindow {
    visible: true
    width: 1280
    height: 900
    title: qsTr("TIVA C  IDE")

    FileDialog {
        id:dialog
        selectFolder: false;    selectMultiple: false;
        nameFilters: [ "files (*.txt *.cpp *.c *.h)" ]
    }

    Component.onCompleted: {
        tabWidget.scale=0; dirView.opacity=0; toolBar.opacity=0;
        startupAnimation.start();
        pause.start();
        dirView.opacity=1; toolBar.scale=1;
        pause.start();
        parallel.start();
        //        ray2.start()
    }

    Rectangle {
        id : rectAnimation
        color: "#393e46";
        anchors.fill: parent
        opacity: 1;
        scale: 1;
        Text {
            id: textAnimation
            text: qsTr("TIVA C % Ray2")
            anchors.centerIn: parent
            color: "#eeeeee"
            font.pixelSize: 60
            font.bold: true
            opacity: 0
        }
    }

    SequentialAnimation {
        id:startupAnimation
        // text animation
        NumberAnimation {target: textAnimation;property: "opacity";duration: 1500;easing.type: Easing.OutBounce;from:0;to:1;}
        PauseAnimation {duration: 500}
        NumberAnimation {target: textAnimation;property: "opacity";duration: 800;easing.type: Easing.InOutQuad;from:1;to:0;}

        PauseAnimation {duration: 500}
        ParallelAnimation {
            id:parallel
            NumberAnimation {
                id: tab_animation;
                target: tabWidget;
                property: "scale";
                duration: 1200;
                easing.type: Easing.OutBounce;
                from : 0 ; to : 1;
            }
            NumberAnimation {
                target: toolBar
                property: "x"
                duration: 1000
                easing.type: Easing.InOutSine
                from : toolBar.x - toolBar.width ; to : toolBar.x;
            }
            NumberAnimation {
                target: dirView
                property: "x"
                duration: 1000
                easing.type: Easing.InOutSine
                from : dirView.x-dirView.width; to: dirView.x;
            }

            NumberAnimation {
                targets: [dirView,toolBar]
                properties: "opacity"
                duration: 1; from :0; to : 1;
            }
        }
    }
    GridLayout {
        anchors.top: header.bottom
        anchors.fill: parent
        id: grid
        rows:2
        columns:4
        rowSpacing: 0; columnSpacing: 0;


        TivaToolBar{
            id:toolBar

            Layout.row: 0
            Layout.column: 0
            Layout.rowSpan: 1
            Layout.columnSpan: 4
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 70
        }

        DirectoryView {
            id : dirView

            Layout.row: 1
            Layout.column: 0
            Layout.fillHeight: true
            Layout.columnSpan:  1
            Layout.preferredWidth: 300
        }

        TabEditor {
            id : tabWidget

            Layout.row: 1
            Layout.column: 1
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    Connections {
        target: dirView
        function onAddTab(titleTab,textContent) {tabWidget.newTab(titleTab,textContent);}
    }
    Connections {
        target: Controller
        function onAddTab(titleTab,textContent) {tabWidget.newTab(titleTab,textContent);}
    }
    Connections {
        target: toolBar
        onSaveFile: {dialog.open();}
    }
    Connections {
        target: dialog
        onAccepted : {Controller.saveFile(dialog.fileUrl,tabWidget.getCurrentText()); console.log("saved::::",tabWidget.getCurrentText()) ;}
    }

}
