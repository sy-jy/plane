import QtQuick
import QtQuick.Controls

Item {
    property alias enemyboom: enemyboom
    property alias bossboom: bossboom

    // 触发爆炸动画的函数
    function enemyExplosion() {
      if (!enemyboom.running) {
          enemyboom.running = true
          enemyboom.visible = true
          enemyboom.start()
      }
    }

    function bossExplosion() {
      if (!bossboom.running) {
          bossboom.running = true
          bossboom.visible = true
          bossboom.start()
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
             frameX: 600; frameY: 50; frameWidth: 85; frameHeight: 85; frameDuration: 115
            to: {"boom5":1}
        }
        Sprite{
            name: "boom5"; source: "images/enemyboom.png"
             frameX: 500; frameY: 50; frameWidth: 85; frameHeight: 85; frameDuration: 115
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
            to: {"boom3":1}
        }
        Sprite{
            name: "boom3"; source: "images/Bossboom2.png"
            frameCount:1; frameX:1000
        }
    }

}
