import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {

    property alias pause: _pause
    anchors.fill: parent
    //暂停建点击触发的弹窗（重新开始 继续游戏 退出游戏 音效建）
    Dialog{
        id: _pause
        width: 280;height: 350
        anchors.centerIn: parent

        Column{
            // anchors.fill: parent
            anchors.centerIn: parent
            spacing: 15
            Button{
               id:_restart
               width: 200; height: 65
               anchors.horizontalCenter: parent.horizontalCenter
               action: actions.restartAction
               onClicked: {
               console.log("重新开始游戏")
           }
            }
            Button{
               id: _continue
               width: 200; height: 65
               anchors.horizontalCenter: parent.horizontalCenter
               action: actions.continueAction
               onClicked: {
                   console.log("继续游戏")
               }
            }
            Button{
                id:_exit
                width: 200; height: 65
                anchors.horizontalCenter: parent.horizontalCenter
                action: actions.exitAction
                onClicked: {
                    console.log("退出游戏")
                }
             }
            Button{
               id:_music
               width: 200; height: 65
               action: actions.musicAction
               anchors.horizontalCenter: parent.horizontalCenter
               onClicked: {
                   console.log("音效开启/关闭")
               }
            }
        }
    }
}

