import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.4

Tab {
    id:tab
    // to make the textArea Follows it
    property string textAreaContent: textArea.text

    TextArea {
        id:textArea
        anchors.fill: parent
        text: parent.textAreaContent

        style: TextAreaStyle {
            backgroundColor: "#222831"
            textColor: "#eeeeee"
            selectionColor: "#b55400"
            selectedTextColor: "#eeeeee"
            font: { font.family = "Helvetica"; font.pointSize = 13;}

        }
        onTextChanged: {textAreaContent = textArea.text;  console.log(textAreaContent);}
        onFocusChanged:  {textAreaContent = textArea.text; console.log(textAreaContent);}
    }
}
