import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    property alias victory: victory_Dialog
    property alias defeat: defeat_Dialog
    anchors.fill: parent
    property alias pause: _pause
    //测试：
    property alias music: _music
    property bool musicEnabled: true  // 用于跟踪音效状态的属性

    Timer{
        id:timer
        interval:1000
        running:true
        repeat: true
        property int bossblood_6: 3

        onTriggered: {
            bossblood_6--;
            if(bossblood_6 === 0){
                //defeat_Dialog.open();
                victory_Dialog.open();
                blurRect.visible = true;
                timer.stop();
            }
        }
    }

    //暂停建点击触发的弹窗（重新开始 继续游戏 退出游戏 音效建）
    Dialog{
        id: _pause
        width: 280;height: 350
        anchors.centerIn: parent
        modal: true

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
            }
        }
    }

    //游戏结束时弹窗
    Rectangle{
        id: blurRect
        anchors.fill: parent
        visible: false                  //遮罩层初始不可见，仅在弹窗时显示
        color:"dimgray"                 //设置为灰色背景
        opacity: 0.9                    //设置透明度

        //游戏胜利弹窗
        Dialog{
            id:victory_Dialog
            width: 410
            height:210
            background:Rectangle{               //设置弹窗背景透明
                opacity: 0
            }

            anchors.centerIn: parent            //弹窗居中

            contentItem: Column{
                width: parent.width
                height: parent.height
                Image {
                    source: "images/victory.png"
                    width: 384
                    height: 182
                    anchors.centerIn: parent
                }
            }
        Row{
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 100
            Button{
                text: "返回"
                onClicked: {
                    victory_Dialog.visible = false;
                    blurRect.visible = false;
                }
            }
            Button{
                text: "下一关"
                onClicked: {
                    blurRect.visible = false;
                    victory_Dialog.visible = false
                    }
                }
            }
        }

        //游戏失败弹窗
        Dialog{
            id:defeat_Dialog
            width: 410
            height: 210
            background:Rectangle{
                opacity: 0
            }

            anchors.centerIn: parent

            contentItem: Column{
                width: parent.width
                height: parent.height
                Image {
                    source: "images/defeat.png"
                    width: 400
                    height: 182
                    anchors.centerIn: parent
                }
            }
            Row{
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 100
                Button{
                    text: "返回"
                    onClicked: {
                        defeat_Dialog.visible = false;
                        blurRect.visible = false;
                    }
                }
                Button{
                    text: "重新开始"
                    onClicked: {
                        defeat_Dialog.visible = false;
                        blurRect.visible = false;
                    }
                }
            }
        }
    }
}

