import QtQuick
import QtQuick.Controls

Item {
    property alias enemyboom: enemyboom
    property alias bossboom: bossboom
    property alias enemyboomTime: _enemyboom
    property alias bossboomTime: _bossboom
    property alias bossBoomTime: bossvictory

    //敌机爆炸动画运行
    function enemyExplosion() {
      if (!enemyboom.running) {
          enemyboom.running = true
          enemyboom.visible = true
          enemyboomTime.start()
      }
    }

    // boss爆炸动画运行
    function bossExplosion() {
      if (!bossboom.running) {
          bossboom.running = true
          bossboom.visible = true
          bossboomTime.start()
      }
    }


    SpriteSequence {
        running :false
        visible: false
        id: enemyboom
        width: 90; height: 85; goalSprite: "boom1"
        Sprite{
            name: "boom1"; source: "images/enemyboom.png"
             frameX:35 ;frameY: 60; frameWidth: 85; frameHeight: 85; frameDuration: 115
            to: {"boom2":1}
        }
        Sprite{
            name: "boom2"; source: "images/enemyboom.png"
             frameX: 225; frameY: 55; frameWidth: 85; frameHeight: 85; frameDuration: 115
            to: {"boom3":1}
        }
        Sprite{
            name: "boom3"; source: "images/enemyboom.png"
             frameX: 410; frameY: 50; frameWidth: 85; frameHeight: 85; frameDuration: 115
            to: {"boom4":1}
        }
        Sprite{
            name: "boom4"; source: "images/enemyboom.png"
            frameCount:1; frameX: 600; frameY: 50; frameWidth: 85; frameHeight: 85; frameDuration: 115
            // to: {"boom5":1}
        }
    }

    SpriteSequence {
        running: false
        visible: false
        id: bossboom; width: 305; height: 360; goalSprite: "boom1"
        Sprite{
            name: "boom1"; source: "images/Bossboom.png"
            frameCount:5;frameWidth: 190; frameHeight: 220; frameDuration: 300
            to: {"boom2":1}
        }
        Sprite{
            name: "boom2"; source: "images/Bossboom2.png"
            frameCount:5; frameWidth: 187; frameHeight: 200; frameDuration: 300
            // to: {"boom3":1}
        }
    }

    //让敌机爆炸后动画只执行一次
    Timer{
        id: _enemyboom
        interval: 200
        running: false
        repeat: false
        onTriggered: {
            enemyboom.running = false
            enemyboom.visible = false
        }
    }

    //让boss爆炸一次后就结束动画
    Timer{
        id: _bossboom
        interval: 600
        running: false
        repeat: false
        onTriggered: {
            bossboom.running = false
            bossboom.visible = false
        }
    }

    //boss击败后 等待爆炸动画结束后在弹出胜利窗口
    Timer{
        id: bossvictory
        interval: 800
        running: false
        onTriggered: {
            stopGame()
            easy.checked?dialogs.victory.open():dialogs.victory2.open();
            dialogs.blurRect.visible = true;
            bgm.game_victoryMusic.play()
            gameover_timer.stop();
        }
    }
}
