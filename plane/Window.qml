import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    property int window_Width: 960
    property int window_Height: 540
    maximumWidth: window_Width
    minimumWidth: window_Width
    maximumHeight: window_Height
    minimumHeight: window_Height
    visible: true
    title: qsTr("飞机大战")
    // 设置背景颜色为白色
    color: "white"


    Actions{
        id:actions        
    }

    Dialogs{
        id:dialogs
        anchors.fill: parent
    }

    Content{
        id: content
        anchors.fill: parent

    }
}



