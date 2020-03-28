import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.14
import QtLocation 5.14
TreeView {
    model: fileSystemModel
    id : tree
    style: TreeViewStyle {backgroundColor: "#393e46" }
    TableViewColumn{title: "File System"; role:"fileName" ;width: parent.width ;}

    alternatingRowColors: true
//    anchors.fill: parent
    verticalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
    headerVisible: false

    property string selectColor: "#b55400"
    property string lightGreyColor: "#eeeeee"
    property string darkGreyColor: "#222831"
    property string middleGreyColor: "#393e46"

    // signal to add the content of the opened file into a new tab for TabView
    signal addTab(string titleTab,string textContent)

    // Style
    rowDelegate: Rectangle {
        color: (styleData.selected) ? tree.selectColor : ( styleData.row % 2 == 0 ) ? tree.middleGreyColor : tree.darkGreyColor
        height: 50
    }

    itemDelegate: Rectangle {
        id :item
        color: (styleData.selected) ? tree.selectColor : ( styleData.row % 2 == 0 ) ? tree.middleGreyColor : tree.darkGreyColor
        Text {
            text: styleData.value
            color: (styleData.selected) ? "white" : tree.lightGreyColor
        }
        Image {
            source: "icons/folder3.png"
            width: 25
            height: 25
            visible: (styleData.hasChildren)
            x: -width
        }
    }

    onDoubleClicked: {
        openTabFromFile();
        expandCollapseFolder();
    }


    function openTabFromFile()
    {
        var sucess = Controller.fileSelected(currentIndex);
        if(sucess)
        {
            var content = Controller.getFileContent();
            var fileName = Controller.getFileName();
            //                console.log(fileName,content);
            addTab(fileName,content);
        }
    }


    function expandCollapseFolder(){
        if (tree.isExpanded(currentIndex))
            tree.collapse(currentIndex)
        else
            tree.expand(tree.currentIndex);
    }


    // TODO , expandAll is not Ray2
    Component.onCompleted:{ tree.expandAll();}
    function expandAll() {
        // rowCount just dosn't work, it is a lazy count, QFileSystem model is not ray2 and uses another thread to count the rows
        var n = 20; console.log("n=",n,fileSystemModel.columnCount());
        for (var i = 0 ; i < n; i++)
        {
            var index = tree.indexAt(i,0);
            tree.expand(index);
        }
    }
}
