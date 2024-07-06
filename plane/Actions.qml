import QtQuick
import QtQuick.Controls

Item {
       property alias restartAction: _restart
       property alias continueAction: _continue
       property alias exitAction: _exit
       property alias musicAction: _music
       // property alias closemusicAction: _closemusic
       property alias start: _start

        Action{
            id:_restart
            text: qsTr("重新开始")
            icon.name: "system-reboot"
        }
        Action{
            id:_continue
            text: qsTr("继续游戏")
            icon.name: "media-playback-start"
        }
        Action{
            id:_exit
            text: qsTr("退出游戏")
            icon.name: "system-shutdown-panel-restart"
        }
        Action{
            id:_music
            text: qsTr("关闭音效")
            icon.name: "audio-volume-change"
        }
        Action{
            id:_start
            text: "开始游戏"
        }
}
