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

    property alias blurRect:_blurRect
    property alias bossAppearTimer:_boss_appearTimer                    //boss出场计时器

    property alias setting: setting

    Dialog{
        id:setting
        width: window_Width/2
        height: window_Height/2
        anchors.centerIn: parent
        modal: true
        Column {
            anchors.centerIn: parent
            spacing: window_Height/10
            Text {
                text: qsTr(" 设置")
                font.letterSpacing: window_Width/12
                font.pointSize: 20
                font.bold: true
                color: "white"
            }
            Rectangle{
                id:musicVolume
                width: window_Width/3
                height: window_Height/25
                color:"transparent"
                Row{
                    spacing: window_Width/35
                    Text {
                        text: "背景音乐"
                        font.pointSize: 12
                        font.bold: true
                        color: "white"
                    }
                    // 音量滑块
                    Slider {
                        id: musicSlider
                        focus: true
                        from: 0
                        to: 100
                        value: 100 // 初始值与音频播放器的音量一致
                        onFocusChanged: bgm.focusSound.play()
                        // 添加一个视觉指示器来表示Slider是否获得焦点
                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            visible: musicSlider.focus // 仅在Slider获得焦点时可见

                            // 当Slider获得焦点时的背景颜色
                            border.color: musicSlider.focus ? "white" : "transparent"
                            border.width: musicSlider.focus ? 2 : 0
                        }
                        onValueChanged: {
                            // 当滑块值变化时，更新音频播放器的音量
                            bgm.gameVolume.volume = musicSlider.value/100
                            bgm.testMusicVolume.volume = musicSlider.value/100
                            bgm.testMusic.play()
                            console.log(bgm.gameVolume.volume)
                            // audioPlayer.volume = volumeSlider.value
                        }

                        contentItem: Rectangle {
                            width: musicSlider.value/musicSlider.to*window_Width/6
                            height: musicVolume.height
                            color: "red"
                        }
                        background: Rectangle {
                            implicitWidth: window_Width/6
                            implicitHeight: musicVolume.height
                            color: "transparent" // 进度条背景的颜色
                        }
                        handle: null
                    }
                    Keys.onPressed: (event) => {
                            if (event.key === Qt.Key_A) {
                                // 按下A键，音量减少
                                musicSlider.value -= 5
                            } else if (event.key === Qt.Key_D) {
                                // 按下D键，音量增加
                                musicSlider.value += 5
                            }else if (event.key === Qt.Key_W) {
                                // 按下W键，切换焦点
                                musicSlider.focus = true
                                soundSlider.focus = false
                            }else if (event.key === Qt.Key_S) {
                                // 按下S键，切换焦点
                                musicSlider.focus = false
                                soundSlider.focus = true
                            }

                        }

                    // 显示当前音量
                    Text {
                        text:  musicSlider.value
                        font.pointSize: 12
                        font.bold: true
                        color: "white"
                    }
                }
            }
            Rectangle{
                id:soundVolume
                width: window_Width/3
                height: window_Height/25
                color:"transparent"
                Row{
                    spacing: window_Width/35
                    Text {
                        text: "游戏音效"
                        font.pointSize: 12
                        font.bold: true
                        color: "white"
                    }
                    // 音量滑块
                    Slider {
                        id: soundSlider
                        from: 0
                        to: 100
                        value: 100 // 初始值与音频播放器的音量一致
                        // 添加一个视觉指示器来表示Slider是否获得焦点
                        Rectangle {
                            anchors.fill: parent
                            color: "transparent"
                            visible: soundSlider.focus // 仅在Slider获得焦点时可见

                            // 当Slider获得焦点时的背景颜色
                            border.color: soundSlider.focus ? "white" : "transparent"
                            border.width: soundSlider.focus ? 2 : 0
                        }
                        onValueChanged: {
                            // 当滑块值变化时，更新音频播放器的音量
                            bgm.testSoundVolume.volume = soundSlider.value/100
                            bgm.testSound.play()
                            bgm.life_loseMusicVolume.volume = soundSlider.value/100
                            bgm.upAmmoVolume.volume = soundSlider.value/100
                            bgm.game_defeatMusicVolume.volume = soundSlider.value/100
                            bgm.shoot_1_MusicVolume.volume = soundSlider.value/100
                            bgm.shoot_2_MusicVolume.volume = soundSlider.value/100
                            bgm.focusSoundVolume.volume = soundSlider.value/100

                        }

                        contentItem: Rectangle {
                            width: soundSlider.value/soundSlider.to*window_Width/6
                            height: soundVolume.height
                            color: "red"
                        }
                        background: Rectangle {
                            implicitWidth: window_Width/6
                            implicitHeight: soundVolume.height
                            color: "transparent" // 进度条背景的颜色
                        }
                        handle: null
                    }
                    Keys.onPressed: (event) => {
                            if (event.key === Qt.Key_A) {
                                // 按下A键，音量减少
                                soundSlider.value -= 5
                            } else if (event.key === Qt.Key_D) {
                                // 按下D键，音量增加
                                soundSlider.value += 5
                            }else if (event.key === Qt.Key_W) {
                                // 按下W键，切换焦点
                                musicSlider.focus = true
                                soundSlider.focus = false
                            }else if (event.key === Qt.Key_S) {
                                // 按下S键，切换焦点
                                musicSlider.focus = false
                                soundSlider.focus = true
                            }

                        }

                    // 显示当前音量
                    Text {
                        text:  soundSlider.value
                        font.pointSize: 12
                        font.bold: true
                        color: "white"
                    }
                }
            }
        }
    }

    function reset(){
        //重置我方战机位置
        myplane.plane_1_X = (window_Width-myplane.myplane_Width)/9
        myplane.plane_1_Y = window_Height-myplane.myplane_Height
        myplane.plane_2_X = (window_Width-myplane.myplane_Width)/9*8
        myplane.plane_2_Y = window_Height-myplane.myplane_Height
        myplane.planeX = (window_Width-myplane.myplane_Width)/2
        myplane.planeY = window_Height-myplane.myplane_Height
        //重置护盾
        myplane.shield_1.activateShield()//开局护盾
        myplane.shield_1_FadeAnimation.stop()
        if(content.isDouble){
            myplane.shield_2.activateShield()//开局护盾
            myplane.shield_2_FadeAnimation.stop()
        }
        //重置生命
        myplane.isSurvive_1 = true
        myplane.isSurvive_2 = true
        content.remainlife_1 = myplane.lives-1
        if(content.isDouble){
            content.bloodProgress_1.value = myplane.blood
            content.bloodProgress_2.value = myplane.blood
            content.remainlife_2 = myplane.lives-1
            for(var i = 0;i<content.lifeModel_1.count;i++){
                content.lifeModel_1.get(i).visible = true
            }
            for(i = 0;i<content.lifeModel_2.count;i++){
                content.lifeModel_2.get(i).visible = true
            }
            //重置boss血量条
            content.bossbloodProgress2.visible = false
            content.bossbloodProgress2.value = 1000
        }else{
            content.bloodProgress.value = myplane.blood
            for(i = 0;i<content.lifeModel.count;i++){
                content.lifeModel.get(i).visible = true
            }
            //重置boss血量条
            content.bossbloodProgress1.visible = false
            content.bossbloodProgress1.value = 1000
        }

        //重置道具生成冷却时长
        content.itemUpdateCounter = 0
        items.item.visible = false

        //清除冲击波
        myplane.stopBomb()

        bullet.isShooted_boss = false
        bullet.isShooted_enemy = false
        bullet.cleanBullt()
        enemys.bossAppeared = false
        enemys.destroyEnemy()
        enemys.destroyBoss()
    }

    function returnhome(){
        map.visible = false      //地图显示
        enemys.visible = false
        myplane.myplane_1.visible = false
        if(content.isDouble){
            myplane.myplane_2.visible = false
            content.doublegamelayout.visible = false
        }else{
            content.singalgamelayout.visible = false
        }
        reset()
        bgm.gameMusic.stop()
        content.stackview.popToIndex(0)
        //重置模式选择
        content.mode.defaultOption()
        //重置选框
        content.currentIndexWSAD = -1
        content.currentIndexArrows = -1
        content.plane.recreateHighlights()
    }

    function restartGame(){
        console.log("重新开始游戏")
        reset()
        myplane.shield_1_Timer.restart()
        if(content.isDouble){
            myplane.shield_2_Timer.restart()
        }
        content.gameover_timer.start()
        enemys.gameTime.start()
        enemys.bossTime.start()
        dialogs.bossAppearTimer.start()
        content.timer.start()
    }

    //暂停建点击触发的弹窗（重新开始 继续游戏 退出游戏 音效建）
    Dialog{
        id: _pause
        width: 280;height: 350
        anchors.centerIn: parent
        modal: true
        closePolicy: Popup.NoAutoClose
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
                   restartGame()
                   pause.close()
               }
            }
            Button{
               id: _continue
               width: 200; height: 65
               anchors.horizontalCenter: parent.horizontalCenter
               action: actions.continueAction
               onClicked: {
                   console.log("继续游戏")
                   myplane.shield_1_Timer.start()
                   myplane.shield_1_FadeAnimation.resume()
                   myplane.shield_2_Timer.start()
                   myplane.shield_2_FadeAnimation.resume()
                   myplane.resumeBomb()
                   enemys.gameTime.start()
                   enemys.bossTime.start()
                   content.timer.start()
                   pause.close()
               }
            }
            Button{
                id:_exit
                width: 200; height: 65
                anchors.horizontalCenter: parent.horizontalCenter
                action: actions.exitAction
                onClicked: {
                    returnhome()
                    pause.close()
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
        id: _blurRect
        anchors.fill: parent
        visible: false                  //遮罩层初始不可见，仅在弹窗时显示
        color:"dimgray"                 //设置为灰色背景
        opacity: 0.9                    //设置透明度

        //游戏胜利弹窗
        Dialog{
            id:victory_Dialog
            width: 410
            height:210
            closePolicy: Popup.NoAutoClose
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
                    _blurRect.visible = false;
                    returnhome()
                }
            }
            Button{
                text: "下一关"
                onClicked: {
                    _blurRect.visible = false;
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
            closePolicy: Popup.NoAutoClose
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
                        _blurRect.visible = false;
                        returnhome()
                    }
                }
                Button{
                    text: "重新开始"
                    onClicked: {
                        defeat_Dialog.visible = false;
                        _blurRect.visible = false;
                        restartGame()

                    }
                }
            }
        }
    }

    Dialog{
        id:_boss_appear
        width: 250
        height: 50
        focus: false
        background:Rectangle{
            opacity: 0
        }
        anchors.centerIn: parent
        contentItem: Column{
            width: parent.width
            height: parent.height
            Image {
                source: "images/boss_2.png"
                width: 240
                height: 40
                anchors.centerIn: parent
            }
        }
    }

    Timer{
        id:_boss_appearTimer
        interval: 8000
        running: true
        onTriggered:{
            _boss_appear.open()
            _closeTimer.start()
        }
    }
    Timer{
        id:_closeTimer
        interval: 2000
        running: false
        onTriggered: {
            _boss_appear.close()
            _closeTimer.stop()
        }
    }
}

