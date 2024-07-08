import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
ApplicationWindow {
    property int window_Width: 960
    property int window_Height: 540
    property alias bgm: bgm
    maximumWidth: window_Width
    minimumWidth: window_Width
    maximumHeight: window_Height
    minimumHeight: window_Height
    visible: true
    title: qsTr("飞机大战")
    // 设置背景颜色为白色
    color: "white"

    Bgm{
        id:bgm
    }

    Actions {
        id: actions
        musicAction.onTriggered: {
            content.dialogs.musicEnabled = !content.dialogs.musicEnabled; // 切换音效状态
            actions.musicAction.icon.name = content.dialogs.musicEnabled ?
                                            "audio-volume-change" : "audio-volume-muted-symbolic";
            actions.musicAction.text = content.dialogs.musicEnabled ?
                                       qsTr("关闭音效") : qsTr("开启音效");
            if (content.dialogs.musicEnabled) {
                bgm.gameMusic.play();
                console.log("音效开启,gameMusic.playing:", bgm.gameMusic.playing);
            } else {
                bgm.gameMusic.stop();
                console.log("音效关闭,gameMusic.playing:", bgm.gameMusic.playing);
            }
        }
    }


    Content{
        id: content
        anchors.fill: parent

    }
}



