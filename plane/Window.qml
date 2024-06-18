import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    property int window_Width: 512
    property int window_Height: 768
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

    Content {
        id: content
        anchors.fill: parent
    }
}